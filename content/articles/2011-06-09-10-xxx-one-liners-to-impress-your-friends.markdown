---
layout: post
title: 10 XXX One Liners to Impress Your Friends
tags:
- one-liners
- scala
- ruby
- coffeescript
- python
- haskell
---

There is some fascination to solve problems by writing as little code as possible. And even yesterday I visited the [Rails Usergroup Hamburg](http://hamburg.onruby.de/) where we played [Ruby Golf](https://github.com/chrisdb/rubygolfhh).

It's a great way to learn some not so common constructs of the language of your choice. Even if some of them don't even try to be very expressive or elegant. But there's always something you can learn from, right?

Last week there came up interesting posts to show you '10 XXX One Liners to Impress Your Friends'. So let's put some Scala/Ruby/CoffeeScript/Python/Haskell side by side. But please don't judge a language by these examples. It's more an inspiration.

At the end of this article you'll find a list of all original posts the code cames from. Have fun!

# 1. Multiple Each Item in a List by 2

Scala

{{scala

  (1 to 10) map { _ * 2 }
}}

Ruby

{{ruby

  (1..10).map { |n| n * 2 }
}}

CoffeeScript

{{coffeescript

  [1..10].map (i) -> i*2

  OR

  i * 2 for i in [1..10]
}}

Python

{{python
  print map(lambda x: x * 2, range(1,11))
}}

Haskell

{{haskell
  map (*2) [1..10]
}}

# 2. Sum a List of Numbers

Scala

{{scala

  (1 to 1000).reduceLeft( _ + _ )
}}

Ruby

{{ruby

  (1..1000).inject { |sum, n| sum + n }

  OR

  (1..1000).inject(&:+)

  OR

  (1..1000).inject(:+)
}}

CoffeeScript

{{coffeescript

  [1..1000].reduce (t, s) -> t + s
}}

Python

{{python
  print sum(range(1,1001))
}}

Haskell

{{haskell
  foldl (+) 0 [1..1000]

  OR

  sum [1..1000]
}}

# 3. Verify if Exists in a String

Scala

{{scala

  val wordlist = List("scala", "akka", "play framework", "sbt", "typesafe")
  val tweet = "This is an example tweet talking about scala and sbt."
  (words.foldLeft(false)( _ || tweet.contains(_) ))
}}

Ruby

{{ruby

  words = ["scala", "akka", "play framework", "sbt", "typesafe"]
  tweet = "This is an example tweet talking about scala and sbt."
  words.any? { |word| tweet.include?(word) }
}}

CoffeeScript

{{coffeescript

  wordList = ["coffeescript", "eko", "play framework", "and stuff", "falsy"]
  tweet = "This is an example tweet talking about javascript and stuff."
  wordList.some (word) -> ~tweet.indexOf word
}}

Python

{{python
  wordlist = ["scala", "akka", "play framework", "sbt", "typesafe"]
  tweet = "This is an example tweet talking about scala and sbt."
  print map(lambda x: x in tweet.split(),wordlist)
}}

Haskell

{{haskell
  import Data.List
  let wordlist = ["monad", "monoid", "Galois", "ghc", "SPJ"]
  let tweet = "This is an example tweet talking about SPJ interviewing with Galois"
  or $ map (flip isInfixOf tweet) wordlist

  OR

  any (flip isInfixOf tweet) wordlist
}}

# 4. Read in a File

Scala

{{scala

  val fileText = io.Source.fromFile("data.txt").mkString
  val fileLines = io.Source.fromFile("data.txt").getLines.toList
}}

Ruby

{{ruby

  file_text = File.read("data.txt")
  file_lines = File.readlines("data.txt")
}}

CoffeeScript

{{coffeescript

  fs.readFile 'data.txt', (err, data) -> fileText = data

  OR (sync)

  fileText = fs.readFileSync('data.txt').toString()
}}

Python

{{python
  print open("ten_one_liners.py").readlines()
}}

Haskell

{{haskell
  fileText <- readFile "data.txt"
  let fileLines = lines fileText

  OR

  let fileLines = fmap lines $ readFile "data.txt"
}}

# 5. Happy Birthday to You!

Scala

{{scala

  (1 to 4).map { i => "Happy Birthday " + (if (i == 3) "dear NAME" else "to You") }.foreach { println }
}}

Ruby

{{ruby

  4.times { |n| puts "Happy Birthday #{n==2 ? "dear Tony" : "to You"}" }
}}

CoffeeScript

{{coffeescript

  [1..4].map (i) -> console.log "Happy Birthday " + (if i is 3 then "dear Robert" else "to You")

  OR

  console.log "Happy Birthday #{if i is 3 then "dear Robert" else "to You"}" for i in [1..4]
}}

Python

{{python
  print map(lambda x: "Happy Birthday to " + ("you" if x != 2 else "dear Name"),range(4))
}}

Haskell

{{haskell
  mapM_ putStrLn ["Happy Birthday " ++ (if x == 3 then "dear NAME" else "to You") | x <- [1..4]]
}}

# 6. Filter list of numbers

Scala

{{scala

  val (passed, failed) = List(49, 58, 76, 82, 88, 90) partition ( _ > 60 )
}}

Ruby

{{ruby

  [49, 58, 76, 82, 88, 90].partition { |n| n > 60 }
}}

CoffeeScript

{{coffeescript

  passed = []
  failed = []
  (if score > 60 then passed else failed).push score for score in [49, 58, 76, 82, 88, 90]

}}

Python

{{python
  print reduce(lambda(a,b),c: (a+[c],b) if c > 60 else (a,b + [c]), [49, 58, 76, 82, 88, 90],([],[]))
}}

Haskell

{{haskell
  let (passed, failed) = partition (>60) [49, 58, 76, 82, 88, 90]
}}

# 7. Fetch and Parse an XML web service

Scala

{{scala

  val results = XML.load("http://search.twitter.com/search.atom?&q=scala")
}}

Ruby

{{ruby

  require 'open-uri'
  require 'hpricot'
  results = Hpricot(open("http://search.twitter.com/search.atom?&q=scala"))
}}

CoffeeScript

{{coffeescript

  request.get { uri:'path/to/api.json', json: true }, (err, r, body) -> results = body
}}

Python

{{python
  from xml.dom.minidom import parse, parseString
  import urllib2
  print parse(urllib2.urlopen("http://search.twitter.com/search.atom?&q=python")).toprettyxml(encoding="utf-8")
}}

Haskell

{{haskell
  import Network.Curl
  import Text.XML.Light
  import Control.Monad
  let results = liftM parseXMLDoc $ liftM snd (curlGetString "http://search.twitter.com/search.atom?&q=haskell" [])

  OR

  Control.Applicative
  let results = parseXMLDoc . snd <$> curlGetString "http://search.twitter.com/search.atom?&q=haskell" []
}}

# 8. Find minimum (or maximum) in a List

Scala

{{scala

  List(14, 35, -7, 46, 98).reduceLeft ( _ min _ )
  List(14, 35, -7, 46, 98).reduceLeft ( _ max _ )
}}

Ruby

{{ruby

  [14, 35, -7, 46, 98].min
  [14, 35, -7, 46, 98].max
}}

CoffeeScript

{{coffeescript

  Math.max.apply @, [14, 35, -7, 46, 98]
  Math.min.apply @, [14, 35, -7, 46, 98]
}}

Python

{{python
  print min([14, 35, -7, 46, 98])
  print max([14, 35, -7, 46, 98])
}}

Haskell

{{haskell
  foldl1 min [14, 35, -7, 46, 98]
  foldl1 max [14, 35, -7, 46, 98]

  OR

  minimum [14, 35, -7, 46, 98]
  maximum [14, 35, -7, 46, 98]
}}

# 9. Parallel Processing

Scala

{{scala

  val result = dataList.par.map(line => processItem(line))
}}

Ruby

{{ruby

  require 'parallel'

  Parallel.map(lots_of_data) do |chunk|
    heavy_computation(chunk)
  end
}}

CoffeeScript

{{coffeescript

  SKIP
}}

Python

{{python
  import multiprocessing
  import math

  print list(multiprocessing.Pool(processes=4).map(math.exp,range(1,11)))
}}

Haskell

{{haskell
  import Control.Parallel
  import Control.Parallel.Strategies

  parMap rseq (*2) [1..100]
}}

# 10. Sieve of Eratosthenes

Scala

{{scala

  (n: Int) => (2 to n) |> (r => r.foldLeft(r.toSet)((ps, x) => if (ps(x)) ps -- (x * x to n by x) else ps))
}}

Ruby

{{ruby

  index = 0
  while primes[index]**2 <= primes.last
        prime = primes[index]
        primes = primes.select { |x| x == prime || x % prime != 0 }
        index += 1
  end
  p primes
}}

CoffeeScript

{{coffeescript

  sieve = (num) ->
      numbers = [2..num]
      while ((pos = numbers[0]) * pos) <= num
          delete numbers[i] for n, i in numbers by pos
          numbers.shift()
      numbers.indexOf(num) > -1
}}

Python

{{python
  print sorted(set(range(2,n+1)).difference(set((p * f) for p in range(2,int(n**0.5) + 2) for f in range(2,(n/p)+1))))
}}

Haskell

{{haskell
  let pgen (p:xs) = p : pgen [x|x <- xs, x `mod` p > 0]
  take 40 (pgen [2..])
}}


# Links

- [10 Scala One Liners to Impress Your Friends](http://solog.co/47/10-scala-one-liners-to-impress-your-friends/)
- [10 Ruby One Liners to Impress Your Friends](http://programmingzen.com/2011/06/02/10-ruby-one-liners-to-impress-your-friends/)
- [10 CoffeeScript One Liners to Impress Your Friends](http://ricardo.cc/2011/06/02/10-CoffeeScript-One-Liners-to-Impress-Your-Friends.html)
- [10 Python One Liners to Impress Your Friends](http://codeblog.dhananjaynene.com/2011/06/10-python-one-liners-to-impress-your-friends/)
- [10 Haskell One Liners to Impress Your Friends](http://blog.fogus.me/2011/06/03/10-haskell-one-liners-to-impress-your-friends/)

