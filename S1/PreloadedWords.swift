//
//  PreloadedWords.swift
//  S1
//
//  Created by 文川术 on 5/29/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import Foundation


struct PreloadedWords {

	let arrays = [["2", "create", "why 名字", "ffff."], ["19", "test", "what is\n", "the sthing\n"], ["0", "as", "1. 用于类型判断和转换\n2. as!用于强制转换，as?用于可为空转换", "let text = \"这是一个String类型\"\nlet length = (text as NSString).lengh\n// 把String类型转换成NSString类型，获取其长度\n\nlet sentence = text as! String\n// 强制转换类型，如无法转换，则程序出错\n\nguard let string = text as? String else { return }\n// 对text进行可选转换，如无法转换，则跳过"], ["1", "be", "ghhg\n", ""], ["2", "continue", "1. 用在循环结构中，结束本次循环，忽略continue后的代码，开始下一次循环", "let numbers = [1, 2, 3]\nfor number in numbers {\n    if number == 2 {\n        continue\n    }\n    print(number)\n}\n\n// 输出1和3，不会输出2"], ["3", "deinit", "1. 析构方法，用于销毁对象、释放内存", "class Observer {\n\n    init() {\n        NSNotificationCenter.defaultCenter().addObserver(self, selector: nil, name: nil, object: nil)\n    }\n\n    deinit {\n        NSNotificationCenter.defaultCenter().removeObserver(self)\n    }\n\n}\n\n// 对象被销毁前，需要的操作在deinit {} 中执行"], ["19", "time", "what happen", "this is good \nfunc happy life\nswitch self {\ncase 1:\n  break\ncase 2:\n  break\ndefault:\n  break\n}"], ["1", "base", "find something great", "life is good"], ["2", "come", "tryr", "what is that"], ["13", "nice", "edited", "what about this default"], ["11", "Life is go", "time gies by", "vc"], ["8", "is", "1. 类型判断关键词", "let VC = UIViewController()\nswitch VC {\ncase is UITableViewController:\n    break\ncase is UINavigationController()\n    break\ndefault: \n    break\n}"], ["22", "what to say now", "time goes by", "very go dont you think?\nthat is what i am talking about haha nice day nice try"], ["19", "tljila", "痛苦啦啦啦\n", "tokuwojutla\nwook"], ["1", "break", "1. 在循环语句中，终止并跳出循环\n2. 终止switch语句的情况（case）", "let numbers = [1, 2, 3]\nfor number in numbers {\n    if number == 2 {\n        break // 当循环到2就终止循环\n    }\n}\n\nswitch numbers[0] {\ncase 1:\n    break // 当numbers第0个数为1时，终止switch\ndefault:\n    print(\"不是1的情况\")\n}"], ["2", "class", "1. 定义和声明一个类\n2. 定义类方法：不依赖于具体对象的方法", "// 1\nclass ColorOfNature {\n    // 2\n    class func skyBlue() -> UIColor() {\n        return UIColor.blueColor()\n    }\n\n}\n// 3\nlet skyColor = ColorOfNature.skyBlue()\n\n// 1. 定义一个名为ColorOfNature的类\n// 2. 定义一个名为skyBlue的类方法\n// 3. 使用类名+点语法调用类方法，不需要创建对象"], ["2", "case", "1. switch-case语句的组成部分，表明一种情况", "let age = random % 101 // age为0~100之间的随机数\nswitch age {\ncase 0..<18:\n    print(\"未成年人\")\ncase 18...100:\n    print(\"成年人\")\ndefault:\n    break\n}"]]
}