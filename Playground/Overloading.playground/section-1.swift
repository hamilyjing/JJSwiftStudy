import UIKit

// +是已经存在操作符，不需要声明
func +(left: [Int], right: [Int]) -> [Int]
{
    var sum = [Int]()
    assert(left.count == right.count, "Array of same length only")
    
    for (key, _) in left.enumerated()
    {
        sum.append(left[key] + right[key])
    }
    
    return sum;
}

var sumArray = [1, 2] + [1, 2] // [2,4]

// 这里有三个步骤去定义一个自定义操作符：
/*
1.命名你的运算符
[现在你必须选择一个字符作为你的运算符。自定义运算符可以以/、=、-、+、！、*、%、<、>、&、|、^、~或者Unicode字符开始。这个给了你一个很大的范围去选择你的运算符。但是别太高兴，选择的时候你还必须考虑重复输入的时候更少的键盘键入次数。]

2.选择一种类型
[在Swift中你能定义一元、二元和三元的操作符。他们表明了运算符操作的数字的数目。

一元操作符与一个操作数相关，比如后置++(i++)或者前置++（++i），他们依赖于运算符与操作数出现的位置。
二元操作符是插入的，因为它出现在两个操作符中间，比如1 + 1。
三元操作符有三个操作数。在Swift中，?:条件操作符是唯一一个三目运算符，比如a?b:c。
你应该基于你的运算符的操作数的个数选择合适得类型。你想要实现两个数组相加，那就定义二元运算符。]

3.设置它的优先级和结合性
[结合性(associativity)的值可取的值有left，right和none。左结合运算符跟其他优先级相同的左结合运算符写在一起时，会跟左边的操作数结合。同理，右结合运算符会跟右边的操作数结合。而非结合运算符不能跟其他相同优先级的运算符写在一起。

结合性(associativity)的值默认为none，优先级(precedence)默认为100。

加法结合性和优先级(left和140)

这个是十分棘手的，所以有一个比较好的方法，在Swift language reference中找到一个类似的标准的运算符，然后使用相同的语义。例如，在定义向量加的时候，可以使用与+运算符相同的优先级和结合性。]
*/

// 定义新操作符
/*
新运算符可以声明为前置prefix，中置infix或后置postfix
*/
// 一元前置操作符
prefix operator +++ // 声明新操作符
prefix func +++( value: inout Int) -> Int
{
    value += 2;
    return value;
}
var value: Int = 1
+++value

// 二元中置操作符
infix operator ⊕ { associativity left precedence 140 }
func ⊕(left: [Int], right: [Int]) -> [Int] //只有中置操作符不用在func前加infix关键字
{
    assert(left.count == right.count, "should same count")
    var sum = [Int](repeating: 0, count: left.count);
    for (key, _) in left.enumerated()
    {
        sum[key] = left[key] + right[key];
    }
    return sum;
}
var sumArray1 = [1, 2] ⊕ [1, 2] // [2, 4]

// 一元后置操作符
postfix operator ---
postfix func ---( value: inout Int) -> Int
{
    value -= 2;
    return value;
}
var value2 = 3
value2---

// 使用泛型定义新操作符
protocol Number {  // 1
    static func +(l: Self, r: Self) -> Self // 2
}

extension Double : Number {} // 3
extension Float  : Number {}
extension Int    : Number {}

infix operator ⊕⊕ { associativity left precedence 140 }
func ⊕⊕<T: Number>(left: T, right: T) -> T
{
    return left + right;
}
var value5 = 1 ⊕⊕ 2




