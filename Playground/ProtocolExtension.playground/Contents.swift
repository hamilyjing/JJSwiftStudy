//: Playground - noun: a place where people can play

import UIKit

/*
 1. 如果类型推断得到的是实际的类型
 那么类型中的实现将被调用；如果类型中没有实现的话，那么接口扩展中的默认实现将被使用
 2. 如果类型推断得到的是接口，而不是实际类型
 并且方法在接口中进行了定义，那么类型中的实现将被调用；如果类型中没有实现，那么接口扩展中的默认实现被使用
 否则 (也就是方法没有在接口中定义)，扩展中的默认实现将被调用
 */

protocol MyProtocol {
    func method()
}

print("\n-- 在协议的扩展中，实现默认方法 --")

extension MyProtocol {
    func method() {
        print("method")
    }
}

struct MyStruct: MyProtocol {
}

MyStruct().method()


print("\n-- 在具体类中实现协议 --")

struct MyStruct1: MyProtocol {
    func method() {
        print("MyStruct1")
    }
}

MyStruct1().method()


print("\n-- 在协议扩展中实现了额外的方法 --")

extension MyProtocol {
    func method1() {
        print("method1")
    }
}

extension MyStruct1 {
    func method1() {
        print("MyStruct1 - method1")
    }
}

let b = MyStruct1()
b.method()
b.method1()

print("")

// 转协议，要小心，最好不要在协议扩展中实现了额外的方法
let c = b as MyProtocol
c.method()
c.method1() // method1
