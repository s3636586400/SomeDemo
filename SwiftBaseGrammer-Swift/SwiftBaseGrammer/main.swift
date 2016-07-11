//
//  main.swift
//  SwiftBaseGrammer
//
//  Created by 解炳灿 on 16/4/22.
//  Copyright © 2016年 解炳灿. All rights reserved.
//

import Foundation


#if false
//变量定义 var定义变量，let定义常量
var a:Int = 1

var b = 2

var c:UInt = 3

let d = a + b

print("d = \(d)")

let e = Int.max

var f:Float = 1.0

//if语句条件只能是布尔类型，不能像objc非0即真
var j:Bool = true

//不指定类型"c"默认推断为字符串（但是为什么char不直接用单引号呢）
var k:Character = "c"

//前缀的0以及下划线不影响常量的值
var l = 00100

var m = 10_000_000

print("l=\(l) m =\(m)")

#endif


#if false
//集合类型-Array

var a:[String] = ["hello","world"]
//省略了一个Array，上语句等价于
//var a:Array<String> = ["hello","world"]

//访问元素
var str:String = a[0]

//创建空数组
var b:[Double] = []
//简写为:
//var b = [Double]()

for i in a {
    print("i=\(i)")
}

//注：Swift中可变类型不再由单独类型表示（NSMutableArray)统一使用Array，若想声明为不可变，使用let

//添加一个元素
a.append("!")
//添加多个元素
a += ["Swift","look","strange"]

//修改元素，不能使用这种方式添加元素
a[3...5] = ["just","for","test"]
//a[6] = ["."]//错误方式

//插入元素
a.insert("HaHa", atIndex: 5)

//删除指定元素
a.removeAtIndex(5);

//enumerate遍历
for (n, c) in a.enumerate() {
    print("\(n): '\(c)'")
}
#endif


#if false
//集合类型-Set
var a:Set<String> = ["hello","world"]
var b:Set = [1,2]//推断类型为Int
//Set没有简化形式,简化了判定不了是Set还是Array

//插入元素
a.insert("!")

//非空移除"!"
if !a.isEmpty {
    a.remove("!")
}

//不存在"!"则插入"!"
if !a.contains("!") {
    a.insert("!")
}
#endif


#if false
//集合类型-Dictionary

//注：Swift中基本类型是可以哈希的，可以作为Key

var a:[Int:String] = [200:"succes",404:"not found"]
//等价于
//var a:Dictionary<Int,String> = [200:"succes",404:"not found"]

//var str:String =  a[200]//读取
//Value of optional type 'String?' not unwrapped;did you mean to use '!' or '?'?

a[400] = "can not read"//修改

a[500] = "internal server error"//添加

//a = [:]//设置为空字典 推断为a = [Int:String]()

for key in a.keys {
    print("key=\(key)")
}

for value in a.values {
    print("values=\(value)")
}

#endif

//元组
