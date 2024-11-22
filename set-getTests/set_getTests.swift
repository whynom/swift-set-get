//
//  set_getTests.swift
//  set-getTests
//
//  Created by ynom on 11/22/24.
//

import Testing

struct set_getTests {

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

    
}

struct rect_Tests {
    struct Point {
        var x = 0.0, y = 0.0
    }
    struct Size {
        var width = 0.0, height = 0.0
    }
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
    
    
    @Test func getSetTests() async throws {
        var square = Rect(origin: Point(x: 0.0, y: 0.0),
                          size: Size(width: 10.0, height: 10.0))
        #expect(square.center.x == 5)
        #expect(square.center.y == 5)
        
        square.center = Point(x: 15.0, y: 15.0)
        #expect(square.origin.x == 10)
        #expect(square.origin.y == 10)
    }
}
