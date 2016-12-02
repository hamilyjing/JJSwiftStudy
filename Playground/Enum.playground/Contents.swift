//: Playground - noun: a place where people can play

//import UIKit
import Foundation

/*
 在 Swift 中，枚举类型是一等（first-class）类型。它们采用了很多传统上只被类（class)所支持的特征，例如计算型属性（computed properties)，用于提供关于枚举当前值的附加信息，实例方法（instance methods），用于提供和枚举所代表的值相关联的功能。枚举也可以定义构造函数（initializers）来提供一个初始成员值；可以在原始的实现基础上扩展它们的功能；可以遵守协议（protocols）来提供标准的功能。
 */


// 参考：http://www.tuicool.com/articles/b2YveqQ


/*
 定义：
 枚举声明的类型是囊括可能状态的有限集，且可以具有附加值。通过内嵌( nesting ),方法( method ),关联值( associated values )和模式匹配( pattern matching ),枚举可以分层次地定义任何有组织的数据。
 */

// 1. 语法

enum CompassPoint {
    case North
    case South
    case East
    case West
}

enum CompassPoint2 {
    case North, South, East, West
}

// 可以通过如下两种方式声明
var directionToHead = CompassPoint.West

var directionToHead1: CompassPoint = .West // 一旦被声明为一个CompassPoint，你可以使用更短的点（.）语法将其设置为另一个CompassPoint的值

// switch 分情况处理
switch directionToHead {
case .West:
    print("West1")
default:
    print("None")
}

// 明确的case情况
if case .West = directionToHead{
    print("West2")
}

if directionToHead == .West { print("West3") }

// 2. 原始值
/*
 注意，原始值和实例值是不相同的。当你开始在你的代码中定义枚举的时候原始值是被预先填充的值，像上述三个 ASCII 码。对于一个特定的枚举成员，它的原始值始终是相同的。实例值是当你在创建一个基于枚举成员的新常量或变量时才会被设置，并且每次当你这么做得时候，它的值可以是不同的。
 
 原始值可以是字符串，字符，或者任何整型值或浮点型值。每个原始值在它的枚举声明中必须是唯一的。当整型值被用于原始值，如果其他枚举成员没有值时，它们会自动递增。
 
 Swift 枚举中支持以下四种关联值类型:
 整型(Integer)
 浮点数(Float Point)
 字符串(String)
 布尔类型(Boolean)
 */

print()

// 关联到字符型
enum ASCIIControlCharacter: Character { // 定义枚举成员类型
    case Tab = "\t" // 原始值
    case LineFeed = "\n"
    case CarriageReturn = "\r"
}

// 关联到整型
enum Planet: Int {
    case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
} // 自动递增意味着Planet.Venus的原始值是2

var earthsOrder = Planet.Earth.rawValue// toRaw方法可以访问该枚举成员的原始值
// earthsOrder is 3

let positionToFind = 9
if let somePlanet = Planet(rawValue: positionToFind) // 通过rawValue调用默认失败初始化函数，返回可选类型（Planet?）
{
    print("success")
}
else
{
    print("error")
}

// 3. 实例值

print()

enum Barcode {
    case UPCA(Int, Int, Int)
    case QRCode(String)
}

var productBarcode = Barcode.UPCA(8, 85909_51226, 3)
productBarcode = .QRCode("ABCDEFGHIJKLMNOP") // UPCA的值被覆盖，任何指定时间只能存储其中之一。这时，原始的Barcode.UPCA和其整数值被新的Barcode.QRCode和其字符串值所替代。条形码的常量和变量可以存储一个.UPCA或者一个.QRCode（连同它的实例值），但是在任何指定时间只能存储其中之一。

switch productBarcode
{
case .UPCA(let numberSystem, let identifier, let check):
    // or let .UPCA(numberSystem, identifier, check):，枚举成员的所有实例值被提取为常量
    print("UPC-A with value of \(numberSystem), \(identifier), \(check).")
    
case .QRCode(var productCode):
    // or var .QRCode(productCode):
    print("QR code with value of \(productCode).")
}

// 4. 失败初始化

print()

enum TemperatureUnit
{
    case Kelvin, Celsius, Fahrenheit
    
    init?(symbol: Character)
    {
        switch symbol
        {
        case "K":
            self = .Kelvin
            
        case "C":
            self = .Celsius
            
        case "F":
            self = .Fahrenheit
            
        default:
            return nil
        }
    }
}

let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}
// prints "This is a defined temperature unit, so initialization succeeded."

let unknownUnit = TemperatureUnit(symbol: "X")
if unknownUnit == nil {
    print("This is not a defined temperature unit, so initialization failed.")
}
// prints "This is not a defined temperature unit, so initialization failed.”

// Raw Values, 对于有原始值的enum，上面的TemperatureUnit的失败初始化可以不写
// Enumerations with raw values automatically receive a failable initializer, init?(rawValue:), that takes a parameter called rawValue of the appropriate raw-value type and selects a matching enumeration member if one is found, or triggers an initialization failure if no matching value exists.
enum TemperatureUnit1: Character
{
    case Kelvin = "K", Celsius = "C", Fahrenheit = "F"
}

let fahrenheitUnit1 = TemperatureUnit1(rawValue: "F")
if fahrenheitUnit1 != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}
// prints "This is a defined temperature unit, so initialization succeeded."

let unknownUnit1 = TemperatureUnit1(rawValue: "X")
if unknownUnit1 == nil {
    print("This is not a defined temperature unit, so initialization failed.")
}
// prints "This is not a defined temperature unit, so initialization failed."


// MARK: 嵌套枚举(Nesting Enums)，枚举包含枚举

enum Character1 {
    enum Weapon {
        case Bow
        case Sword
        case Lance
        case Dagger
    }
    enum Helmet {
        case Wooden
        case Iron
        case Diamond
    }
    case Thief
    case Warrior
    case Knight
}

let character1 = Character1.Thief
let weapon = Character1.Weapon.Bow
let helmet = Character1.Helmet.Iron


// MARK: 嵌套枚举(Nesting Enums)，在 structs 或 classes 中内嵌枚举

struct Character2 {
    enum CharacterType {
        case Thief
        case Warrior
        case Knight
    }
    enum Weapon {
        case Bow
        case Sword
        case Lance
        case Dagger
    }
    let type: CharacterType
    let weapon: Weapon
}

let warrior = Character2(type: .Warrior, weapon: .Sword)
