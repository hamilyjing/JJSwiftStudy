import UIKit

var str = "Hello, Error handling"

/*
0. error必须继承Error
*/

enum VendingMachineError: Error
{
    case InvalidSelection
    case InfufficientFunds(required: Double)
    case OutOfStock
}

/*
1. 必须在"声明"中加入throws关键字
*/

func canThrowErrors() throws -> String
{
    return "canThrowErrors";
}

func cannotThrowErrors() -> String
{
    return "cannotThrowErrors";
}

/*
2. 使用"throw"关键字抛出error
*/

func vend(itemNamed name: String) throws
{
    if "1" == name
    {
        throw VendingMachineError.OutOfStock
    }
    else if "2" == name
    {
        throw VendingMachineError.InfufficientFunds(required: 1.0)
    }
}

/*
3.1 必须使用"try"调用throws函数，但函数抛出error，try后面代码不再执行，使用try的函数必须声明为throws
3.2 如果确认throws函数不会抛出异常，可以使用"try!"
*/

func buyFavoriteSnake(person: String) throws
{
    try vend(itemNamed: "1")
    try vend(itemNamed: "2")
}

func test()
{
    try! buyFavoriteSnake(person: "1") // try!
}

/*
4. 使用do-catch捕获和处理error
*/

func doCatch() throws
{
    let amountRequired:Double = 2.0
    
    do
    {
        try vend(itemNamed: "1")
    }
    catch VendingMachineError.InvalidSelection
    {
        print("Invalid Selection.");
    }
    catch VendingMachineError.InfufficientFunds(amountRequired)
    {
        print("Invalid Selection.");
    }
}

/*
5.1 使用defer清理，defer在当前scope结束后调用
5.2 可以写多个defer，执行时倒序执行，先执行最后一个defer
5.3 有error抛出，则try后的defer不再执行，但try前的defer先执行，再执行catch
*/

func processFile(filename: String) throws
{
    do
    {
        defer
            {
                print("defer3");
                print("defer4");
        }
        
        /*
        defer1
        defer2
        defer3
        defer4
        */
        try vend(itemNamed: "2")
        
        /*
        defer3
        defer4
        Invalid Selection.
        */
        try vend(itemNamed: "1")
        
        defer
            {
                print("defer1");
                print("defer2");
        }
        
    }
    catch VendingMachineError.InvalidSelection
    {
        print("Invalid Selection.");
    }
}
