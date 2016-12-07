/*
 Swift 的String和Character类型提供了一个快速的，兼容 Unicode 的方式来处理代码中的文本信息。
 每一个字符串都是由独立编码的 Unicode 字符组成，并提供了以不同 Unicode 表示（representations）来访问这些字符的支持。
 */

// 字符串字面量
/*
 字符串字面量可以包含以下特殊字符：
 转义字符\0(空字符)、\\(反斜线)、\t(水平制表符)、\n(换行符)、\r(回车符)、\"(双引号)、\'(单引号)。
 单字节 Unicode 标量，写成\xnn，其中nn为两位十六进制数。
 双字节 Unicode 标量，写成\unnnn，其中nnnn为四位十六进制数。
 四字节 Unicode 标量，写成\Unnnnnnnn，其中nnnnnnnn为八位十六进制数。
 */
let wiseWords = "\"我是男人\" - 路飞" // "我是男人" - 路飞
let dollarSign = "\u{24}"            // $,  Unicode 标量 U+0024
let blackHeart = "\u{2665}"          // ♥,  Unicode 标量 U+2665
let sparklingHeart = "\u{0001F496}"  // 💖, Unicode 标量 U+1F496

// 字符串是值类型
/*
 Swift 的String类型是值类型。 如果您创建了一个新的字符串，那么当其进行常量、变量赋值操作或在函数/方法中传递时，会进行值拷贝。 任何情况下，都会对已有字符串值创建新副本，并对该新副本进行传递或赋值操作。
 */

// 使用字符（Working with Characters）
for character in "Dog!🐶".characters {
    print(character, terminator: "\n")
}

// 计算字符数量 (Counting Characters)
/*
 不同的 Unicode 字符以及相同 Unicode 字符的不同表示方式可能需要不同数量的内存空间来存储。所以 Swift 中的字符在一个字符串中并不一定占用相同的内存空间。因此字符串的长度不得不通过迭代字符串中每一个字符的长度来进行计算。如果您正在处理一个长字符串，需要注意countElements函数必须遍历字符串中的字符以精准计算字符串的长度。 另外需要注意的是通过countElements返回的字符数量并不总是与包含相同字符的NSString的length属性相同。NSString的length属性是基于利用 UTF-16 表示的十六位代码单元数字，而不是基于 Unicode 字符。为了解决这个问题，NSString的length属性在被 Swift 的String访问时会成为utf16count。
 */
var string1 = "123"
let count = string1.characters.count // 3

// 字符串插值 (String Interpolation)
let multiplier = 3
let message = "\(multiplier) 乘以 2.5 是 \(Double(multiplier) * 2.5)" // message 是 "3 乘以 2.5 是 7.5"

var string2 = "123a"
var string3 = "123a"
var string4 = "123B"
let empty = string2.isEmpty // false, 是否空
let equal = string2 == string3 // true, 是否相等
let prefix = string2.hasPrefix("12") // true, 含有前缀
let suffix = string2.hasSuffix("12") // false, 含有后缀
let small = string4.lowercased // 123b, 小写
let large = string2.uppercased // 123A, 大写

// 字符串索引
// 每一个 String值都有相关的索引类型， String.Index，它相当于每个 Character在字符串中的位置。
// 你可以在任何遵循了 Indexable 协议的类型中使用 startIndex 和 endIndex 属性以及 index(before:) ， index(after:) 和 index(_:offsetBy:) 方法。这包括这里使用的 String ，还有集合类型比如 Array ， Dictionary 和 Set 。
let greeting = "Guten Tag!"
greeting[greeting.startIndex]
// G
greeting[greeting.index(before: greeting.endIndex)]
// !
greeting[greeting.index(after: greeting.startIndex)]
// u
let index = greeting.index(greeting.startIndex, offsetBy: 7)
greeting[index]
// a
//greeting[greeting.endIndex] // error
//greeting.index(after: greeting.endIndex) // error

// 使用 characters属性的 indices属性来创建所有能够用来访问字符串中独立字符的索引范围 Range。
for index in greeting.characters.indices {
    print("\(greeting[index]) ", terminator: "")
}
// Prints "G u t e n   T a g ! "

// 插入和删除
// 你可以在任何遵循了 RangeReplaceableIndexable 协议的类型中使用 insert(_:at:) ， insert(contentsOf:at:) ， remove(at:) 方法。这包括了这里使用的 String ，同样还有集合类型比如 Array ， Dictionary 和 Set 
var welcome = "hello"
welcome.insert("!", at: welcome.endIndex)
// welcome now equals "hello!"

welcome.insert(contentsOf:" there".characters, at: welcome.index(before: welcome.endIndex))
// welcome now equals "hello there!"

