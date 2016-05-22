---
title: Mocking a single method with PowerMock
tags:
- java
- powermock
---

Let's say this is the Bean under test. Here the method `convert()` is not 
implemented. But it could also fire up calls to some remote system DB or be just 
to complex. In any case, we want to test `say()`.

{% highlight java %}
public class Bean {

   public String say(String name) {
      return "Hi, " + convert(name) + "!";
   }
   
   protected String convert(String name) {
      throw new UnsupportedOperationException("not implemented yet");
   }
   
}
{% endhighlight %}

The example test both, the unsupported operation and our mock, to show that it 
works. The magic happens in … wait for it … `createStrictPartialMockForAllMethodsExcept()`. A 
very, very long name, but it explains exactly what it's doing. It leaves our 
`say()` untouched, but mocks all other internal calls.

We expect the `convert()` method to be called with `world` and returns the 
uppercase `WORLD`. But it can be any value as long as you can compare it in the 
`assertThat` statement. That's it!

{% highlight java %}
import org.junit.Test;
import org.powermock.api.easymock.PowerMock;

import static org.easymock.EasyMock.expect;

import static org.fest.assertions.Assertions.assertThat;

public class BeanTest {

   @Test(expected = UnsupportedOperationException.class)
   public void sayNotInplementedYet() throws Exception {
      // raises an exception, because the convert method was called
      new Bean().say("world");
   }
   
   @Test
   public void sayHowItShouldBe() throws Exception {
      Bean beanMock = PowerMock.createStrictPartialMockForAllMethodsExcept(Bean.class, "say");
      
      // mock the unimplemented method
      expect(beanMock.convert("world")).andReturn("WORLD");
      
      PowerMock.replay(beanMock);
      
      assertThat(beanMock.say("world")).isEqualTo("Hi, WORLD!");
      
      PowerMock.verify(beanMock);
   }
   
}
{% endhighlight %}

