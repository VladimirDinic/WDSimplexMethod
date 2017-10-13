//
//  WDSimplexVector.swift
//  OperationalResearch
//
//  Created by Vladimir Dinic on 5/7/17.
//  Copyright © 2017 Vladimir Dinic. All rights reserved.
//

import UIKit

struct WDSimplexVector {
    var vectorNumbers = [WDSimplexValue]()
    
    init() {
        
    }
    
    init(vectorNumbers:[WDSimplexValue])
    {
        self.vectorNumbers = vectorNumbers
    }
    
    init(numberOfElements:Int, position:Int)
    {
        self.vectorNumbers = []
        for i in 0...numberOfElements-1
        {
            if i == position
            {
                self.vectorNumbers.append(WDSimplexValue(realValue: 1))
            }
            else
            {
                self.vectorNumbers.append(WDSimplexValue(realValue: 0))
            }
        }
    }
    
    init(vectorNumbers:[Double])
    {
        for singleNumber in vectorNumbers
        {
            self.vectorNumbers.append(WDSimplexValue(realValue: singleNumber))
        }
    }
    
    init(vectorNumbers:[Int])
    {
        for singleNumber in vectorNumbers
        {
            self.vectorNumbers.append(WDSimplexValue(realValue: Double(singleNumber)))
        }
    }
    
    static func * ( left: WDSimplexVector, right: WDSimplexVector) -> WDSimplexValue
    {
        if left.vectorNumbers.count == right.vectorNumbers.count
        {
            var product = WDSimplexValue()
            for i in 0...left.vectorNumbers.count-1
            {
                product += left.vectorNumbers[i] * right.vectorNumbers[i]
            }
            return product
        }
        return WDSimplexValue()
    }
}
