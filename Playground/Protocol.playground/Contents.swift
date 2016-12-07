//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

public protocol Equatable11 {
    
    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    static func ==(lhs: Self, rhs: Self) -> Bool
}

class BB : Equatable11 {
    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func ==(lhs: BB, rhs: BB) -> Bool {
        return false
    }
}

let b = BB()
let b1 = BB()
let flag = b == b1
