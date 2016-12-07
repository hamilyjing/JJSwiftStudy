/*
 字典虽然无序存储相同类型数据值但是需要由独有的标识符引用和寻址（就是键值对）。
 Key的唯一限制就是可哈希的，这样可以保证它是独一无二的，所有的 Swift 基本类型（例如String，Int， Double和Bool）都是默认可哈希的，并且所有这些类型都可以在字典中当做键使用。未关联值的枚举成员（参见枚举）也是默认可哈希的。
 */

var empt = Dictionary<String, String>()
var empty1: Dictionary<String, String> = [:]

var airports: Dictionary<String, String> = ["1": "11", "2": "22"]
var airports2: [String: String] = airports

// 加入，更新
let count = airports.count // 2
airports["3"] = "33" // 新加一项，["1": "11", "2": "22", "3": "33"]
airports["3"] = "44" // 修改一项，["1": "11", "2": "22", "3": "44"]
if let oldValue = airports.updateValue("33", forKey: "3") // updateValue方法返回更新值之前的原值
{
}

// 获取
if let airportName = airports["3"]
{ // 获取值，可能为nil
}

// 删除
print("\n-- 删除 --")

airports["3"] = nil // ["1": "11", "2": "22"]
if let removedValue = airports.removeValue(forKey: "2") // "22", ["1": "11"]
{
}

// 遍历
print("\n-- 遍历 --")

for (airportCode, airportName) in airports
{
}

for airportCode in airports.keys
{
}

for airportName in airports.values
{
}

// 集合的可变性
/*
 对字典来说，不可变性(let)也意味着我们不能替换其中任何现有键所对应的值。不可变字典的内容在被首次设定之后不能更改
 */
let dic = ["1": "11", "2": "22"] // 不能改变任何key和value的值

// 赋值和拷贝行为
/*
 无论何时将一个字典实例赋给一个常量或变量，或者传递给一个函数或方法，这个字典会即会在赋值或调用发生时被拷贝。
 如果字典实例中所储存的键（keys）和/或值（values）是值类型（结构体或枚举），当赋值或调用发生时，它们都会被拷贝。相反，如果键（keys）和/或值（values）是引用类型，被拷贝的将会是引用，而不是被它们引用的类实例或函数。字典的键和值的拷贝行为与结构体所储存的属性的拷贝行为相同。
 */
var ages = ["Peter": 23, "Wei": 35, "Anish": 65, "Katya": 19]
var copiedAges = ages // ages和copiedAges成为两个相互独立的字典
copiedAges["Peter"] = 24
print(ages["Peter"]!) // 输出 "23"
