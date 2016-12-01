
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
