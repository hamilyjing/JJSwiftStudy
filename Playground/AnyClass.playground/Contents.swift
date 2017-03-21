//: Playground - noun: a place where people can play

import UIKit

// AnyClass: 类类型，可以动态创建类对象和调用类方法

class A {
    
    class func method() {
        print("Hello")
    }
}

let typeA: A.Type = A.self // 在 Swift 中，.self 可以用在类型后面取得类型本身，也可以用在某个实例后面取得这个实例本身。
print(typeA) // A
typeA.method()

// 或者 
let anyClass: AnyClass = A.self
(anyClass as! A.Type).method()

class MusicViewController: UIViewController {
}

class AlbumViewController: UIViewController {
}

let usingVCTypes: [AnyClass] = [MusicViewController.self,     AlbumViewController.self]
func setupViewControllers(_ vcTypes: [AnyClass]) {
    for vcType in vcTypes {
        if vcType is UIViewController.Type {
            let vc = (vcType as! UIViewController.Type).init() // 通过这种方式初始化对象的时候,必须有required 修饰的初始化方法才行
            print(vc)
        }
    }
}
setupViewControllers(usingVCTypes)
