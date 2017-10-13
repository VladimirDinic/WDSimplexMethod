//
//  SimplexSolution.swift
//  OperationalResearch
//
//  Created by Vladimir Dinic on 5/7/17.
//  Copyright © 2017 Vladimir Dinic. All rights reserved.
//

import UIKit

struct WDSimplexSolution {
    var equationTarget:EquationTarget
    var zcVector:WDSimplexVector
    var optimumSolution:WDSimplexValue
    var xVectorIndexes:[Int]
    var bVectorIndexes:[Int]
    var x0Vector:WDSimplexVector
    var xMatrix:WDSimplexMatrix
    var inVectorIndex = 0
    var outVectorIndex = 0
    var solutionFound = false
    
    init(equationTarget:EquationTarget, zcVector:WDSimplexVector, bVectorIndexes:[Int], xMatrix:WDSimplexMatrix, x0Vector:WDSimplexVector, xVectorIndexes:[Int],optimumSolution:WDSimplexValue)
    {
        self.equationTarget = equationTarget
        self.zcVector = zcVector
        self.xVectorIndexes = xVectorIndexes
        self.optimumSolution = optimumSolution
        self.bVectorIndexes = bVectorIndexes
        self.x0Vector = x0Vector
        self.xMatrix = xMatrix
        self.checkIfSolutionIsFound()
        if !solutionFound
        {
            self.calculateInVectorIndex()
            self.calculateOutVectorIndex()
        }
    }
    
    mutating func checkIfSolutionIsFound()
    {
        solutionFound = true
        if equationTarget == .Max
        {
            for singleValue in zcVector.vectorNumbers
            {
                if singleValue.mValue < 0 || (singleValue.mValue == 0 && singleValue.realValue < 0)
                {
                    solutionFound = false
                }
            }
        }
        else
        {
            for singleValue in zcVector.vectorNumbers
            {
                if singleValue.mValue > 0 || (singleValue.mValue == 0 && singleValue.realValue > 0)
                {
                    solutionFound = false
                }
            }
            
        }
    }
    
    mutating func calculateInVectorIndex()
    {
        inVectorIndex = xVectorIndexes[0]
        var inVectorPositionIndex = 0
        if equationTarget == .Max
        {
            for i in 1...zcVector.vectorNumbers.count-1
            {
                let cond1 = zcVector.vectorNumbers[i] < 0
                let number1 = zcVector.vectorNumbers[i].abs()
                let number2 = zcVector.vectorNumbers[inVectorPositionIndex].abs()
                let cond2 = number1 > number2
                let cond3 = zcVector.vectorNumbers[inVectorPositionIndex] > 0
                if cond1 && (cond3 || cond2)
                {
                    inVectorPositionIndex = i
                }
            }
        }
        else
        {
            //FIXME: sredi ovaj deo i proveri
            for i in 1...zcVector.vectorNumbers.count-1
            {
                let cond1 = zcVector.vectorNumbers[i] > 0
                let cond2 = zcVector.vectorNumbers[i].abs() >= zcVector.vectorNumbers[inVectorPositionIndex].abs()
                if cond1 && cond2
                {
                    inVectorPositionIndex = i
                }
            }
        }
        inVectorIndex = xVectorIndexes[inVectorPositionIndex]
    }
    
    mutating func calculateOutVectorIndex()
    {
        outVectorIndex = bVectorIndexes[0]
        var outVectorPositionIndex = 0
        for i in 1...bVectorIndexes.count-1
        {
            let x0i = x0Vector.vectorNumbers[i].realValue
            let xi = xMatrix.vectors[inVectorIndex-1].vectorNumbers[i].realValue   
            let bestx0i = x0Vector.vectorNumbers[outVectorPositionIndex].realValue
            let bestxi = xMatrix.vectors[inVectorIndex-1].vectorNumbers[outVectorPositionIndex].realValue
            if xi > 0 && x0i/xi < bestx0i/bestxi
            {
                outVectorPositionIndex = i
                outVectorIndex = bVectorIndexes[i]
            }
        }
    }
}
