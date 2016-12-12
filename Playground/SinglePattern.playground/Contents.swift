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
    
    /*
     这种写法不仅简洁，而且保证了单例的独一无二。在初始化类变量的时候，Apple 将会把这个初始化包装在一次 swift_once_block_invoke 中，以保证它的唯一性。另外，我们在这个类型中加入了一个私有的初始化方法，来覆盖默认的公开初始化方法，这让项目中的其他地方不能够通过 init 来生成自己的 MyManager 实例，也保证了类型单例的唯一性。如果你需要的是类似 defaultManager 的形式的单例 (也就是说这个类的使用者可以创建自己的实例) 的话，可以去掉这个私有的 init 方法。
     */
    static let sharedInstance = JJSinglePattern()
    private override init() {}
}

let singlePattern = JJSinglePattern.sharedInstance
print(singlePattern)

print("end")
