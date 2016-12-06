//: Playground - noun: a place where people can play

import UIKit

/*
 结构体和枚举等，当赋值时是值拷贝，对象是引用。当值拷贝类型中存在对象，需要做写时复制。
 */

struct GaussianBlur {
    
    var filter: CIFilter
    
    // 写时复制，Swift中有一个函数叫isKnownUniquelyReferenced，它可以判断一个指针是否被唯一引用。有了这个方法，我们只要复制被多引用的对象，这样就避免了不必要的复制。
    private var filterForWriting: CIFilter {
        mutating get {
            if !isKnownUniquelyReferenced(&filter) {
                filter = filter.copy() as! CIFilter
            }
            return filter
        }
    }
    
    // Set方法中的是filterForWriting，如果结构体的input或radius属性被修改，它在内部就会复制一份filter，也就不会影响到别的结构体了。
    var input: CIImage {
        get { return filter.value(forKey: kCIInputImageKey) as! CIImage }
        set { filterForWriting.setValue(newValue, forKey: kCIInputImageKey) }
    }
    
    var radius: Double {
        get { return filter.value(forKey:kCIInputRadiusKey) as! Double}
        set { filterForWriting.setValue(newValue, forKey: kCIInputRadiusKey) }
    }
}

var filter = CIFilter(name: "CIGaussianBlur", withInputParameters: [:])!
filter.setDefaults()
var value1 = GaussianBlur(filter: filter)
var value2 = value1

/// ===两个对象引用地址一样就是true
value1.filter === value2.filter // true

value2.radius = 0.1

value1.filter === value2.filter // false，发生写时复制


class AA {
    public var a = 1
}

var aa = AA()
var bb = aa
aa === bb // true
bb.a = 2
aa === bb // true
