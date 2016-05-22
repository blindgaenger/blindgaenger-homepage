---
layout: post
title: Enumeration helpers for Ruby
tags:
- ruby
---

I was in need of some enumeration, I mean in the kind of way you know them
from Java for example. Turns out some other people had the same problem before:

* <http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-talk/150456>
* <http://snippets.dzone.com/posts/show/2163>
* <http://www.lesismore.co.za/2008/02/simple-ruby-enums.html>

Yep, I was inspired by these sites and combined them. Thanks again! :)

As you can see I opened the `Kernel` module. This way you can use it in every 
place without including/extending.

{{ruby
module Kernel

  def enum(hash)
    if hash
      hash.each {|k, v| const_set(k.to_sym, v) }
    end
  end

  def enum_syms(*args)
    if args
      enum Hash[*args.map {|k| [k.to_sym, k.to_sym] }.flatten]
    end
  end

  def enum_indexes(*args)
    if args
      enum Hash[*args.inject([]) { |arr, k| arr << [k.to_sym, arr.length] }.flatten]
    end
  end

  def enum_bits(*args)
    if args
      enum Hash[*args.inject([]) { |arr, k| arr << [k.to_sym, 2**arr.length] }.flatten]
    end
  end

end
}}


# Test cases and usage

In my opinion, the best examples for a snippet/helper/util are its test cases. So here's the rspec:

{{ruby
describe "Enumeration extension" do

  it "should define enum for hash" do
    module HashModule
      h = {:A => 'aaa', :B => :bbb, :C => nil}
      enum h
    end

    HashModule::A.should eql('aaa')
    HashModule::B.should eql(:bbb)
    HashModule::C.should eql(nil)

    lambda {HashModule::NOT_EXISTING}.should raise_error(NameError)
  end

  it "should define enum for syms" do
    module SymsModule
      enum_syms :A, :B, 'C'
    end

    SymsModule::A.should eql(:A)
    SymsModule::B.should eql(:B)
    SymsModule::C.should eql(:C)

    lambda {SymsModule::NOT_EXISTING}.should raise_error(NameError)
  end

  it "should define enum for indexes" do
    module IndexesModule
      enum_indexes :A, :B, :C
    end

    IndexesModule::A.should eql(0)
    IndexesModule::B.should eql(1)
    IndexesModule::C.should eql(2)

    lambda {IndexesModule::NOT_EXISTING}.should raise_error(NameError)
  end

  it "should define enum for bits" do
    module BitsModule
      enum_bits :A, :B, :C
    end

    BitsModule::A.should eql(1)
    BitsModule::B.should eql(2)
    BitsModule::C.should eql(4)

    lambda {BitsModule::NOT_EXISTING}.should raise_error(NameError)
  end

end
}}

You can find the code at [DZone Snippets](http://snippets.dzone.com/posts/show/6256),
too.

Have fun!