welcome.remove(at: welcome.index(before: welcome.endIndex))
// welcome now equals "hello there"

let range = welcome.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex
welcome.removeSubrange(range)
// welcome now equals "hello"



// Unicode
/*
 Unicode 是一个国际标准，用于文本的编码和表示。 它使您可以用标准格式表示来自任意语言几乎所有的字符，并能够对文本文件或网页这样的外部资源中的字符进行读写操作。
 
 Swift 的字符串和字符类型是完全兼容 Unicode 标准的，它支持如下所述的一系列不同的 Unicode 编码。
 
 
 Unicode 术语（Unicode Terminology）
 Unicode 中每一个字符都可以被解释为一个或多个 unicode 标量。 字符的 unicode 标量是一个唯一的21位数字(和名称)，例如U+0061表示小写的拉丁字母A ("a")，U+1F425表示小鸡表情 ("🐥")
 
 当 Unicode 字符串被写进文本文件或其他存储结构当中，这些 unicode 标量将会按照 Unicode 定义的集中格式之一进行编码。其包括UTF-8（以8位代码单元进行编码） 和UTF-16（以16位代码单元进行编码）。
 
 
 字符串的 Unicode 表示（Unicode Representations of Strings）
 Swift 提供了几种不同的方式来访问字符串的 Unicode 表示。
 
 您可以利用for-in来对字符串进行遍历，从而以 Unicode 字符的方式访问每一个字符值。 该过程在 使用字符 中进行了描述。
 
 另外，能够以其他三种 Unicode 兼容的方式访问字符串的值：
 
 UTF-8 代码单元集合 (利用字符串的utf8属性进行访问)
 UTF-16 代码单元集合 (利用字符串的utf16属性进行访问)
 21位的 Unicode 标量值集合 (利用字符串的unicodeScalars属性进行访问)
 下面由D``o``g``!和🐶(DOG FACE，Unicode 标量为U+1F436)组成的字符串中的每一个字符代表着一种不同的表示：
 
 let dogString = "Dog!🐶"
 
 UTF-8
 您可以通过遍历字符串的utf8属性来访问它的UTF-8表示。 其为UTF8View类型的属性，UTF8View是无符号8位 (UInt8) 值的集合，每一个UInt8值都是一个字符的 UTF-8 表示：
 
 for codeUnit in dogString.utf8 {
 print("\(codeUnit) ")
 }
 print("\n")
 // 68 111 103 33 240 159 144 182
 上面的例子中，前四个10进制代码单元值 (68, 111, 103, 33) 代表了字符D o g和!，它们的 UTF-8 表示与 ASCII 表示相同。 后四个代码单元值 (240, 159, 144, 182) 是DOG FACE的4字节 UTF-8 表示。
 
 
 UTF-16
 您可以通过遍历字符串的utf16属性来访问它的UTF-16表示。 其为UTF16View类型的属性，UTF16View是无符号16位 (UInt16) 值的集合，每一个UInt16都是一个字符的 UTF-16 表示：
 
 for codeUnit in dogString.utf16 {
 print("\(codeUnit) ")
 }
 print("\n")
 // 68 111 103 33 55357 56374
 同样，前四个代码单元值 (68, 111, 103, 33) 代表了字符D o g和!，它们的 UTF-16 代码单元和 UTF-8 完全相同。
 
 第五和第六个代码单元值 (55357 和 56374) 是DOG FACE字符的UTF-16 表示。 第一个值为U+D83D(十进制值为 55357)，第二个值为U+DC36(十进制值为 56374)。
 
 
 Unicode 标量 (Unicode Scalars)
 您可以通过遍历字符串的unicodeScalars属性来访问它的 Unicode 标量表示。 其为UnicodeScalarView类型的属性， UnicodeScalarView是UnicodeScalar的集合。 UnicodeScalar是21位的 Unicode 代码点。
 
 每一个UnicodeScalar拥有一个值属性，可以返回对应的21位数值，用UInt32来表示。
 
 for scalar in dogString.unicodeScalars {
 print("\(scalar.value) ")
 }
 print("\n")
 // 68 111 103 33 128054
 同样，前四个代码单元值 (68, 111, 103, 33) 代表了字符D o g和!。 第五位数值，128054，是一个十六进制1F436的十进制表示。 其等同于DOG FACE的Unicode 标量 U+1F436。
 
 作为查询字符值属性的一种替代方法，每个UnicodeScalar值也可以用来构建一个新的字符串值，比如在字符串插值中使用：
 
 for scalar in dogString.unicodeScalars {
 println("\(scalar) ")
 }
 // D
 // o
 // g
 // !
 // 🐶
 */