//
//  WDSimplexValue.swift
//  OperationalResearch
//
//  Created by Vladimir Dinic on 5/14/17.
//  Copyright © 2017 Vladimir Dinic. All rights reserved.
//

import UIKit

struct WDSimplexValue: Equatable {
    var realValue:Double = 0.0
    var mValue:Double = 0.0
    
    init()
    {
        realValue = 0.0
        mValue = 0.0
    }
    
    init(realValue:Double)
    {
        self.realValue = realValue
        self.mValue = 0.0
    }
    
    init(mValue:Double)
    {
        self.realValue = 0.0
        self.mValue = mValue
    }
    
    init(realValue:Double, mValue:Double)
    {
        self.realValue = realValue
        self.mValue = mValue
    }
    
    func abs() -> WDSimplexValue
    {
        return WDSimplexValue(realValue: mValue == 0 ? Swift.abs(realValue) : realValue, mValue: Swift.abs(mValue))
    }
    
    static func +(left: WDSimplexValue, right: WDSimplexValue) -> WDSimplexValue
    {
        var sum = WDSimplexValue()
        sum.realValue = left.realValue + right.realValue
        sum.mValue = left.mValue + right.mValue
        return sum
    }
    
    static func -(left: WDSimplexValue, right: WDSimplexValue) -> WDSimplexValue
    {
        var difference = WDSimplexValue()
        difference.realValue = left.realValue - right.realValue
        difference.mValue = left.mValue - right.mValue
        return difference
    }
    
    static func *(left: WDSimplexValue, right: WDSimplexValue) -> WDSimplexValue
    {
        var product = WDSimplexValue()
        product.realValue = left.realValue * right.realValue
        product.mValue = left.mValue * right.realValue + left.realValue * right.mValue
        return product
    }
    
    static func *(left: Double, right: WDSimplexValue) -> WDSimplexValue
    {
        var product = WDSimplexValue()
        product.realValue = left * right.realValue
        product.mValue = left * right.mValue
        return product
    }
    
    static func /(left: WDSimplexValue, right: Double) -> WDSimplexValue
    {
        var division = WDSimplexValue()
        division.realValue = left.realValue / right
        division.mValue = left.mValue / right
        return division
    }
    
    static func /= ( left: inout WDSimplexValue, right: Double)
    {
        left.realValue = left.realValue / right
        left.mValue = left.mValue / right
    }
    
    static func += ( left: inout WDSimplexValue, right: WDSimplexValue)
    {
        left.realValue = left.realValue + right.realValue
        left.mValue = left.mValue + right.mValue
    }
    
    static func == ( left: WDSimplexValue, right: WDSimplexValue) -> Bool
    {
        return left.realValue == right.realValue && left.mValue == right.mValue
    }
    
    static func > ( left: WDSimplexValue, right: WDSimplexValue) -> Bool
    {
        return left.mValue > right.mValue || (left.mValue == right.mValue && left.realValue > right.realValue)
    }
    
    static func < ( left: WDSimplexValue, right: WDSimplexValue) -> Bool
    {
        return left.mValue < right.mValue || (left.mValue == right.mValue && left.realValue < right.realValue)
    }
    
    static func >= ( left: WDSimplexValue, right: WDSimplexValue) -> Bool
    {
        return (left.mValue >= right.mValue) || (left.realValue == right.realValue && left.mValue >= right.mValue) || (left.mValue == right.mValue && left.realValue >= right.realValue)
    }
    
    static func <= ( left: WDSimplexValue, right: WDSimplexValue) -> Bool
    {
        return (left.mValue <= right.mValue) || (left.realValue == right.realValue && left.mValue <= right.mValue) || (left.mValue == right.mValue && left.realValue <= right.realValue)
    }
    
    static func > ( left: WDSimplexValue, right: Double) -> Bool
    {
        return left.mValue > 0 || (left.mValue == 0 && left.realValue > right)
    }
    
    static func < ( left: WDSimplexValue, right: Double) -> Bool
    {
        return left.mValue < 0 || (left.mValue == 0 && left.realValue < right)
    }
    
    
}

/*extension Array where Element:Equatable
{
    func test()
    {
        print("test")
    }
}*/

