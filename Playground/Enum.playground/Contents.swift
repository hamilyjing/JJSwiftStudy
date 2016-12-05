//: Playground - noun: a place where people can play

import UIKit
import Foundation

/*
 在 Swift 中，枚举类型是一等（first-class）类型。它们采用了很多传统上只被类（class)所支持的特征，例如计算型属性（computed properties)，用于提供关于枚举当前值的附加信息，实例方法（instance methods），用于提供和枚举所代表的值相关联的功能。枚举也可以定义构造函数（initializers）来提供一个初始成员值；可以在原始的实现基础上扩展它们的功能；可以遵守协议（protocols）来提供标准的功能。
 */


// 参考：http://www.tuicool.com/articles/b2YveqQ


/*
 定义：
 枚举声明的类型是囊括可能状态的有限集，且可以具有附加值。通过内嵌( nesting ),方法( method ),关联值( associated values )和模式匹配( pattern matching ),枚举可以分层次地定义任何有组织的数据。
 
 枚举值存在的话，只能存储一个。
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


// MARK: 关联值，就是可以加参数
// 如果我们忽略关联值，则枚举的值就只能是整型，浮点型，字符串和布尔类型。

enum Trade {
    case Buy(String, Int)
    case Sell(String, Int)
}

let trade = Trade.Buy("123", 123)
if case let Trade.Buy(stock, amount) = trade {
    print("buy \(amount) of \(stock)")
}


// MARK: 方法
// 枚举中的方法为每一个 enum case 而“生”。所以倘若想要在特定情况执行特定代码的话，你需要分支处理或采用 switch 语句来明确正确的代码路径。

print()

enum Device {
    case iPad, iPhone, AppleTV, AppleWatch
    func introduced() -> String {
        switch self {
        case .AppleTV: return "\(self) was introduced 2006"
        case .iPhone: return "\(self) was introduced 2007"
        case .iPad: return "\(self) was introduced 2010"
        case .AppleWatch: return "\(self) was introduced 2014"
        }
    }
}

print(Device.iPhone.introduced())


// MARK: 属性(Properties)
// 尽管增加一个存储属性到枚举中不被允许，但你依然能够创建计算属性。当然，计算属性的内容都是建立在枚举值下或者枚举关联值得到的。

print("\n-- 属性 --")

extension Device {
    var year: Int {
        switch self {
        case .iPhone: return 2007
        case .iPad: return 2010
        default: return 2000
        }
    }
}

print(Device.iPhone.year)


// MARK: 静态方法(Static Methods)

print("\n-- 静态方法 --")

extension Device {
    static func fromSlang(term: String) -> Device? {
        if term == "iWatch" {
            return .AppleWatch
        }
        return nil
    }
}

print(Device.fromSlang(term: "iWatch")!)


// MARK: 可变方法(Mutating Methods)
// 方法可以声明为 mutating 。这样就允许改变隐藏参数 self 的 case 值了

print("\n-- 可变方法 --")

enum TriStateSwitch {
    case Off, Low, High
    mutating func next() {
        switch self {
        case .Off:
            self = .Low
        case .Low:
            self = .High
        case .High:
            self = .Off
        }
    }
}

var ovenLight = TriStateSwitch.Low
ovenLight.next()
ovenLight.next()


// MARK: 协议
print("\n-- 协议 --")


// MARK: 泛型
print("\n-- 泛型 --")


// MARK: 递归 / 间接(Indirect)类型
print("\n-- 递归 / 间接(Indirect)类型 --")

enum FileNode {
    case File(name: String)
    indirect case Folder(name: String, files: [FileNode])
}

// 此处的 indrect 关键字告诉编译器间接地处理这个枚举的 case。也可以对整个枚举类型使用这个关键字
indirect enum Tree<Element: Comparable> {
    case Empty
    case Node(Tree<Element>,Element,Tree<Element>)
}


// MARK: 使用自定义类型作为枚举的值
// 如果我们忽略关联值，则枚举的值就只能是整型，浮点型，字符串和布尔类型。如果想要支持别的类型，则可以通过实现 StringLiteralConvertible 协议来完成，这可以让我们通过对字符串的序列化和反序列化来使枚举支持自定义类型。
print("\n-- 使用自定义类型作为枚举的值 --")

extension CGSize: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        let size = CGSizeFromString(value)
        self.init(width: size.width, height: size.height)
    }
    
    public init(extendedGraphemeClusterLiteral value: String) {
        let size = CGSizeFromString(value)
        self.init(width: size.width, height: size.height)
    }
    
    public init(unicodeScalarLiteral value: String) {
        let size = CGSizeFromString(value)
        self.init(width: size.width, height: size.height)
    }
}

// 不过这里有一个缺点：初始化的值必须写成字符串形式，因为这就是我们定义的枚举需要接受的类型(记住，我们实现了 StringLiteralConvertible，因此 String 可以转化成 CGSize 类型)
enum Devices: CGSize {
    case iPhone3GS = "{320, 480}"
    case iPhone5 = "{320, 568}"
    case iPhone6 = "{375, 667}"
    case iPhone6Plus = "{414, 736}"
}

let a = Devices.iPhone5
let b = a.rawValue // 获取真实的 CGPoint 的值的时候，我们需要访问枚举的是 rawValue 属性
print("the phone size string is \(a), width is \(b.width), height is \(b.height)")


// MARK: 对枚举的关联值进行比较
// 一个简单的 enum T { case a, b } 实现默认支持相等性判断 T.a == T.b, T.b != T.a
// 然而，一旦我们为枚举增加了关联值，Swift 就没有办法正确地为两个枚举进行相等性判断，需要我们自己实现 == 运行符。
print("\n-- 对枚举的关联值进行比较 --")

enum Trade1 {
    case Buy(stock: String, amount: Int)
    case Sell(stock: String, amount: Int)
}
func ==(lhs: Trade1, rhs: Trade1) -> Bool {
    switch (lhs, rhs) {
    case let (.Buy(stock1, amount1), .Buy(stock2, amount2))
        where stock1 == stock2 && amount1 == amount2:
        return true
    case let (.Sell(stock1, amount1), .Sell(stock2, amount2))
        where stock1 == stock2 && amount1 == amount2:
        return true
    default: return false
    }
}


// MARK: 自定义构造方法
// 枚举与结构体和类的构造方法最大的不同在于，枚举的构造方法需要将隐式的 self 属性设置为正确的 case。
print("\n-- 自定义构造方法 --")

enum Device1 {
    case AppleWatch
    init?(term: String) {
        if term == "iWatch" {
            self = .AppleWatch
        }
        return nil
    }
}

enum NumberCategory {
    case Small
    case Medium
    case Big
    case Huge
    init(number n: Int) {
        if n < 10000 { self = .Small }
        else if n < 1000000 { self = .Medium }
        else if n < 100000000 { self = .Big }
        else { self = .Huge }
    }
}
let aNumber = NumberCategory(number: 100)
print(aNumber)
