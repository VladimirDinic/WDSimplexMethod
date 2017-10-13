//
//  SimplexMethod.swift
//  OperationalResearch
//
//  Created by Vladimir Dinic on 5/7/17.
//  Copyright © 2017 Vladimir Dinic. All rights reserved.
//

import UIKit

enum EquationTarget {
    case Min
    case Max
}

class WDSimplexMethod: NSObject {
    
    private var iteration = 0
    private var z0 = WDSimplexValue()
    
    var equationTarget:EquationTarget
    var numberOfCorrections = 0
    var mainEquation:WDSimplexEquation
    var constraintEquations:[WDSimplexEquation]
    var xMatrix = WDSimplexMatrix()
    var zcValues = [WDSimplexValue]()
    
    //FIXME: set private where nedded
    
    var bVectorSpaceBaseIndex = [Int]()
    var xVectorSpaceBaseIndex = [Int]()
    var x0Vector = WDSimplexVector()
    var cVector:WDSimplexVector? = nil
    var c0Vector = WDSimplexVector()
    var a0Vector:WDSimplexVector? = nil
    var aVectors = [WDSimplexVector]()
    var bMatrix = WDSimplexMatrix()
    var solution:WDSimplexSolution? = nil
    var extendedSystemOfEquationsSize = 0
    var systemOfEquationsSize = 0
    ////until here
    
    init(mainEquation:WDSimplexEquation, constraintEquations:[WDSimplexEquation], equationTarget:EquationTarget) {
        self.mainEquation = mainEquation
        self.constraintEquations = constraintEquations
        self.equationTarget = equationTarget
    }
    
    func nextIteration()
    {
        iteration += 1
        if iteration == 1
        {
            generateBMatrix()
            bVectorSpaceBaseIndex.removeAll()
            for i in 0...self.constraintEquations.count-1
            {
                bVectorSpaceBaseIndex.append(self.extendedSystemOfEquationsSize-self.constraintEquations.count+i+1)
            }
            if let cVector = self.cVector
            {
                c0Vector = WDSimplexVector()
                for singleIndex in bVectorSpaceBaseIndex
                {
                    c0Vector.vectorNumbers.append(cVector.vectorNumbers[singleIndex-1])
                }
            }
            let bInverse = self.bMatrix.transposeMatrix().inverseMatrix()
            if let a0Vector = a0Vector
            {
                x0Vector = bInverse * a0Vector
            }
            for i in 0...aVectors.count-1
            {
                if !bVectorSpaceBaseIndex.contains(i+1)
                {
                    xMatrix.vectors.append(bInverse.transposeMatrix() * aVectors[i])
                    xVectorSpaceBaseIndex.append(i+1)
                }
            }
        }
        else
        {
            //stalno se vrti u krug index kojisledeci ulazi u resenje
            for i in 0...bVectorSpaceBaseIndex.count-1
            {
                if self.bVectorSpaceBaseIndex[i] == solution!.outVectorIndex
                {
                    self.bVectorSpaceBaseIndex[i] = solution!.inVectorIndex
                }
            }
            generateBMatrix()
            for i in 0...xVectorSpaceBaseIndex.count-1
            {
                if self.xVectorSpaceBaseIndex[i] == solution!.inVectorIndex
                {
                    self.xVectorSpaceBaseIndex[i] = solution!.outVectorIndex
                }
            }
            let bInverse = self.bMatrix.transposeMatrix().inverseMatrix()
            if let a0Vector = a0Vector
            {
                x0Vector = bInverse * a0Vector
            }
            xMatrix.vectors.removeAll()
            for singleIndex in xVectorSpaceBaseIndex
            {
                xMatrix.vectors.append(bInverse * aVectors[singleIndex-1])
            }
            if let cVector = self.cVector
            {
                c0Vector = WDSimplexVector()
                for singleIndex in bVectorSpaceBaseIndex
                {
                    c0Vector.vectorNumbers.append(cVector.vectorNumbers[singleIndex-1])
                }
            }
        }
        
        z0 = WDSimplexValue()
        for i in 0...c0Vector.vectorNumbers.count-1
        {
            z0 += c0Vector.vectorNumbers[i] * x0Vector.vectorNumbers[i]
        }
        
        zcValues.removeAll()
        for xIndex in xVectorSpaceBaseIndex
        {
            let index = xVectorSpaceBaseIndex.index(of: xIndex)!
            zcValues.append(c0Vector * xMatrix.vectors[index] - (cVector?.vectorNumbers[xIndex-1])!)
        }
        
        self.solution = WDSimplexSolution(equationTarget: equationTarget, zcVector: WDSimplexVector(vectorNumbers: zcValues), bVectorIndexes: bVectorSpaceBaseIndex, xMatrix: xMatrix, x0Vector: x0Vector, xVectorIndexes: xVectorSpaceBaseIndex, optimumSolution: z0)
    }
    
