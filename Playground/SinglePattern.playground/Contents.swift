//
//  JJSinglePattern.swift
//  SwiftStudy
//
//  Created by gongjian03 on 1/29/15.
//  Copyright (c) 2015 gongjian03. All rights reserved.
//

import UIKit

private var i = 0
func ff() -> Int {
    if i == 1
    {
        return 2
    }
    if i == 0{
        i = 1
    }
    return i;
}

ff()
ff()

class JJSinglePattern: NSObject {
    
    private static var __once: () = {
        //Static.staticInstance = JJSinglePattern()
    }()
    
    /*
     Swift的Class现在还暂时不支持存储的class var和class let，所以我们需要使用一个 struct 来存储类型变量。
     class var a: Int = 0; // wrong
     支持计算属性。
     */
    class var sharedInstanceOne: JJSinglePattern
    {
        struct Static
        {
            static var onceToken: Int = 0
            static var staticInstance: JJSinglePattern? = nil
        }
        
        /*
         swift static properties may only be declared on a type!
         */
        //static var onceToken: dispatch_once_t = 0 // wrong, should delete static
        //static var staticInstance: JJSinglePattern? = nil // wrong
        
        _ = JJSinglePattern.__once
        
        return Static.staticInstance!;
    }
    
    /*
     Swift 里我们其实有一个更简单的保证线程安全的方式，那就是let。
     */
    class var sharedInstanceTwo: JJSinglePattern
    {
        struct Static
        {
            // 1.sharedInstanceTwo是一个静态的复合属性(我们也可以替换为方法)。
            // 2.静态属性不允许在类被实现的时候重构，所以由于内部类型是被允许的，我们可以再这里加入一个结构体。
            // 3.sharedInstance是一个常量，它不会被重写而且保证线程安全。
            static let sharedInstance : JJSinglePattern = JJSinglePattern()
        }
        
        return Static.sharedInstance
    }
    
    /*
     由于现在 class 不支持存储式的 property，我们想要使用一个只存在一份的属性时，就只能将其定义在全局的 scope 中。值得庆幸的是，在 Swift 拥有访问级别控制后，我们可以在变量定义前面加上 private 关键字，使这个变量只在当前文件中可以被访问。
     没有特别的需求，我建议都使用这样的方式来实现单例。
     */
    class var sharedInstanceThree : JJSinglePattern
    {
        return sharedInstance
    }
    
    func test()
    {
        print("test")
    }
}

// private 关键字，使这个变量只在当前文件中可以被访问
private let sharedInstance = JJSinglePattern()
print(sharedInstance)

print("end")
