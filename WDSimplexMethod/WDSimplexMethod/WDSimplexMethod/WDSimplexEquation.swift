//
//  Equation.swift
//  OperationalResearch
//
//  Created by Vladimir Dinic on 5/7/17.
//  Copyright © 2017 Vladimir Dinic. All rights reserved.
//

import UIKit

enum EquationType {
    case GreaterOrEqual
    case Equal
    case LessOrEqual
}

struct WDSimplexEquation {
    var equationNumbers = [WDSimplexValue]()
    var helpEquationNumbers = [WDSimplexValue]()
    var equationSolution:WDSimplexValue?
    var equationType:EquationType?
    
    init(equationNumbers:[Double], equationSolution:Double? = nil, equationType:EquationType? = nil)
    {
        self.equationType = equationType
        for singleNumber in equationNumbers
        {
            self.equationNumbers.append(WDSimplexValue(realValue: singleNumber))
        }
        self.equationSolution = WDSimplexValue(realValue: equationSolution ?? 0)
    }
}
