## AI steers me right, and steers me wrong 
I wrote a nifty article about `didSet` and `willSet`.  They're observers you can put on a property that execute a block of code whenever the property they're attached to changes.  While jumping down that well, my AI sidekick informed me that they are called `observers`.  Personally, I love to know what thing is.  I sometimes find myself trying to describe a group of things and I don't have the word for them.  `didSet` and `willSet` aren't really functions but I need to mention them in tandem, so having the term `observer` is quite useful.

As useful as the ole' AI was with enlightening me about observers, it told me that `get` and `set` are the `observer`s for computed properties, as `didSet` and `willSet` can't be used on `get` and `set`.  It was wrong, but nevertheless, I plunged into it to figure out exactly what these... functions? keywords? XCode pink words? are all about.  I've seen them before, and I had the gist, but it turns out my gist was somewhat inaccurate.

## computed variables as syntactic sugar for functions
My understanding of computed variables in the Swift language was that they were functions.  Without a defined `get` and `set`, they very much appear that way.  _Let's take a look._

``` swift
    @Test func computedVariablesAreFunctions() async throws {
        struct Money {
            var cents: Double
            var dollars: Double {
                cents / 100
            }
        }
        
        struct MoneyWithAFunction {
            var cents: Double
            func dollars() -> Double {
               cents / 100
            }
        }
        
        #expect(Money(cents: 233).dollars == MoneyWithAFunction(cents: 233).dollars())
    }
```

Well lookie here.  Either way I make a money struct, whether I use a computed variable or a function that almost exactly mimics it, it gives the _exact_ same result, it's just some different syntax.  It looks like my gut reaction was right!

## But wait, computed variables have a `get` and `set`
The previous example of a computed property is actually what the swift book refers to as a _read only_ computed property, which will hopefully make sense after going through the following example I lifted from the  [swift book](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/properties/#Computed-Properties)
