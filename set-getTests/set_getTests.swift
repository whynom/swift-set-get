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