    func generateVectors()
    {
        calculateSystemOfEquationsSize()
        calculateExtendedSystemOfEquationsSize()
        generateCVector()
        generateAVectors()
        generateA0Vector()
    }
    
    func generateBMatrix()
    {
        if iteration <= 1
        {
            for i in self.extendedSystemOfEquationsSize-self.constraintEquations.count...self.extendedSystemOfEquationsSize-1
            {
                self.bMatrix.vectors.append(self.aVectors[i])
            }
        }
        else
        {
            self.bMatrix.vectors.removeAll()
            for singleBaseIndex in self.bVectorSpaceBaseIndex
            {
                self.bMatrix.vectors.append(self.aVectors[singleBaseIndex-1])
            }
        }
    }
    
    func calculateSystemOfEquationsSize()
    {
        for i in 0...self.constraintEquations.count-1
        {
            if self.constraintEquations[i].equationNumbers.count > systemOfEquationsSize
            {
                systemOfEquationsSize = self.constraintEquations[i].equationNumbers.count
            }
        }
    }
    
    func calculateExtendedSystemOfEquationsSize()
    {
        extendedSystemOfEquationsSize = systemOfEquationsSize + self.constraintEquations.count
        for singleEquation in self.constraintEquations
        {
            if singleEquation.equationType == .GreaterOrEqual
            {
                numberOfCorrections += 1
                extendedSystemOfEquationsSize += 1
            }
        }
    }
    
    func generateCVector()
    {
        self.cVector = WDSimplexVector(vectorNumbers: self.mainEquation.equationNumbers)
        if (self.cVector != nil)
        {
            if self.numberOfCorrections > 0
            {
                for _ in 1...self.numberOfCorrections
                {
                    self.cVector?.vectorNumbers.append(WDSimplexValue())
                }
            }
            for _ in self.systemOfEquationsSize...self.extendedSystemOfEquationsSize-1-self.numberOfCorrections
            {
                self.cVector?.vectorNumbers.append(WDSimplexValue())
            }
            for i in self.systemOfEquationsSize+numberOfCorrections...self.extendedSystemOfEquationsSize-1
            {
                let singleEquation = self.constraintEquations[i-(self.systemOfEquationsSize+numberOfCorrections)]
                if singleEquation.equationType != .LessOrEqual
                {
                    self.cVector?.vectorNumbers[i] = self.equationTarget == .Max ? WDSimplexValue(mValue: -1) : WDSimplexValue(mValue: 1)
                }
            }
        }
    }
    
    func generateA0Vector()
    {
        self.a0Vector = WDSimplexVector()
        for singleEquation in self.constraintEquations
        {
            if let equationSolution = singleEquation.equationSolution
            {
                self.a0Vector?.vectorNumbers.append(equationSolution)
            }
        }
    }
    
    func generateAVectors()
    {
        
        for _ in 1...systemOfEquationsSize {
            self.aVectors.append(WDSimplexVector())
        }
        for i in 0...self.constraintEquations.count-1
        {
            for j in 0...self.aVectors.count-1
            {
                self.aVectors[j].vectorNumbers.append(self.constraintEquations[i].equationNumbers[j])
            }
        }
        for i in 0...self.constraintEquations.count-1
        {
            var vectorNumbers = [WDSimplexValue]()
            for _ in 0...self.constraintEquations.count-1
            {
                vectorNumbers.append(WDSimplexValue())
            }
            let singleEquation = self.constraintEquations[i]
            if singleEquation.equationType == .GreaterOrEqual
            {
                vectorNumbers[i] = WDSimplexValue(realValue: -1, mValue: 0)
                self.aVectors.append(WDSimplexVector(vectorNumbers: vectorNumbers))
            }
        }
        for i in 0...self.constraintEquations.count-1
        {
            var vectorNumbers = [WDSimplexValue]()
            for _ in 0...self.constraintEquations.count-1
            {
                vectorNumbers.append(WDSimplexValue())
            }
            vectorNumbers[i] = WDSimplexValue(realValue: 1, mValue: 0)
            self.aVectors.append(WDSimplexVector(vectorNumbers: vectorNumbers))
        }
    }
    
    func calculateWhileDontFindOptimum()
    {
        self.nextIteration()
        while let solution = self.solution, !solution.solutionFound
        {
            self.nextIteration()
        }
    }
    
    func calculateOptimum() -> WDSimplexSolution?
    {
        self.generateVectors()
        self.calculateWhileDontFindOptimum()
        return self.solution
    }
    
}
