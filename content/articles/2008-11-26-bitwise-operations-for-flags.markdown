---
layout: post
title: Bitwise operations for flags
tags:
- java
---

Yep, this is basic, really basic! But currently I'm sitting in front of some 
Java code I've to maintain and it looks like this:

{% highlight java %}
public final class SearchConstants {
  public static final int FLAG_FOO = 1 << 0;
  public static final int FLAG_BAR = 1 << 1;
  public static final int FLAG_BAZ = 1 << 2;
}

int flags = SearchConstants.FLAG_FOO | SearchConstants.FLAG_BAR;

public void search(int flags) {
  if ( ((flags & SearchConstants.FLAG_FOO) != 0) && ((flags & SearchConstants.FLAG_BAZ) == 0) ) {
    ...
  }
}
{% endhighlight %}

I simplified the example, reduced the number of available flags from 25 to 3, 
and used a single `if` statement. But even if the code would look exaclty as 
above imagine these statements everywhere! In my opinion the pros and cons are:

Pros:
* fast and small footprint
* no special JRE version needed
* combine flags with `|`

Cons:
* readability, long statements are confusing!
* flags are not type-safe
* shifting flag index

Maybe I'm lazy, but I've really problems reading this. Further the project was 
lacking test-cases, so adding new features (and flags) was even more painful!
As I've become the man in charge, I decided to start a refactoring! I came up
with the following options:

# BitSet

{% highlight java %}
private static final int HOT     = 0;
private static final int FRESH   = 1;
private static final int PREMIUM = 2;

@Test
public void testBitSet() throws Exception {
  BitSet flags = new BitSet(3);

  // set
  flags.set(FRESH);
  flags.set(PREMIUM);

  // flip and clear
  flags.flip(HOT);
  flags.clear(PREMIUM);

  // get
  assertTrue(flags.get(HOT));
  assertTrue(flags.get(FRESH));
  assertFalse(flags.get(PREMIUM));
}
{% endhighlight %}


# EnumSet

{% highlight java %}
private static enum Flag {
  HOT, FRESH, PREMIUM
};

@Test
public void testEnumSet() throws Exception {
  EnumSet<Flag> flags = EnumSet.noneOf(Flag.class);

  // set
  flags.add(Flag.FRESH);
  flags.add(Flag.PREMIUM);

  // flip and clear
  if (flags.contains(Flag.HOT)) {
    flags.remove(Flag.HOT);
  } else {
    flags.add(Flag.HOT);
  }
  flags.remove(Flag.PREMIUM);

  // get
  assertTrue(flags.contains(Flag.HOT));
  assertTrue(flags.contains(Flag.FRESH));
  assertFalse(flags.contains(Flag.PREMIUM));
}
{% endhighlight %}


# Own class

{% highlight java %}
private static class Flags {
  private int bits;

  public boolean isSet(int flag) {
    return (bits & (1 << flag)) != 0;
  }

  public void set(int flag) {
    bits = (bits | (1 << flag));
  }

  public void unset(int flag) {
    bits = (bits & ~(1 << flag));
  }

  public void toggle(int flag) {
    bits = (bits ^ (1 << flag));
  }
}

@Test
public void testOwnClass() throws Exception {
  Flags flags = new Flags();

  // set
  flags.set(FRESH);
  flags.set(PREMIUM);

  // flip and clear
  flags.toggle(HOT);
  flags.unset(PREMIUM);

  // get
  assertTrue(flags.isSet(HOT));
  assertTrue(flags.isSet(FRESH));
  assertFalse(flags.isSet(PREMIUM));
}
{% endhighlight %}



Actually I like `BitSet`. It's easy, small and perfect in my case.


