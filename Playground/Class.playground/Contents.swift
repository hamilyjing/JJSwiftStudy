//: Playground - noun: a place where people can play

import UIKit

// Swift的init方法只能被调用一次，所以在init方法中才可以赋值，而不会引起任何线程安全的问题

print("-- 初始化 --")
print("-- 1. 指定初始化器必须总是向上委托，调用直系父类调用指定初始化器 --")
print("-- 2. 便利初始化器必须总是横向委托，调用相同类的指定初始化函数 --")
print("-- 3. 子类必须重写父类的convenience required --")
print("-- 4. 子类如果没有写指定初始化，可以不重写required，否则必须重写 --")

class Base {
    
    var name: String
    var sex: String?
    
    init() {
        self.name = "base"
    }
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
    
    required init(sex: String?) {
        self.name = "base"
        self.sex = sex
    }
}

let base1 = Base()

class Sub1: Base {
    
    convenience init(sub: String) {
        self.init() // 便利初始化器必须总是横向委托，即调用相同类的指定初始化函数，写成super.init()是错误的
    }
    
    // 类没有写指定初花函数，可以不用重写父类的required
    
    convenience required init(reCon: String) {
        self.init()
    }
}

class Sub11: Sub1 {
    
    convenience required init(reCon: String) {
        self.init()
    }
}

let sub1 = Sub1()
let sub11 = Sub1(sex: "mal")
let sub111 = Sub1(name: "mal")
let sub1111 = Sub1(sub: "mal")

class Sub2: Base {
    
    init(sub1: String) {
        super.init(sex: sub1) // 指定初始化器必须总是向上委托，必须从它的直系父类调用指定初始化器，super.init(name: "sub1")是错误的
    }
    
    required init(sex: String?) {
        super.init()
    }
    
    convenience init(sub2: String) {
        self.init(sub1: "femal") // 便利初始化器必须总是横向委托，即调用想同类的指定初始化函数，写成super.init()是错误的
    }
}
