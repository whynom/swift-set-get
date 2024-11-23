## AI steers me right, and steers me wrong 
I wrote a nifty article about `didSet` and `willSet`.  They're observers you can put on a property that execute a block of code whenever the property they're attached to changes.  While jumping down that well, my AI sidekick was the one that gave me the classification of these keywords which is `observers`.  Personally, I love to know what a thing in programming is called.  I sometimes find myself trying to describe a group of programming things and I don't have the word for them.  `didSet` and `willSet` aren't really functions but I need to mention them in tandem, so having the term `observer` is quite useful.

As useful as the ole' AI was with enlightening me about observers, it told me that `get` and `set` are the `observer`s for computed properties, as `didSet` and `willSet` can't be used on `get` and `set`.  It was wrong, but nevertheless, I plunged into it to figure out exactly what these... functions(?) keywords(?) XCode pink words(?) are all about.  I've seen them before, and I had the gist, but it turns out my gist was somewhat inaccurate.

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

## The Rectangle
In this example, we're going to make a rectangle.  We'll give it an `origin` and a `size`, and it will give us a center.  For us to define an origin, we need a point.

## Let's get to the point
Here's how we'll define a point, like the one you used to see in math class on a cartesian plane.

``` swift
struct Point {
    var x = 0.0, y = 0.0
}
```

Give me an `x` and a `y` and I'll give you a `Point`.

## Size
Give me a `width` and `height`, and I'll give you the `Size` of a rectangle.

``` swift
struct Size {
    var width = 0.0, height = 0.0
}
```

## Point and Sizes lead to the Rectangle
Finally,

``` swift
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}
```

Here we see our `get` and `set` keywords in action.  Once we've made a `Rect` we get computations on our `origin` and `size` that give us the center.

## Accessing the `center`
Whenever we access the center, it'll run the code block in the curly braces following the `get` keyword.  Let's _test_ this theory.

``` swift
    @Test func getSetTests() async throws {
        var square = Rect(origin: Point(x: 0.0, y: 0.0),
                          size: Size(width: 10.0, height: 10.0))
        #expect(square.center.x == 5)
        #expect(square.center.y == 5)
        }
```

When we're accessing the `center`, which we didn't define upon making the `Rect`, it runs that code block after the `get` key word and returns to us a `Point` with a center that has an x at 5, and a y at 5.

## Setting the `center`
Now we're going to tell our `Rect` instance what the new center is, and it's going to execute the code block after the `set` keyword to change the `center` of our rectangle and make a new rectangle from which we can give the new `origin`


``` swift
    @Test func getSetTests() async throws {
       ...
       
        square.center = Point(x: 15.0, y: 15.0)
        #expect(square.origin.x == 10)
        #expect(square.origin.y == 10)
    }

```

When we set that `center` property, the code block after `set` in our `Rect` is executed and it returns to us the new `origin`.

## Final thoughts
This is pretty basic stuff but I feel like going through it step by step, making tests, writing everything out gives me a better and more solid understanding.  Computed variables aren't just syntactic sugar for a function, they're their own _thing_.  The `set` and the `get` make them unique and different from a function, and knowing that gives me another tool to use if I should ever run into something that needs the unique use of the `get` `set` on a computed variable.
