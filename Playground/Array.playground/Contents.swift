/*
数组用来按顺序存储相同类型的数据。
数组使用有序列表存储同一类型的多个值。相同的值可以多次出现在一个数组的不同位置中。
*/

var shoppingList: Array<String> = ["1", "2"] // 使用简化语法String[]代替Array<String>

var shoppingList1: [String] = ["1", "2"]
var shoppingList2: [String] = []
var shoppingList3 = [Int]()
var threeDoubles = [Double](repeating:0.0, count: 3)
var anotherThreeDoubles = Array(repeating: 2.5, count: 3) // 类型自我推断
var newArray = Array([1, 2])

let count = shoppingList1.count // 2
let empty = shoppingList2.isEmpty // true

// 加入元素
shoppingList1.append("3") // ["1", "2", "3"]
shoppingList1 += ["4"] // ["1", "2", "3", "4"]
shoppingList1 += ["5", "6"] // 添加数组，["1", "2", "3", "4", "5", "6"]

var firstItem = shoppingList1[0] // 获取值，"1"
shoppingList1[0] = "8" // 修改值 ["8", "2", "3", "4", "5", "6"]
shoppingList1[0] = "1" // ["1", "2", "3", "4", "5", "6"]
shoppingList1[2...3] = ["7", "8", "9"] // 还可以利用下标来一次改变一系列数据值，即使新数据和原有数据的数量是不一样的。我们不能使用下标语法在数组尾部添加新项。shoppingList1[6] = "7"

shoppingList1.insert("0", at: 0) // ["0", "1", "2", "3", "4", "5", "6"]

let mapleSyrup = shoppingList1.remove(at: 0) // "0", ["1", "2", "3", "4", "5", "6"]
let apples = shoppingList1.removeLast() // "6", ["1", "2", "3", "4", "5"]

// 遍历数组，for条件不能用括号括起来
for item in shoppingList1 {
    print(item)
}

for (index, value) in shoppingList1.enumerated() {
    print("Item \(index + 1): \(value)")
}

// 集合的可变性
/*
不可变性对数组来说，我们不能改变任何不可变数组的大小和内容。
在我们不需要改变数组大小的时候创建不可变数组是很好的习惯。
*/
let array1 = [1, 2]

// 赋值和拷贝行为
/*
如果你将一个数组（Array）实例赋给一个变量或常量，或者将其作为参数传递给函数或方法调用，在事件发生时数组的内容不会被拷贝。相反，数组公用相同的元素序列。当你在一个数组内修改某一元素，修改结果也会在另一数组显示。
对数组来说，拷贝行为仅仅当操作有可能修改数组长度时才会发生。这种行为包括了附加（appending）,插入（inserting）,删除（removing）或者使用范围下标（ranged subscript）去替换这一范围内的元素。只有当数组拷贝确要发生时，数组内容的行为规则与字典中键值的相同。
*/
var a = [1, 2, 3]
var b = a

a[0] = 42
print(a[0]) // 42
print(b[0]) // 42

a.append(4)
a[0] = 777
print(a[0]) // 777
print(b[0]) // 42

// 确保数组的唯一性
/*
在操作一个数组，或将其传递给函数以及方法调用之前是很有必要先确定这个数组是有一个唯一拷贝的。通过在数组变量上调用unshare方法来确定数组引用的唯一性。（当数组赋给常量时，不能调用unshare方法）
如果一个数组被多个变量引用，在其中的一个变量上调用unshare方法，则会拷贝此数组，此时这个变量将会有属于它自己的独立数组拷贝。当数组仅被一个变量引用时，则不会有拷贝发生。
*/
var c = [1, 2, 3]
var d = c
//d.unshare()
d[0] = -105
print(c[0]) // 1
print(d[0]) // -105

// 判定两个数组是否共用相同元素
/*
我们通过使用恒等运算符（identity operators）（ === 和 !==）来判定两个数组或子数组共用相同的储存空间或元素。
*/
var e = [1, 2, 3]
var f = e

if e == f // false, ??? not right when testing
{
    print("b and c still share the same array elements.")
}

if c == d // true
{
    print("b and c still share the same array elements.")
}

if e[0...1] == f[0...1] // 子数组是否相等
{
    print("These two subarrays share the same elements.")
}

// 强制复制数组
/*
如果你仅需要确保你对数组的引用是唯一引用，请调用unshare方法，而不是copy方法。unshare方法仅会在确有必要时才会创建数组拷贝。copy方法会在任何时候都创建一个新的拷贝，即使引用已经是唯一引用。
*/
var names = ["Mohsen", "Hilary", "Justyn", "Amy", "Rich", "Graham", "Vic"]
//var copiedNames = names.copy()
//copiedNames[0] = "Mo"
print(names[0]) // 输出 "Mohsen"
