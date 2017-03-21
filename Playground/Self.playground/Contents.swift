//: Playground - noun: a place where people can play

import UIKit

// http://swifter.tips/use-self/

// Self: 对象类型，表示对象自己

protocol Copyable {
    func copy() -> Self
    
    func clamp(intervalToClamp: Self) -> Self
}

extension Copyable {
    public func `do`(_ block: (Self) -> Void) {
        block(self)
    }
}

class MyClass: Copyable {
    
    func clamp(intervalToClamp: MyClass) -> Self {
        self.num = intervalToClamp.num
        return self
    }
    
    var num = 1
    
    func copy() -> Self {
        let result = type(of: self).init() // 通过这种方式初始化对象的时候,必须有required 修饰的初始化方法才行
        result.num = num
        return result
    }
    
    public func `do`() {
    }
    
    required init() {
        
    }
}

let typeA: MyClass.Type = MyClass.self
print(typeA)
