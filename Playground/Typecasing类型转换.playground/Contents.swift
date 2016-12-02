
// Swift: Typecasing
// Enums as data models?
// https://medium.com/swift-programming/swift-typecasing-3cd156c323e#.e4kj5iojj
//
// Author: Andyy Hope
//
// Twitter: @andyyhope

// http://swift.gg/2016/11/29/swift-typecasing/

/*
 解决方案：
 1. 使用类和继承
 2. 使用协议和结构体
 3. 使用枚举
 */

import Foundation


// MARK: ********* 类和继承 *********

class CharacterA {
    var type: String = ""
    var name: String = ""
}
class HeroA : CharacterA {
    var power: String = ""
}
class PrincessA : CharacterA {
    var kingdom: String = ""
}
class CivilianA : CharacterA {
}
struct ModelA {
    var characters: [CharacterA]
}

let modeA = ModelA(characters: [HeroA()])

// 这是一个完全有效的方案，但是用起来会令人感到沮丧，因为每当我们需要访问那些模型特有的属性时，我们都不得不进行类型检查并且把对象转换成特定的类型。
// 类型检测
if modeA.characters[0] is HeroA {
    print(modeA.characters[0].name)
}
// 类型检测及转换
if let hero = modeA.characters[0] as? HeroA {
    print(hero.power)
}


// MARK: ********* 协议和结构体 *********

protocol CharacterB {
    var type: String { get set }
    var name: String { get set }
}
struct HeroB : CharacterB {
    internal var name: String = "HeroB"
    internal var type: String = "HeroB"

    var power: String = "power"
}
struct PrincessB : CharacterB {
    internal var name: String = ""
    internal var type: String = ""
    
    var kingdom: String = ""
}
struct CivilianB : CharacterB {
    internal var name: String = ""
    internal var type: String = ""
}
struct ModelB {
    var characters: [CharacterB]
}

// 因为使用了结构体，所以可以从系统层面优化性能，但是使用结构体仍旧与使用超类 非常 相似。因为我们没有使用协议的任何优势，目前的情况确实也没有什么能利用上的，为了访问类型的特定属性我们仍需有条件地进行类型判断和类型转换。

let modeB = ModelB(characters: [HeroB()])

// Type checking
if modeB.characters[0] is HeroB {
    print(modeB.characters[0].name)
}
// Type checking and Typecasting
if let hero = modeB.characters[0] as? HeroB {
    print(hero.power)
}


// MARK: ********* 枚举 *********

// MARK: - Models

struct Hero {
    let name: String
    let power: String
    
    init?(json: [String : AnyObject]) {
        guard let name = json["name"] as? String,
            let power = json["power"] as? String
            else { return nil }
        
        self.name = name
        self.power = power
    }
}

struct Princess {
    let name: String
    let kingdom: String
    
    init?(json: [String : AnyObject]) {
        guard let
            name = json["name"] as? String,
            let kingdom = json["kingdom"] as? String
            else { return nil }

        self.name = name
        self.kingdom = kingdom
    }
}

struct Civilian {
    let name: String
    
    init?(json: [String : AnyObject]) {
        guard let name = json["name"] as? String else { return nil }

        self.name = name
    }
}

enum Character {
    case hero(Hero)
    case princess(Princess)
    case civilian(Civilian)
    
    private enum Type1 : String {
        case hero, princess, civilian
        static let key = "type"
    }
    
    init?(json: [String : AnyObject]) {
        guard let
            string = json[Type1.key] as? String,
            let type = Type1(rawValue: string)
            else { return nil }
        
        switch type {
        case .hero:
            guard let hero = Hero(json: json) else { return nil }
            self = .hero(hero)
            
        case .princess:
            guard let princess = Princess(json: json) else { return nil }
            self = .princess(princess)
            
        case .civilian:
            guard let civilian = Civilian(json: json) else { return nil }
            self = .civilian(civilian)
        }
    }
}


// MARK: - Analyze

var characters: [Character] = []

do {
    let filePath = Bundle.main.path(forResource: "Typecasing", ofType: "json")
    let fileString = try String(contentsOfFile: filePath!)
    let fileUrl = URL(fileURLWithPath: filePath!)
    let jsonData = try Data(contentsOf: fileUrl)
    var jsonObj = try JSONSerialization.jsonObject(with: jsonData) as! [String: Any]
    
    let charactersValue = jsonObj["characters"]
    print(charactersValue!)
    
    if let characterArray = charactersValue as? [[String : AnyObject]] {
        characters = characterArray.flatMap { Character(json: $0) }
        print(characters)
    }
    
} catch _ {
    let error = "error"
}


// MARK: - Typecasing

print("\n")

characters.forEach { (character) in
    
    switch character {
    case .hero(let hero):
        print(hero.power)
        
    case .princess(let princess):
        print(princess.kingdom)
        
    case .civilian(let civilian):
        print(civilian.name)
    }
}


// MARK: - Typecasing with Pattern Matching

print("\n")

func printPower(character: Character) {
    if case .hero(let hero) = character {
        print(hero.power)
    }
}

characters.forEach { (character) in
    printPower(character: character)
}
