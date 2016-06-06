//
//  PreloadedWords.swift
//  S1
//
//  Created by 文川术 on 5/29/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import Foundation


struct PreloadedWords {

	let arrays = [["0", "as", "1. 用于类型判断和转换\n2. as!用于强制转换，as?用于可为空转换", "let text = \"这是一个String类型\"\nlet length = (text as NSString).length\n// 把string类型转换成NSString类型\n\nlet string = text as! String\n// 强制转换，如果无法转换，程序出错\n\nif let optionalString = text as? NSString {\n\t// 可选转换，如果无法转换，则跳过\n}"], ["6", "get", "运算属性的getter方法，用来进行逻辑处理，可对其他储存属性进行修改，与setter方法对应", "class Square {\n    var width = 0\n    var round: Int {\n        get {\n            return width * 4\n        }\n\n        set {\n            width = newValue / 4\n        }\n    }\n}\n\nvar block = Square()\nblock.width = 8\nprint(block.round) // 输出：32\nblock.round = 16\nprint(block.width) // 输出：4"], ["2", "continue", "1. 用在循环结构中，结束本次循环，忽略continue后的代码，开始下一次循环", "let numbers = [1, 2, 3]\nfor number in numbers {\n    if number == 2 {\n        continue\n    }\n    print(number)\n}\n\n// 输出1和3，不会输出2"], ["3", "deinit", "1. 析构方法，用于销毁对象、释放内存", "class Observer {\n\n    init() {\n        NSNotificationCenter.defaultCenter().addObserver(self, selector: nil, name: nil, object: nil)\n    }\n\n    deinit {\n        NSNotificationCenter.defaultCenter().removeObserver(self)\n    }\n\n}\n\n// 对象被销毁前，需要的操作在deinit {} 中执行"], ["8", "is", "类型判断关键词", "let VC = UIViewController()\nswitch VC {\ncase is UITableViewController:\n    break\ncase is UINavigationController:\n    break\ndefault: \n    break\n}\n\n// 判断VC的类型，UITableViewController, UINavigationController都继承于UIViewController"], ["1", "break", "1. 在循环语句中，终止并跳出循环\n2. 终止switch语句的情况（case）", "let numbers = [1, 2, 3]\nfor number in numbers {\n    if number == 2 {\n        break // 当循环到2就终止循环\n    }\n}\n\nswitch numbers[0] {\ncase 1:\n    break // 当numbers第0个数为1时，终止switch\ndefault:\n    print(\"不是1的情况\")\n}"], ["2", "class", "1. 定义和声明一个类\n2. 定义类属性或类方法：不依赖于具体对象的属性或方法", "// 1\nclass ColorOfNature {\n    // 2\n    class func skyBlue() -> UIColor() {\n        return UIColor.blueColor()\n    }\n\n}\n// 3\nlet skyColor = ColorOfNature.skyBlue()\n\n// 1. 定义一个名为ColorOfNature的类\n// 2. 定义一个名为skyBlue的类方法\n// 3. 使用类名+点语法调用类方法，不需要创建对象"], ["2", "case", "1. switch-case语句的组成部分，表明一种情况", "let age = random() % 101 // age为0~100之间的随机数\nswitch age {\ncase 0..<18:\n    print(\"未成年人\")\ncase 18...100:\n    print(\"成年人\")\ndefault:\n    break\n}"], ["3", "default", "1. switch-case语句中case以外的情况\n2. 指代默认参数", "let age = random() % 101 // age为0~100间的随机数\n\nswitch age {\ncase 0..<18:\n    print(\"未成年人\")\ndefault:\n    print(\"成年人\")\n}\n\npublic func NSLocalizedString(key: String, tableName: String? = default, bundle: NSBundle = default, value: String = default, comment: String) -> String\n// 系统自带的 NSLocalizedString 方法使用default指代和隐藏默认参数"], ["3", "do", "1. do-while循环语句关键词\n2. do-catch循环语句关键词", "var i = 0\ndo {\n    i += 1\n} while i < 10\n// 当i等于10时停止循环\n\ndo {\n    try checkNetWorkIsOk()\n} catch let error as NSError {\n    print(error)\n}\n// do-catch用于异常处理，和带有throws关键词的方法配合使用"], ["3", "dynamicType", "1. 获取对象类型关键字", "let string = \"what a nice day\"\nlet type = string.dynamicType\nprint(type)\n\n// 输出：String"], ["3", "dynamic", "实现 KVO(Key-Value Observing) 时，用于标记要观测的对象", "class ChangingDate: NSDate {\n\n    dynamic var date = NSDate()\n\n    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String: AnyObject]?, context: UnsafeMutablePointer<Void>) {\n    // 当 date 的值变化时，这个方法会被调用\n    }\n}\n\n"], ["3", "didSet", "用于观察和监视属性值变化，当属性值已经发生改变时触发", "class User {\n    \n    var name: String = \"\" {\n        didSet {\n            print(\"用户名为\" + name)\n        }\n    }\n\n    init(name: String) {\n        self.name = name\n    }\n\n}\n\nlet user = User(name: \"小明\")\n// 输出：用户名为小明"], ["4", "extension", "1. 扩展关键词，用于向一个已有的类、结构体或枚举添加新方法，也可添加计算属性\n2. 用于实现协议（protocl）", "extension UIColor {\n \n    class func myColor() -> UIColor() {\n        return UIColor(red: 220/255, green: 57/255, blue: 59/255, alpha: 1.0)\n    }\n\n}\n// 给已有类添加方法\n\nprotocol Flyable {\n    var speed: Double { get }\n}\n\nextension Flyable {\n    var speed: Double {\n        return 12.3\n    }\n}\n// 用于实现协议"], ["4", "enum", "定义枚举类型关键词", "enum Language: String {\n    case Chinese, Engilsh, Swift\n}\n\nenum Direction: Int {\n    case North\n    case South\n    case East\n    case West\n}\n\nprint(Direction.North.rawBalue)\n// 输出：0"], ["4", "else", "1. if-else循环语句关键词\n2. guard语句组成部分", "let rating: AnyObject = 4\nguard let star = rating as? Int else { return }\nprint(String(star) + \"星\")\n\nif star < 3 {\n    print(\"不好看的电影\")\n} else if star >= 3 && star < 5 {\n    print(\"还不错的电影\")\n} else {\n    print(\"非常棒的电影\")\n}\n\n// 输出：4星\n// 输出：还不错的电影"], ["5", "false", "布尔类型（Bool）值的一种，另一种是true", "let a: Bool = true\nlet b: Bool = false\nprint(a == b)\n\n// 输出: false"], ["5", "func", "定义方法的关键字", "func sayHi() {\n    print(\"what\'s up\")\n}\n\nfunc speed(time: Double, distance: Double) -> Double {\n    return distance / time\n}\n\nsayHi()\nprint(speed(10, distance: 100))\n\n// 输出：what\'s up\n// 输出：10.0"], ["5", "fallthrough", "作用：在switch-case语句中，当一个case结束后，继续执行下一个case", "var age = 3\n\nswitch age {\ncase 0...7:\n    print(\"儿童\")\n    fallthrough\ncase 3...9:\n    print(\"小孩\")\ndefault:\n    break\n}\n\n// 输出：儿童和小孩，如果没有fallthrough只输出儿童"], ["5", "for", "for-in循环语句关键词", "let array = [\"一\", \"二\", \"三\"]\nfor (index, word) in array.enumerate() {\n    print(String(index) + \" \" + word)\n}\n\n// 输出：0 一\n// 输出：1 二\n// 输出：2 三"], ["6", "guard", "判断语句关键词，判断一段代码是否该被执行", "let x: AnyObject = 3\n\nguard let y = x as? Int else { return }\n\nguard let y = y where y < 0 else {\n    // 变量不符合条件时，执行这里的代码\n    return\n}\n\n"], ["8", "import", "导入框架头文件关键词", "import UIKit\n\nclass viewController: UIViewController {\n\tvar string: String!\n}\n\n// 要想使用UIViewController和String类型，需要导入UIKit和Foundation, UIKit包含Foundation"], ["8", "init", "构造方法关键词，用于对象初始化的方法，初始化是类，结构体和枚举类型实例化的准备阶段", "class Car {\n\n\tvar speed: Double\n\n\tinit() {\n\t\tspeed = 70.0\n\t}\n\n}\n\nlet car = Car()\nprint(car.speed)\n// 输出：70.0\n// 当对象初始化时，构造方法自动调用，该方法可以带参数也可以不带"], ["8", "if", "if-else判断语句关键词，后跟判断条件", "var rating = 4\nif rating < 3 {\n\tprint(\"不好看的电影\")\n} else if rating < 5 && rating >= 3 {\n\tprint(\"还不错的电影\")\n} else {\n\tprint(\"非常棒的电影\")\n}\n\n// 输出：还不错的电影"], ["8", "in", "1. for-in循环关键词\n2. 闭包表达式关键词", "let names = [\"Swift\", \"iOS\", \"Xcode\"]\nfor (index, name) in names.enumerate() {\n\tprint(String(index) + \" \" + name)\n}\n// 输出：0 Swift\n// 输出：1 iOS\n// 输出：2 Xcode\n\nUIView.animateWithDuration(0.5, animations: {\n\tself.view.alpha = 1.0\n\t}) { (completed) in\n\t\t// 这是一个有参数没有返回值的闭包\n}"], ["8", "inout", "用于修饰函数参数，使该方法可以修改函数外变量的值", "func changeValue(inout a: Int, inout b: Int) {\n\tlet temp = a\n\ta = b\n\tb = temp\n}\n\nvar a = 0\nvar b = 1\nchangeValue(&a, b: &b)\nprint(a) // 输出：1\nprint(b) // 输出：0"], ["11", "lazy", "懒加载关键词，被标示的储存属性只有在被用到时加载，不在对象初始化时加载", "class BigData {\n\tvar title = \"short title\"\n\tlazy var content = \"this content is very very big\"\n}\n\nlet data = BigData()\n// 此次data的content属性还没加载\nlet content = data.content\n// 在被用到时，content才加载，懒加载的作用是提高内存使用效率"], ["11", "let", "声明常量的关键词，常量一旦赋值，不可修改。与声明变量关键词var对应。", "let homeland = \"China\"\n\n// 用let给不需要改变的属性赋值\n\n\nlet score = 99\nscore += 1\n\n// 上面的+=运算无法进行，系统会报错\n"], ["12", "mutating", "1. 修饰结构体（struct）或枚举（enum）类型里方法的关键词，让该方法可以修改该类型中的变量\n2. 也可以用于协议（protocol）内方法的定义和使用", "struct Person {\n\tvar age = 20\n\n\tmutating func grow() {\n\t\tage += 1\n\t}\n}\n\nlet someone = Person()\nsomeone.grow()\nprint(someone.age)\n// 输出：21"], ["13", "nonmutating", "1. 修饰结构体（struct）或枚举（enum）类型里方法的关键词，让该方法无法修改该类型中的变量。如果不修饰，默认是nonmutating\n2. 也可以用于协议（protocol）内方法的定义和使用", "struct Person {\n\tvar mom = \"Lovely\"\n\n\tnonmutating func changeMom() {\n\t\tmom = \"Beautiful\"\n\t}\n}\n\n// 无法这样写，系统会报错"], ["13", "nil", "对象值为空的情况", "let empty: Int! = nil\nvar maybeEmpty: Int?\nmaybeEmpty = empty\n\nprint(maybeEmpty)\n// 输出：nil"], ["14", "optional", "在协议中定义可选方法，可实现也可不实现的方法", "@objc protocol someType {\n\tfunc mustHave()\n\toptional func youDontNeedTo()\n}\n\n// 当实现协议someType时，mustHave()是必须实现的方法，youDontNeedTo()则可实现也可不实现\n// 想要使用optional, 定义协议时必须用@objc标示"], ["14", "override", "重载，用于子类重写父类的属性或方法", "class OldMan {\n\tvar firstName: String\n\n\tfunc goHome() {\n\t}\n}\n\nclass YoungMan: OldMan {\n\toverride var firstName: String {\n\t\tget {\n\t\t\treturn super.firstName\n\t\t}\n\n\t\tset {\n\t\t}\n\t}\n\n\toverride func goHome() {\n\t\t// do something different here\n\t}\n}"], ["15", "protocol", "定义协议关键字，Protocol(协议)用于统一方法和属性的名称，而不实现任何功能。协议能够被类，枚举，结构体实现，满足协议要求的类，枚举，结构体被称为协议的遵循者。", "protocol CanSaveData {\n\tvar content: String { get }\n\tfunc save()\n}\n\nstruct Notes: CanSaveData {\n\tvar content: String {\n\t\treturn \"content\"\n\t\t// Notes必须含有content这个变量，才能实现CanSaveData协议\n\t}\n\n\tfunc save() {\n\t\t// 要实现CanSaveData协议，Notes必须有save()方法\n\t}\n}"], ["15", "public", "访问修饰符，被修饰的属性或方法是公开的，可以在任何地方访问和使用", "struct PublicKnowledge {\n\tpublic let earthCount = 1\n\n\tpublic func whoIsObama() -> String {\n\t\treturn \"president of the united states\"\n\t}\n}\n\nlet count = PublicKnowledge().earthCount\nlet answer = PublicKnowledge().whoIsObama()\n// public修饰的属性或方法，可以任意访问"], ["15", "private", "访问修饰符，被修饰的属性或方法只能在当前的Swift源文件里可以访问", "struct Secret {\n\tprivate let salary = 0\n\n\tprivate func howToMakeMyselfHappy() {\n\n\t}\n}\n\nlet secret = Secret()\nlet steal = secret.salary\nlet learn = secret.howToMakeMyselfHappy()\n// 如果在不同的文件里写调用代码，后两行无法运行，系统报错"], ["17", "return", "返回关键词，表示一段代码运行结束并跳出，return后可跟返回值也可以单独return", "func getLength(string: AnyObject) -> Int? {\n\tguard let text = string as? NSString else { return nil }\n\treturn text.length\n}\n\nfunc printNumber(anyObject: AnyObject) {\n\tguard let number = anyObject as? Int else { return }\n\t// 如果anyObject不是Int类型，则返回，不执行下面的代码\n\tprint(number)\n}"], ["18", "static", "在结构体或枚举类型中，修饰静态属性，静态属性指与具体实例无关，所有实例都共享和一样的属性", "struct RichPeople {\n\tstatic let millionaire = 1000000\n\tstatic let billionaire = 1000000000\n}\n\nlet me = RichPeople.millionare\n// 静态属性可以不创建实例，直接调用\n// 像百万富翁这样不会改变的定义，适合做成静态属性"], ["18", "struct", "定义结构体关键字，结构体是Swift里一种基本数据结构单位，功能全面，算是一种轻量级的类（class）", "struct Resolution {\n\tvar width = 1242\n\tvar height = 2208\n\tvar PPI = 72\n}\n// 结构体的声明和使用大体上和类相似，但没有继承特性，无法作为一个对象被重复引用。"], ["18", "subscript", "下标，一种快捷的访问对象属性的方式，使用方法和数组或字典的使用方法类似", "class TestClass {\n    var testArray = Dictionary<Int, String>()\n    subscript(index: Int) -> String {\n        set {\n            testArray[index] = newValue\n        }\n\n        get {\n            return \"\"\n        }\n    }\n}\n\nvar test = TestClass()\ntest[2] = \"hello\"\nprint(test.testArray)\n// 输出：[2: \"hello\"]"], ["18", "switch", "switch-case判断语句组成部分，后跟要判断的对象", "let randomNumber = random() // 任意随机数\nlet luckNumber = 888\n\nswitch randomNumber {\ncase luckNumber:\n\tprint(\"中奖了！\")\ndefault:\n\tprint(\"概率太低，中不了\")\n}"], ["18", "super", "在子类中，调用父类方法时使用的关键词", "override func viewDidLoad() {\n\tsuper.viewDidLoad()\n\t// 重写父类方法后，又调用父类方法，这样既可以执行父类的代码，也可以在这里写子类独有的代码\n\t}\n}"], ["18", "self", "在对象内部，用于指代对象自身", "class BankAccount {\n\tvar number: Int\n\n\tinit(number: Int) {\n\t\tself.number = number\n\t\t// 前一个number指BankAccount类的属性，后一个number是构造方法的参数\n\t}\n}"], ["18", "Self", "在对象外部，用于指代对象自身", "extension UIContentContainer where Self: UIViewController {\n\t// 仅当实现对象是UIViewController时，UIContentContainer的扩展\n}"], ["19", "typealias", "定义类型别名的关键词，通过取一个别名，方便管理和使用", "typealias 数字 = Int\nlet number: 数字 = 1\nprint(number)\n// 输出：1。给Int类型取了个中文别名：数字。当然实际编程不建议这样中英混用\n\ntypealias simpleFuncion = () -> ()\nlet doNothing: simpleFuncion = {}\n// 也可以给闭包取别名"], ["19", "try", "用于执行一些可能会抛出异常的操作\ntry!是强制操作，不处理异常，try?的返回结果是Optional\n通常配合do-catch语句运行可能会抛出异常的方法", "do {\n\tif let dicts = try managedContext.executeFetchRequest(fetchRequest) as? [AnyObject] {\n\t\t// 当executeFetchRequest正常执行，在这里进行接下来的操作\n\t}\n} catch {\n\t// 如果出现异常，则执行这里面的代码\n\tprint(\"something wrong\")\n}"], ["19", "true", "布尔类型（Bool）值的一种，另一种是false", "let right: Bool = true\nlet wrong: Bool = false\nprint(right == !wrong)\n\n// 输出：true, !为取反操作符"], ["20", "unowned", "避免循环引用关键词，当用unowned设置一个对象，它不能为可选类型，必须在构造方法里初始化。与之对应的weak可以是可选类型，也可以为nil", "protocol ModelObjectDelegate: class {\n}\n\nclass ModelObject {\n\t// 可选类型默认初始值为nil\n\tunowned var delegate: ModelObjectDelegate\n\n\tinit(delegate:ModelObjectDelegate) {\n\t\tself.delegate = delegate\n\t}\n}"], ["21", "var", "定义变量关键词，初始化后的值可以改变的量为变量", "var a: Int? = 10\na = 100\nprint(a) // 输出：100\na = nil\nprint(a) // 输出：nil"], ["22", "where", "类型或条件判断关键词", "extension UIContentContainer where Self: UIViewController {\n\t// 判断实现UIContentContainer的对象的类型是否为UIViewController\n}\n\nlet yetAnotherPoint = (1, -1)\nswitch yetAnotherPoint {\ncase let (x, y) where x == y:\n\tprint(\"(\\(x), \\(y)) is on the line x == y\")\ncase let (x, y) where x == -y:\n\tprint(\"(\\(x), \\(y)) is on the line x == -y\")\n}\n// 输出： \"(1, -1) is on the line x == -y\""], ["22", "while", "do-while、while循环语句关键词，while后面跟循环的条件", "var i = 0\ndo {\n\ti += 1\n} while i < 100\nprint(i) // 输出：100\n\nwhile i < 100 {\n\ti += 1 \n}\nprint(i) // 输出同样为100\n\n// do-while和while循环语句的区别是：前者在循环开始前判断条件，后者在循环结束后判断条件决定是否开始下一次循环"], ["22", "weak", "声明弱引用关键词，用于避免循环引用导致的内存泄露。被声明的对象是可选类型，也可以为nil", "@objc protocol RequestHandler {\n\toptional func requestFinished()\n}\n\nclass Request {\n\tweak var delegate: RequestHandler!\n\n\tfunc gotResponse() {\n\t\tdelegate?.requestFinished?()\n\t}\n}\n// 把delegate用weak标示，可以确保当Request不再被使用时，可顺利从内存中销毁"], ["22", "willSet", "给属性添加观察者。当属性值将要改变时，触发willSet里的代码", "var age = 20 {\n\twillSet {\n\t\tprint(\"I\'m no longer\" + String(oldValue))\n\t}\n}\n\nage = 21\n// 输出：\"I\'m no longer 20\""], ["26", "#column", "所在列数的字面表达式，是Int类型", "print(#column)\n// 输出：1。说明上面一行代码的开头在文件的第一列"], ["26", "#file", "所在文件名的字面表达式，是String类型", "print(#file)\n// 输出：/user/开发常见词汇.swift\n// 输出的将是文件位置和文件名"], ["26", "#function", "所在声明的名字，String类型\n在函数中会返回当前函数的名字，在方法中会返回当前方法的名字，在属性的存取器中会返回属性的名字", "func thisIsASimpleFunction() {\n\tprint(#function)\n}\n\nthisIsASimpleFunction()\n// 输出：thisIsASimpleFunction()"], ["26", "#line", "所在的行数的字面表达式，Int类型", "print(#line)\n// 输出：6。说明上面一行在文件的第六行"], ["26", "#selector", "调用方法的关键词，通常在给按钮添加点击事件时使用", "let button = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(buttonTapped))\n// 其中buttonTapped是对象（self）中的无参方法\n// Swift2.2后，这样调用可以自动对方法进行检查，确保不出错"], ["0", "Array", "数组，集合类型，用来按顺序存储相同类型数据", "var intList: [Int] = [10, 11, 12]\nvar array: Array\nvar emptyArray = []\nvar intList_1 = Array<Int>()\n// 数组的声明形式很宽泛\n\nvar list = [\"hello\", \"world\"]\nprint(list[0] + \" \" + list[1])\n// 输出：\"hello world\"\n// 数组的数据是有顺序位置的，通过位置编号访问和修改元素"], ["0", "AnyObject", "指代任意数据类型，可为空", "let Anything: [AnyObject] = [3, \"String\", 3.5, true, [2, 3]]\nif let string = Anything[1] as? String {\n\t// AnyObject是用来指代其他类型，调用得先进行类型转换\n}\n\nvar a: AnyObject = 3\na = \"String\"\nprint(a)\n// 指代的类型可以变更"], ["1", "Bool", "布尔类型，值只能为true或false\nBool?是可选类型，值可为nil", "let raining = false\nraining ? print(\"带雨伞\") : print(\"不带雨伞\")\n// 输出：不带雨伞\n\nlet number = 3\nlet equal: Bool = (number == 3)\nprint(equal)\n// 输出：true\n// 比较运算符==输出一个布尔类型结果"], ["2", "CGRect", "包含控件位置和大小信息的结构体，控件的frame、bounds属性是CGRect类型", "let button = UIButton()\nbutton.frame = CGRect(x: 10, y: 10, width: 100, height: 100)\nlet differentRect: CGRect = CGRectMake(0, 0, 100, 100)\nbutton.bounds = differentRect\n\n// 控件的frame和bounds属性包含了控件的x、y坐标，宽和高信息。"], ["2", "CGSize", "包含控件大小信息的结构体，有宽和高两个属性。", "let view = UIView()\nview.frame.size = CGSize(width: 200, height: 200)\nlet newSize: CGSize = CGSize(width: 300, height: 300)\nview.frame.size = newSize\nview.frame.size.width = 400\nview.frame.size.height = 800\n\n// UIView的frame属性类型是CGRect，CGRect里的size属性类型是CGSize"], ["2", "CGPoint", "包含控件位置信息的结构体，有x和y两个属性\n代表控件最左上角一点的x坐标和y坐标", "let label = UILabel()\nlabel.frame.origin = CGPoint(x: 20, y: 20)\nlabel.frame.origin.x = 30\nlabel.frame.origin.y = 60\n\n// UIView的frame属性类型是CGRect，CGRect里的origin属性类型是CGPoint"], ["2", "CGAffineTransform", "字面意思仿射转换，包含控件缩放、旋转、平移等转换信息的结构体", "let view = UIView()\nview.transform = CGAffineTransformMakeScale(0.8, 0.8)\n// 让view缩小为原大小的0.8\n\nview.transform = CGAffineTransformMakeRotation(CGFloat(180 * M_PI / 180))\n// 让view旋转180度\n\nview.transform = CGAffineTransformMakeTranslation(100, 100)\n// 让view向右和向下移动100个像素\n\n// UIView的transform属性是CGAffineTransform类型"], ["3", "Double", "64位的浮点数字类型，浮点指有小数点\n当需要存储很大或者精度很高的浮点数时，使用此类型", "let int: Int = 12\nlet double: Double = 12\nprint(int) // 输出：12\nprint(double) // 输出：12.0\n\nlet double = -2342348347.234230948203948"], ["5", "Float", "32位的浮点数字类型，浮点指有小数点，当存储大小和精度要求不高用此类型\n常用的CGFloat, 可以算是Float同时也是Double类型的别名，它能很好兼容64位系统", "let float: Float = 13421\nvar value: CGFloat = 3423.34342342342342\nvalue = CGFloat(float)\nprint(value)\n// 输出：13421.0"], ["8", "Int", "整形，指没有小数点的整数类型\n按照位数衍生的有Int8, Int16, Int32, Int64. 分别对应不同的最大长度\nInt可以是正数和负数，UInt只能是正数", "let int: Int = 100000\nlet longInt: Int64 = -2342342342342534234223\nlet positiveInt: UInt = 123456\n\nprint(Int8.max) // 输出：127\nprint(UInt8.max) // 输出：255"], ["13", "NSNumber", "用来存储数字值的类型，可以存储char a signed or unsigned char, short int, int, long int, long long int, float, or double or as a BOOL", "import Foundation\nimport CoreData\n\nextension SwiftDict {\n\n@NSManaged var index: NSNumber?\n@NSManaged var word: String?\n\n}\n// CoreData里默认数字类型是NSNumber\n// NSNumber的兼容性好，对于任何类型的数字对象都能用它来声明"], ["13", "NSDate", "提供和处理日期和时间的类", "let today = NSDate()\nlet yesterday = NSDate(timeIntervalSinceNow: -86400)\nprint(today) // 输出：2016-06-01 02:22:27 +0000\nprint(yesterday) // 输出：2016-05-31 02:22:27 +0000\n\n// NSDate的默认是UTC全球时间\n\nlet formatter = NSDateFormatter()\nformatter.dateFormat = \"yyyy-MM-dd, HH:mm:ss\"\nlet localDate = formatter.stringFromDate(today)\nprint(localDate) // 输出：2016-06-01, 10:22:27\n\n// 想要输出本地时间，要用到NSDateFormatter"], ["13", "NSData", "二进制数据流类型，创建后不可修改，在文件操作，网络，以及核心图形图像中使用较广泛\nNSMutableData可以修改", "let string = \"你好你好你好\"\nlet data: NSData = string.dataUsingEncoding(NSUTF8StringEncoding)!\nlet newString = String.init(data: data, encoding: NSUTF8StringEncoding)!\nprint(newString)\n\n// 输出：\"你好你好你好\""], ["13", "NSError", "基础框架提供的用于处理异常和错误的类", "func saveContext () {\n\tif managedObjectContext.hasChanges {\n\t\tdo {\n\t\t\ttry managedObjectContext.save()\n\t\t} catch {\n\t\t\tlet nserror = error as NSError\n\t\t\tNSLog(\"Unresolved error \\(nserror), \\(nserror.userInfo)\")\n\t\t\tabort()\n\t\t}\n\t}\n}\n// 与do-catch语句配合使用，当抛出错误，创建NSError对象获取错误信息"], ["13", "NSRange", "用于表示范围的结构体，有两个属性：起始点（location）和长度（length）\nSwift新增Range，和NSRange相识，但不可通用", "let nsString: NSString = \"this is a short text\"\nlet nsRange: NSRange = nsString.rangeOfString(\"short\")\nprint(nsRange)\n// 输出：(10,5)\n\nlet text = \"this is a long text\"\nlet range = text.rangeOfString(\"long\")!\nprint(range)\n// 输出：10..<14"], ["13", "NSObject", "基础类，大部分OC时期开始有的类继承于NSObject", "public class UIResponder : NSObject {\n}\n\npublic class UIView : UIResponder  {\n}\n\npublic class UIViewController : UIResponder  {\n}\n\n// 以上的类都继承于一个基础类NSObject"], ["13", "NSBundle", "用于获取和使用文件路径的类\nNSBundle内含有：info.plist，可执行文件，图像、图标、音频等资源文件", "let mainBundle = NSBundle.mainBundle()\nlet FilePath = mainBundle.pathForResource(\"Personal\", ofType: \"jpg\")\n// 获取Personal.jpg的路径\n\nlet info = mainBundle.infoDictionary\n//获得info.plist配置项词典对象实例\nlet bundleId: AnyObject? = mainBundle.objectForInfoDictionaryKey(\"CFBundleName\")\n// 获得应用程序的Bundle名"], ["13", "NSTimeInterval", "时间间隔，以秒为基本单位，是Double类型数字", "let today = NSDate()\nlet timeInterval: NSTimeInterval = 86400\nlet yesterday = NSDate(timeInterval: -timeInterval, sinceDate: today)\nlet tomorrow = NSDate(timeInterval: timeInterval, sinceDate: today)\n\n// 一天有86400秒，今天减86400秒是昨天，今天加86400秒是明天"], ["13", "NSURL", "资源地址，用于网络链接或者本地资源路径", "let url = NSURL(string: \"http://www.google.com\")!\nUIApplication.sharedApplication().openURL(url)\n// 创建和打开网址\n\nlet urls: [NSURL] = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)\n// 获取本地Document路径"], ["18", "Set", "无序集合类型。Array与之对应，是有序集合类型。\n如果Set里出现了多个相同的值，运行时只保留一个", "var anySet: Set = [1, 2, 3, \"4\", \"5\"]\nvar stringSet: Set<String> = [\"4\", \"5\"]\n\nvar duplicateSet: Set = [1, 1, 3, 3, 5, 5]\nprint(duplicateSet)\n\n// 输出：[3, 1, 5]"], ["18", "String", "字符串类型，字符的序列，同时代表字符（Character）的合集\nSwift之前用的是NSString, 现在也可以用，互相转换很方便", "let text = \"hello world\"\nlet sentence = \"这里是一段文字 123456 +-*/ :)\"\n// String类型的内容必须写在双引号里\n\nprint(String(sentence.characters.last!))\n// 输出：)"], ["21", "Void", "指代空的元组\n常用于返回值为空的函数，可以用()代替，或省略", "func empty(a: Void) -> Void {\n}\n// 一个没有参数，也没返回值的函数，可以简写成：\n\nfunc empty() -> () {\n}\n\nfunc empty() {\n}"], ["20", "UIControl", "UIButton, UISwitch的父类，实现了target-action模式", "let button = UIButton()\nbutton.frame = CGRectMake(0, 0, 100, 100)\nbutton.addTarget(self, action: #selector(buttonTapped), forControlEvents: .TouchUpInside)\n\n// 给button添加目标后，点击按钮，将会触发self里的buttonTapped方法"], ["20", "UIResponder", "视图类（UIView）和视图控制器类（UIViewController）的父类，让其子类可以相应用户触发事件", "public func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)\npublic func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?)\npublic func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?)\npublic func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?)\n\n// 以上都是UIResponder中的方法，当用户的手指接触屏幕、滑动手指、离开屏幕时这些方法会被调用"], ["20", "UIWindow", "管理屏幕显示内容的UIView子类，一个app默认一个window", "func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {\n\twindow = UIWindow(frame: UIScreen.mainScreen().bounds)\n\twindow?.backgroundColor = UIColor.blackColor()\n\n\tlet VC = viewController()\n\twindow?.rootViewController = UINavigationController(rootViewController: VC)\n\twindow?.makeKeyAndVisible()\n\n\treturn true\n}\n// 当不用storyboard时，就要给AppDelegate里的window赋值，设置其rootViewController"], ["20", "UIScreen", "提供手机屏幕硬件方面信息的类，如分辨率、亮度", "print(UIScreen.mainScreen().bounds.size)\n// 输出：(320.0, 480.0) —— iPhone 4/4s\n// 输出：(320.0, 568.0) —— iPhone 5/5s\n// 输出：(375.0, 667.0) —— iPhone 6/6s\n// 输出：(414.0, 736.0) —— iPhone 6 plus/6s plus\n// 输出：(768.0, 1024.0) —— iPad"], ["20", "UIColor", "UIKit中颜色管理类\n注意iOS设备使用的是sRGB显示颜色", "let red = UIColor.redColor() // 获取红色\nview.backgroundColor = UIColor.blueColor() // 设置view的背景颜色为蓝色\n\nextension UIColor {\n\n\tclass func backgroundBlack() -> UIColor {\n\t\treturn UIColor(red: 40/255, green: 42/255, blue: 55/255, alpha: 1.0)\n\t}\n\n}\nview.backgroundColor = UIColor.backgroundBlack()\n// 创建和使用自定义颜色"], ["20", "UIEvent", "UIKit中用来响应事件的类。\niOS中有大体上有三类事件：屏幕感应事件、传感器感应事件、遥控事件（如耳机）", "public enum UIEventType : Int {\n\tcase Touches\n\tcase Motion\n\tcase RemoteControl\n\t@available(iOS 9.0, *)\n\tcase Presses\n}\n// 系统提供的UIEvent类型\n\noverride func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {\n\tprint(event?.type)\n}\n// 通常在UIView中实现这个方法后，当点击屏幕就会打印出event的类型"], ["20", "UIBezierPath", "贝塞尔曲线，用来划线和自定义形状", "import UIKit\n\nclass BezierView: UIView {\n\toverride func drawRect(rect: CGRect) {\n\t\tsuper.drawRect(rect);\n\t\tvar myBezier = UIBezierPath()\n\t\tmyBezier.moveToPoint(CGPoint(x: 100, y: 100))\n\t\tmyBezier.addLineToPoint(CGPoint(x: 200, y: 100))\n\t\tUIColor.orangeColor().setStroke()\n\t\tmyBezier.stroke()\n\t}\n}\n// 画一条线"], ["20", "UIFont", "UIKit中字体管理类", "let label = UILabel()\nlabel.font = UIFont.systemFontOfSize(20)\n// 设置label的字体为系统自带字体，字号20\n\nextension UIFont {\n\n\tclass func myFont(size: CGFloat) -> UIFont {\n\t\treturn UIFont(name: \"Menlo-Regular\", size: size)!\n\t}\n}\nlabel.font = UIFont.myFont(17)\n// 创建和使用自定义字体，先得把字体文件加入工程"], ["20", "UIView", "UIKit中的基础视图类，大部分显示控件都是它的子类，如UILabel，UITableView, UIWebView\n代表屏幕上一片特定区域，渲染和管理这篇区域上的内容", "let view = UIView() // 创建一个UIView\nview.frame = CGRectMake(0, 0, 300, 500) // 设置位置和大小\nview.backgroundColor = UIColor.grayColor() // 设置背景颜色\nview.alpha = 0.8 // 设置透明度 0 ~ 1\nview.userInteractionEnabled = false // 设置能否与用户交互"], ["20", "UITableView", "UIKit提供的视图类，用于显示按一列数行排放的信息，用户需要上下滑动进行查看\n每一行称作一个cell,是UITableViewCell类", "class tableViewController: UITableViewController {\n\t// UIKit提供UITableView视图控制器，方便开发\n\n\toverride func viewDidLoad() {\n\t\tsuper.viewDidLoad()\n\t\ttableView = UITableView(frame: view.bounds)\n\t\ttableView.dataSource = self\n\t\ttableView.delegate = self\n\t\ttableView.backgroundColor = UIColor.clearColor()\n\t\ttableView.separatorStyle = .None\n\t\t// 常见UITableView设置\n\t}\n}"], ["20", "UIScrollView", "UIKit提供的视图类，用于显示大于屏幕尺寸的内容，允许用户自由滑动查看内容", "let scrollView = UIScrollView(frame: view.bounds)\nscrollView.contentSize = CGSize(width: 1000, height: 1000)\n// 设置contentSize大于frame.size，可以加载更多内容\nscrollView.directionalLockEnabled = true\nscrollView.pagingEnabled = true\nscrollView.scrollsToTop = false\nscrollView.delegate = self\nscrollView.decelerationRate = UIScrollViewDecelerationRateFast\n// 常见scrollVIew设置"], ["20", "UIButton", "UIKit提供的按钮类，用来响应用户的点击、拖拽等操作", "let button = UIButton()\nbutton.addTarget(self, action: #selector(buttonTouched), forControlEvents: .TouchDown)\nbutton.addTarget(self, action: #selector(buttonTouchUpOutside), forControlEvents: .TouchUpOutside)\nbutton.addTarget(self, action: #selector(buttonTapped), forControlEvents: .TouchUpInside)\n// 分别当用户按下按钮、按下移动在按钮外松开手指、在按钮内松开手指时，给按钮添加将要触发的方法\n\nview.addSubview(button)"], ["20", "UILabel", "UIKit提供用来显示只读内容的类，可以显示一行或多行的文字", "let label = UILabel()\nlabel.text = \"你好\\n这是换行后的你好\" // 内容，\\n表示换行\nlabel.numberOfLines = 0 // 当显示多行文字时，需要设置行数，0代表不限行数\nlabel.font = UIFont.systemFontOfSize(20) // 字体\nlabel.textColor = UIColor.blueColor() // 文字颜色\nview.addSubview(label) // 添加进已显示的视图后，才能显示\n\n// label常见设置"], ["20", "UITextField", "UIKit提供用来输入、编辑、显示一行文字内容的类\n常用于用户名、密码输入框等", "class viewController: UIViewController, UITextFieldDelegate {\n\n\toverride func viewDidLoad() {\n\t\tsuper.viewDidLoad()\n\t\tlet textField = UITextField(frame: CGRect(x: 0, y: 0, width: 300, height: 50))\n\t\ttextField.delegate = self // viewController必须实现协议UITextFieldDelegate\n\t\tview.addSubview(textField)\n\t}\n\n\tfunc textFieldDidBeginEditing(textField: UITextField) {\n\t\t// 当textField开始编辑，这个方法将被调用。这只是UITextFieldDelegate中众多方法之一\n\t}\n\n}"], ["20", "UITextView", "UIKit提供用来输入、编辑、显示多行文字内容的类，当内容很多时，用户可以上下滑动查看", "let textView = UITextView()\ntextView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight)\ntextView.contentSize = CGSize(width: ScreenWidth, height: ScreenHeight * 3)\n// 设置textView的位置和大小，以及显示内容区域的大小，ScreenWidth、ScreenHeight是自定义变量\n\ntextView.textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 10, right: 5)\ntextView.text = \"可以是大段大段的内容\"\ntextView.tintColor = UIColor.redColor()\ntextView.font = UIFont.systemFontOfSize(18)\ntextView.editable = false // 设置文字内容能否被编辑\nview.addSubview(textView)"], ["20", "UIWebView", "UIKit提供用于加载和显示网页内容的类", "let webView = UIWebView(frame: view.bounds)\nlet url = NSURL(string: \"http://www.stackoverflow.com\")!\nwebView.loadRequest(NSURLRequest(URL: url))\nview.addSubview(webView)\n\n// 创建一个webView，并让其加载显示stackoverflow.com的内容"], ["20", "UIViewController", "视图控制器，UIKit提供用来管理视图的类，是管理视图同时也是管理App的框架", "class viewController: UIViewController {\n\n\toverride func viewDidLoad() {\n\t\tsuper.viewDidLoad()\n\t\tview.backgroundColor = UIColor.whiteColor()\n\t\t// 对视图和App数据的操作，大多都在viewController的生命周期中进行\n\t}\n\n\tfunc showAnotherViewController() {\n\t\tpresentViewController(viewController(), animated: true, completion: nil)\n\t\t// viewController的呈现方法之一\n\t}\n\n}"], ["20", "UINavigationController", "导航控制器，UIKit提供用来管理视图控制器的类\n可以用来显示标题、放置导航按钮、管理工具栏等", "let viewController = UIViewController()\nlet navigationController = UINavigationController(rootViewController: viewController)\n// 声明一个UINavigationController\n\nnavigationController.pushViewController(viewController, animated: true)\n// 用UINavigationController推出另一个视图控制器\n\nnavigationController.popViewControllerAnimated(true)\n// 用UINavigationController来从一个视图控制器退出"], ["0", "AVFoundation", "系统提供用来管理音视频文件的框架", "import AVFoundation\n\nstruct BackgroundSound {\n\tlet sound: AVAudioPlayer // AVFoundation里用来管理音频文件的类\n\n\tinit() {\n\t\tlet soundPath = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(\"sound\", ofType: \"m4a\")!)\n\t\tsound = try! AVAudioPlayer(contentsOfURL: soundPath)\n\t}\n\n\tfunc playSound(sound: AVAudioPlayer) {\n\t\tsound.stop()\n\t\tsound.currentTime = 0\n\t\tsound.volume = 0.65\n\t\tsound.prepareToPlay()\n\t\tsound.play()\n\t\t// 常用播放选项\n\t}\n}"], ["2", "CoreData", "系统提供的数据持久化存储框架\n它提供了对象-关系映射(ORM)的功能，即能够将对象转化成数据，也能够将保存在数据库中的数据还原成对象。", "import CoreData\n\nlet appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate\nlet managedContext = appDelegate.managedObjectContext\n\nlet fetchRequest = NSFetchRequest(entityName: \"MyStory\")\nfetchRequest.entity = NSEntityDescription.entityForName(\"MyStory\", inManagedObjectContext: managedContext)\n\ndo {\n\tif let result = try managedContext.executeFetchRequest(fetchRequest) as? [AnyObject] {\n\t\t// 在这里可以获取到数据，也可以对数据进行编辑、删除等操作\n\t}\n} catch {\n\tprint(\"can\'t get data\")\n}"], ["2", "Contacts", "系统提供和通讯录进行交互的框架，可以获取联系人的信息，还有地名等信息", "func useAppleMap(lonAndLat: [Double], locationName: String) {\n\tlet coor = CLLocationCoordinate2D(latitude: lonAndLat.0, longitude: lonAndLat.1)\n\tlet placemark = MKPlacemark(coordinate: coor, addressDictionary: [CNPostalAddressStreetKey: locationName])\n\t// Contacts里用来创建地名的key\n\t// iOS 8及之前AddressBook的用法：addressDictionary: [kABPersonAddressStreetKey as String: locationName])\n\tlet toLocation = MKMapItem(placemark: placemark)\n\n\tMKMapItem.openMapsWithItems([toLocation], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])\n}"], ["5", "Foundation", "iOS开发的基础框架", "import Foundation\n\nlet string = \"/var/controller_driver/secret_photo.png\" as NSString\nlet components = string.pathComponents as NSArray\nlet fileName = components.lastObject as NSString\n\n// 复杂底层交互的框架，提供带NS开头的类型，其他框架如UIKit中已包含该框架"], ["12", "MessageUI", "系统提供用来实现发邮件、短信等功能的框架", "import MessageUI\n\nprotocol MailSending {\n\tfunc sendSupportEmail()\n} // 一个实现发邮件功能的协议\n\nextension MailSending where Self: UIViewController {\n\tfunc sendSupportEmail() {\n\t\tlet controller = MFMailComposeViewController()\n\t\tcontroller.mailComposeDelegate = self\n\t\tcontroller.setSubject(\"邮件主题\")\n\t\tcontroller.setMessageBody(\"邮件内容\", isHTML: false)\n\t\tcontroller.setToRecipients([\"pmlcfwcs@foxmail.com\"])\n\t\tpresentViewController(controller, animated: true, completion: nil)\n\t}\n}\n\nextension UIViewController: MFMailComposeViewControllerDelegate {\n\tpublic func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {\n\t\tcontroller.dismissViewControllerAnimated(true, completion: nil)\n\t}\n}"], ["12", "MapKit", "系统提供使用地图功能的框架", "import MapKit\n\nfunc useBaiduMap(userLocation: [Double], toLocation: [Double]) {\n\tlet coor0 = CLLocationCoordinate2D(latitude: userLocation[0], longitude: userLocation[1])\n\tlet coor1 = CLLocationCoordinate2D(latitude: toLocation[0], longitude: toLocation[1])\n\n\tlet string = String(format: \"baidumap://map/direction?origin=%@,%@&destination=%@,%@&mode=driving\", \"\\(coor0.latitude)\", \"\\(coor0.longitude)\", \"\\(coor1.latitude)\", \"\\(coor1.longitude)\")\n\tUIApplication.sharedApplication().openURL(NSURL(string: string)!)\n}\n// 创建坐标，然后跳转百度导航的方法。使用系统系统自带地图，参见Contacts单词的例子"], ["18", "StoreKit", "系统提供的内购功能的框架", "import StoreKit\n\npublic class IAPHelper: NSObject  {\n\tprivate var productsRequest: SKProductsRequest?\n\n\tpublic func purchaseProduct(product: SKProduct) {\n\t\tlet payment = SKPayment(product: product)\n\t\tSKPaymentQueue.defaultQueue().addPayment(payment)\n\t}\n\n\tpublic class func canMakePayments() -> Bool {\n\t\treturn SKPaymentQueue.canMakePayments()\n\t}\n}\n// StoreKit中一些常见类"], ["20", "UIKit", "系统提供的用于用户界面构建的框架\nUI开头的类型都属于该框架，UIKit包含CoreGraphics，使用CG开头的类型，导入UIKit就可以", "import UIKit\n\nclass viewController: UIViewController {\n\n\toverride func viewDidLoad() {\n\t\tsuper.viewDidLoad()\n\t\tview = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 667))\n\t\tview.backgroundColor = UIColor.blackColor()\n\t}\n\n}\n// UIKit的常见使用场景"], ["0", "alpha", "视图的透明属性，值在0~1之间的CGFloat类型数字", "let view = UIView()\nview.backgroundColor = UIColor.redColor()\nview.alpha = 1.0 // 不透明\nview.alpha = 0.5 // 半透明\nview.alpha = 0.0 // 透明"], ["1", "bounds", "视图在自身坐标系中的位置和大小，该视图bounds的坐标通常为(0, 0)\n通过修改view的bounds属性可以修改本地坐标系统的原点位置，影响到的是它子view的位置和大小", "let view1 = UIView(frame: CGRectMake(20, 20, 280, 250))\nview1.bounds = CGRectMake(-20, -20, 280, 250)\n\nlet view2 = UIView(frame: CGRectMake(10, 10, 100, 100)) // frame是在父坐标系的坐标和大小\nview1.addSubview(view2)\n\nprint(view1.bounds) // 输出：(-20.0, -20.0, 280.0, 250.0)\nprint(view2.bounds) // 输出：(0.0, 0.0, 100.0, 100.0)\n// 每个view的默认bounds都为(0, 0)"], ["2", "CG", "CoreGraphics的缩写，为系统提供的矢量绘制框架，UIKit包含这个框架", "var rect = CGRect(x: 20, y: 20, width: 300, height: 300)\nrect.origin = CGPoint(x: 30, y: 30)\nrect.size = CGSize(width: 500, height: 500)\n\n// CG开头的类或结构体等，属于CoreGraphics框架"], ["2", "CA", "CoreAnimation的缩写。\n一个合成引擎，工作是尽可能快的将不同的可视化的内容合成到屏幕上。这个可视化内容是不同的层（layer），构成一个叫做层树（layer tree）的层次结构。", "extension UIView {\n\n\tfunc addShadow() {\n\t\tself.layer.shadowRadius = 3\n\t\tself.layer.shadowOpacity = 0.3\n\t\tself.layer.shadowColor = UIColor.lightGrayColor().CGColor\n\t\tself.layer.shadowOffset = CGSizeMake(0, 0)\n\t}\n\t// UIView的属性layer是CALayer类，常见作用是加阴影、加圆角等\n}"], ["5", "frame", "视图的属性之一，代表视图在父视图坐标系中的位置和大小", "let view1 = UIView(frame: CGRectMake(20, 20, 280, 250))\n\nlet view2 = UIView(frame: CGRectMake(10, 10, 100, 100)) // frame是在父坐标系的坐标和大小\nview1.addSubview(view2)\n\nprint(view1.frame) // 输出：(20, 20, 280, 250)\nprint(view2.frame) // 输出：(10, 10, 100, 100)\n// 假设view1的左上角离屏幕边缘的距离是20，那么view2离屏幕边缘的距离为30"], ["13", "NS", "NeXTSTEP的缩写，为乔布斯创立的公司的产品，该公司后被苹果收购\n在OC中为了不和其他已有类型冲突，很多类型加上NS前缀加以区分", "class Object: NSObject {\n\tlet number: NSNumber = 123\n\tlet text: NSString = \"hello\"\n\tlet array: NSArray = [1, 2, 3]\n}\n\n// 常见的有NS前缀的类型"], ["13", "navigationBar", "导航栏，特指iOS应用里高为64（加上状态栏）的导航栏\n是UINavigationController的一个属性", "let rootViewController = UIViewController()\nlet navi = UINavigationController(rootViewController: rootViewController)\nnavi.navigationBar.barStyle = .BlackTranslucent\nnavi.navigationBar.tintColor = UIColor.whiteColor()\nnavi.navigationBar.translucent = true\n\n// navigationBar的常见设置"], ["18", "statusBar", "状态栏，指屏幕顶部用于显示运营商、时间、电池等信息的状态栏，高度为20", "override func prefersStatusBarHidden() -> Bool {\n\treturn false\n}\n// 决定状态栏隐藏还是显示\n\noverride func preferredStatusBarStyle() -> UIStatusBarStyle {\n\treturn .Default\n}\n// 状态栏背景默认透明，文字颜色只有白色和黑色（默认）"], ["19", "tintColor", "视图的颜色属性，可以理解为主题色", "import UIKit\n\nclass NavigationController: UINavigationController {\n\n\toverride func viewDidLoad() {\n\t\tsuper.viewDidLoad()\n\t\tnavigationBar.barTintColor = UIColor.backgroundBlack()\n\t\tnavigationBar.tintColor = UIColor.whiteColor()\n\t}\n\n}\n\n// barTintColor通常指背景颜色\n// navigationBar的tintColor决定的是标题文字的颜色和导航按钮的颜色"], ["19", "toolbar", "工具栏，UINavigationController的属性之一，指屏幕底端高44显示操作按钮的工具栏", "override func viewWillAppear(animated: Bool) {\n\tsuper.viewWillAppear(animated)\n\tlet space = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)\n\tsetToolbarItems([space, space, space], animated: true)\n\n\tnavigationController?.toolbar.tintColor = UIColor.plainWhite()\n\tnavigationController?.setToolbarHidden(false, animated: true)\n}\n\n// 常见的toolBar设置"], ["20", "UI", "User Interface的缩写，交互界面的意思，常用作为类型的前缀", "import UIKit\n\nclass viewController: UIViewController {\n\n\toverride func viewDidLoad() {\n\t\tsuper.viewDidLoad()\n\t\tview = UIView()\n\t\tlet tableView = UITableView()\n\t\tlet scrollView = UIScrollView()\n\t\tlet webView = UIWebView()\n\t}\n\n}\n\n// UI前缀的类型非常常见"]]
}