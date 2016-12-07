//: Playground - noun: a place where people can play

import UIKit

let http404Error = (404, "Not Found")

let (statusCode, statusMessage) = http404Error
var str1 = statusCode
var str2 = statusMessage

// 用索引访问元组
str1 = http404Error.0
str2 = http404Error.1

// 只显示一个
let (justTheStatusCode, _) = http404Error
var str3 = justTheStatusCode

// 定义元组时可以起名
let http200Status = (statusCode: 200, description: "OK")
var str4 = http200Status.statusCode
