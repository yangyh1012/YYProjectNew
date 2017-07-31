//
//  FirstViewController.swift
//  YYProjectNew
//
//  Created by yangyh on 2017/7/31.
//  Copyright © 2017年 yangyh. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    //demo 1
    //        print("Hello World!")

    //demo 2
    //        var myVariable = 42
    //        myVariable = 50
    //        let myConstant = 42

    //demo 3
    //        let explicitDouble : Double = 70
    //        let explicitFloat : Float = 70

    //demo 4
    //        let label = "The width is"
    //        let width = 94
    //        let widthLabel = label + String(width)

    //demo 5
    //        let apples = 3
    //        let oranges = 5
    //        let appleSummary = "I have \(apples) apples."
    //        let fruitsSummary = "I hava \(apples + oranges) pieces of fruit."
    //        print(appleSummary)
    //        print(fruitsSummary)
    //        let float = 3.5
    //        let words = "say something wiht \(float)"
    //        print(words)

    //demo 6
    //        var shopinglist = ["catfish","water","tulips","blue paint"]
    //        shopinglist[1] = "data"
    //
    //        var occupations = [
    //            "ddd":"ccc",
    //            "aaa":"eee"
    //        ]
    //        occupations["vvv"] = "rrr"
    //        print(shopinglist,occupations);

    //demo 7
    //        let emptyArray = [String]();
    //        let emptyDictionary = [String:Float]();

    //demo 8
    //        let individualScores = [75, 43, 103, 87, 12]
    //        var teamScore = 0
    //        for score in individualScores {
    //
    //            if score > 50 {
    //
    //                teamScore += 3
    //            } else {
    //
    //                teamScore += 1
    //            }
    //        }
    //
    //        print(teamScore)

    //demo 9
    //        var string = nil
    //        var string : String? = nil
    //        var optionValue : String? = "Hello"
    //        print(optionValue == nil)
    //
    //        var optionalName : String? = "Hello"
    //        print(optionalName == nil)
    //        var greeting = "Hello!"
    //        if let name = optionalName {
    //
    //            greeting = "Hello,\(name)"
    ////            print("您的地址是\(name)")
    //        } else {
    //
    //            greeting = "Hello,"
    //        }
    //
    //        print(greeting)
    //        var defaultAddress: String? = "江苏南京"
    //        if let address = defaultAddress { // 如果defaultAddress有值或类型转换成功，则将值赋值给address直接使用
    //            print("您的地址是\(address)")  // 使用address代替defaultAddress，且不需要加!强制解析
    //        } else {
    //            print("对不起，您不存在地址信息")
    //        }

    //demo 10
    //        let nickName : String? = nil
    //        let fullName : String? = "John Appleseed"
    //        let informalGreeting = "Hi \(nickName ?? fullName)"
    //        if informalGreeting != nil {
    //
    //            print(informalGreeting)
    //        }
    //        print(informalGreeting)

    //demo 11
    //        let vegetable = "red pepper"
    //        switch vegetable {
    //        case "celery":
    //            print("add some raisins and make ants on a log.")
    //        case "cucumber","watercress":
    //            print("That would make a good tea sandwich")
    //        case let x where x.hasPrefix("red"):
    //            print("Is it a spicy \(x)")
    //        default:
    //            print("Everything tastes good in soup.")
    //        }

    //demo 12
    //        let interestingNumbers = [
    //
    //            "Prime" : [2, 3, 5, 7, 11, 13],
    //            "Fibonacci" : [1, 1, 2, 3, 5, 8],
    //            "Square" : [1, 4, 9, 16, 25],
    //        ]
    //
    //        var largest = 0
    //        for (kind, numbers) in interestingNumbers {
    //
    //            for number in numbers {
    //
    //                if number > largest {
    //
    //                    largest = number
    //                }
    //            }
    //        }
    //
    //        print(largest)

    //demo 13
    //        var n = 2
    //        while n < 100 {
    //
    //            n = n * 2
    //        }
    //        print(n)
    //
    //        var m =  2
    //        repeat {
    //
    //            m = m * 2
    //        } while m < 100
    //        print(m)

    //demo 14
    //        var total = 0
    //        for i in 0 ... 4 {
    //
    //            total += i
    //        }
    //
    //        print(total)

    //demo 15
    //        func greet(person: String, day: String) -> String {
    //
    //            return "Hello \(person), today is \(day)."
    //        }
    //        print(greet(person: "Bob", day: "Tuesday"))
    //
    //        func greetOther(personName person: String, _ day: String) -> String {
    //
    //            return "hello \(person), today is \(day)"
    //        }
    //
    //        print(greetOther(personName: "Bob", "Sunday"));

    //demo 16
    //        func calculateStatistics(scores: [Int]) -> (min: Int,max : Int, sum:Int) {
    //
    //            var min = scores[0]
    //            var max = scores[0]
    //            var sum = 0
    //
    //            for score in scores {
    //
    //                if score > max {
    //
    //                    max = score
    //                } else if score < min {
    //
    //                    min = score
    //                }
    //
    //                sum += score
    //            }
    //
    //            return (min, max, sum)
    //        }
    //
    //        print(calculateStatistics(scores: [1, 2, 3, 4, 5, 6]))
    //        print(calculateStatistics(scores: [1, 2, 3, 4, 5, 6]).sum)

    //demo 17
    //        func sumOf(numbers: Int...) -> Int {
    //
    //            var sum = 0
    //            for number in numbers {
    //
    //                sum += number
    //            }
    //
    //            return sum
    //        }
    //
    //        print(sumOf())
    //        print(sumOf(numbers: 42, 598, 12))
    //
    //        func avergeOf(numbers: Int...) -> Double {
    //
    //            var sum = 0
    //            for number in numbers {
    //
    //                sum += number
    //            }
    //
    //            if numbers.count > 0 {
    //
    //                return Double(sum / numbers.count)
    //            }
    //
    //            return 0
    //        }
    //
    //        print(avergeOf())
    //        print(avergeOf(numbers: 10, 11, 12))

    //demo 18
    //        func returnFifteen() -> Int {
    //
    //            var y = 10
    //            func add() {
    //
    //                y +=  5
    //            }
    //            add()
    //
    //            return y
    //        }
    //
    //        print(returnFifteen())

    //demo 19
    //        func makeIncrementer() -> ((Int) -> Int) {
    //
    //            func addOne(number:Int) -> Int {
    //
    //                return 1 + number
    //            }
    //
    //            return addOne
    //        }
    //
    //        var increment = makeIncrementer()
    //        print(increment(7))

    //demo 20
    //        func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {
    //
    //            for item in list {
    //
    //                if condition(item) {
    //
    //                    return true
    //                }
    //            }
    //
    //            return false
    //        }
    //
    //        func lessThanTen(number:Int) -> Bool {
    //
    //            return number < 10
    //        }
    //
    //        var numbers = [20, 19, 7, 12]
    //        hasAnyMatches(list: numbers, condition: lessThanTen)

    //demo 21
    //        var numbers = [20, 19, 7, 12]
    //        let mapped = numbers.map({
    //
    //            (number: Int) -> Int in
    //
    //            let result = 3 * number
    //
    //            return result
    //        })
    //
    //        print(mapped);
    //
    //        let mapped2 = numbers.map { (number: Int) -> Int in
    //
    //            let result = number % 2
    //
    //            if result == 1 {
    //
    //                return 0
    //            }
    //
    //            return number
    //        }
    //
    //        print(mapped2);

    //demo 22
    //        var numbers = [20, 19, 7, 12]
    //        let mappedNumbers = numbers.map({number in 3 * number})
    //        print(mappedNumbers)

    //demo 23
    //        var numbers = [20, 19, 7, 12]
    //        let sortedNumbers = numbers.sorted{$0 > $1}
    //        print(sortedNumbers)

    //demo 24
    //        var shape = Shape(name: "22")
    //        shape.numberOfSides = 20
    //        var shapeD = shape.simple()
    //        print(shapeD)

    //demo 25
    //        let optionalSquare: Square
    //        let optionalSquare = Square(sideLength: 2.5, name: "optional square")
    //        optionalSquare.sideLength = 12.0
    //        print(optionalSquare.sideLength)
    //        let sideLength = optionalSquare.sideLength
    //
    //        let optionalSquare : Square? = Square(sideLength: 2.5, name: "optional square")
    //        let sideLength = optionalSquare?.sideLength
    //
    //        if sideLength != nil {
    //
    //            print(sideLength!)
    //        }
    //        print(sideLength)



    //demo 26
    //        enum Rank : Int {
    //
    //            case ACE = 1
    //            case two, three
    //            case jack, queen
    //            func simple() -> String {
    //
    //                switch self {
    //                case .ACE:
    //
    //                    return "ace"
    //                default:
    //                    return String(self.rawValue)
    //                }
    //            }
    //        }
    //
    //        let ace = Rank.ACE
    //
    //        print(ace.rawValue)
    //        print(ace.simple())
    //
    //        if let conv = Rank(rawValue: 3) {
    //
    //            let threeDescription = conv.simple()
    //            print(threeDescription)
    //        }

    //demo 27
    //        enum Suit {
    //
    //            case Spades, Hearts, Diamonds
    //            func simple() -> String {
    //
    //                switch self {
    //                case .Spades:
    //                    return "spades"
    //                default:
    //                    return "nothing"
    //                }
    //            }
    //        }
    //
    //        let hearts = Suit.Hearts
    //        let des = hearts.simple()
    //        print(des)
    //        print(Suit.Spades.simple())

    //demo 28
    //        enum ServerResponse {
    //
    //            case Result(String, String)
    //            case Failure(String)
    //        }
    //
    //        let success : ServerResponse = {
    //
    //            return ServerResponse.Result("123", "213")
    //        }()
    //
    //        let failed = ServerResponse.Failure("333")
    //        switch failed { //failed被判断为一个常量。
    //        case let .Result:
    //            print("123")
    //        default:
    //            print("333")
    //        }
    //
    //        switch success {
    //        case let .Result(sunrise, sunset):
    //            print("111\(sunrise) + \(sunset)")
    //        default:
    //            print("333")
    //        }

    //demo 29
    //        struct Card {
    //
    //            var rank: Rank
    //            var suit: Suit
    //            func simple() -> String {
    //
    //                return "the \(rank.simple()) of \(suit.simple())"
    //            }
    //        }
    //
    //        let three = Card(rank: .ACE,suit: .Spades)
    //        let threeof = three.simple()
    //        print(threeof)

    //demo 30
    //        class Simple: ExampleProtocol {
    //
    //            var simple: String = "123"
    //            var another: Int = 123
    //            func adjust() {
    //
    //                simple += " 333"
    //            }
    //        }
    //
    //        var a = Simple()
    //        a.adjust()
    //        print(a.simple)
    //
    //        struct Simples: ExampleProtocol {
    //
    //            var simple: String = "AAA"
    //            mutating func adjust() {
    //
    //                simple += " (adjusted"
    //            }
    //        }
    //
    //        var b = Simples()
    //        b.adjust()
    //        print(b.simple)

    //demo 31
    //        var a = 7
    //        a.adjust()
    //        print(a.simple)

    //demo 32
    //        var demo: ExampleProtocol = a
    //        print(demo.simple);

    //demo 32
    //        func send(job: Int, toPrinter printerName: String) throws -> String {
    //
    //            if printerName == "Never" {
    //
    //                throw PrintError.NoToner
    //            }
    //
    //            return "Job sent"
    //        }
    //
    //        do {
    //            let printWord = try send(job: 1, toPrinter: "Never1")
    //            print(printWord)
    //
    //
    //        } catch PrintError.NoToner {
    //
    //            print("aaa")
    //        } catch let printe as PrintError {
    //
    //            print(printe)
    //        } catch {
    //
    //            print(error)
    //        }

    //demo 33
    //        var fridgeIsOpen = false
    //        let fridgeContent = ["milk", "egg", "lefttovers"]
    //
    //        func fridgeContains(_ food: String) -> Bool {
    //
    //            fridgeIsOpen = true
    //            defer {
    //
    //                fridgeIsOpen = false
    //            }
    //
    //            let result = fridgeContent.contains(food)
    //
    //            return result
    //        }
    //
    //        print(fridgeContains("banana"))
    //        print(fridgeIsOpen)

    //demo 34
    //        func repeatItem<Item>(repeating item: Item, numbers: Int) -> [Item] {
    //
    //            var result = [Item]()
    //            for _ in 0..<numbers {
    //
    //                result.append(item)
    //            }
    //            
    //            return result
    //        }
    //        
    //        
    //        print(repeatItem(repeating: "add", numbers: 5))

    //demo 35
    //        enum OptionalValueM<Wrapped> {
    //            
    //            case None
    //            case Some(Wrapped)
    //        }
    //        var possible: OptionalValueM<Int> = .None
    //        possible = .Some(100)

    //demo 36
    //        func anyCommon<T: Sequence, U: Sequence>(_ lhs: T, _ rhs: U) -> Bool
    //            where T.Iterator.Element: Equatable, T.Iterator.Element == U.Iterator.Element {
    //            
    //            for lhsItem in lhs {
    //                
    //                for rhsItem in rhs {
    //                    
    //                    if lhsItem == rhsItem {
    //                        
    //                        return true
    //                    }
    //                }
    //            }
    //            
    //            return false
    //        }
        
        self.perform(#selector(FirstViewController.push), with: nil, afterDelay: 0.1)
    }

    func push() -> Void {

        let controller = SecondViewController()
        self.navigationController?.pushViewController(controller, animated: true);
    }

    //demo 32
    //    enum PrintError: Error {
    //        
    //        case Outofpager
    //        case NoToner
    //        case onFire
    //    }

    //demo 24
    //    class Shape {
    //        
    //        var numberOfSides = 0
    //        let numberOther = 1
    //        
    //        var name: String
    //        
    //        init(name: String) {
    //            
    //            self.name = name
    //        }
    //        
    //        func simple() -> String {
    //            
    //            return "haa"
    //        }
    //        
    //        func double(double: Int) -> String {
    //            
    //            return "ha \(double)"
    //        }
    //    }

    //demo 25
    //    class Square : Shape {
    //        
    //        var sideLength: Double = 2.5
    //        
    //        init(sideLength: Double, name: String) {
    //            
    //            self.sideLength = sideLength
    //            super.init(name: name)
    //            numberOfSides = 4
    //        }
    //        
    //        override func simple() -> String {
    //            
    //            return "dasfas"
    //        }
    //        
    //        var params: Double {
    //            
    //            get {
    //                
    //                return 3.0 * sideLength
    //            }
    //            
    //            set {
    //                
    //                sideLength = newValue / 3.0
    //            }
    //        }
    //    }

    //    func testOption() -> Int {
    //        
    //        let status: Int? = 1
    //        
    //        if status == nil {
    //            
    //            return 0
    //        } else {
    //            
    //            return status!
    //        }
    //    }

    //demo 29
    //    enum Rank : Int {
    //
    //        case ACE = 1
    //        case two, three
    //        case jack, queen
    //        func simple() -> String {
    //
    //            switch self {
    //            case .ACE:
    //
    //                return "ace"
    //            default:
    //                return String(self.rawValue)
    //            }
    //        }
    //    }
    //    
    //    enum Suit {
    //
    //        case Spades, Hearts, Diamonds
    //        func simple() -> String {
    //
    //            switch self {
    //            case .Spades:
    //                return "spades"
    //            default:
    //                return "nothing"
    //            }
    //        }
    //    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
