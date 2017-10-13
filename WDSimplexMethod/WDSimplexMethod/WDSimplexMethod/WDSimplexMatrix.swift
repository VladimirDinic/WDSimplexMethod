//
//  SimplexMatrix.swift
//  OperationalResearch
//
//  Created by Vladimir Dinic on 5/9/17.
//  Copyright © 2017 Vladimir Dinic. All rights reserved.
//

import UIKit

struct WDSimplexMatrix {
    var vectors = [WDSimplexVector]()
    
    func transposeMatrix() -> WDSimplexMatrix
    {
        var transposedMatrix = WDSimplexMatrix()
        for i in 0...self.vectors.count-1
        {
            var singleVector = WDSimplexVector()
            for j in 0...self.vectors.count-1
            {
                singleVector.vectorNumbers.append(self.vectors[j].vectorNumbers[i])
            }
            transposedMatrix.vectors.append(singleVector)
        }
        return transposedMatrix
    }
    
    func inverseMatrix() -> WDSimplexMatrix
    {
        let determinant = self.calculateDeterminant()
        var inverseMatrix = self.calculateAdjointMatrix()
        for i in 0...inverseMatrix.vectors.count-1
        {
            for j in 0...inverseMatrix.vectors[i].vectorNumbers.count-1
            {
                inverseMatrix.vectors[i].vectorNumbers[j] /= determinant
            }
        }
        return inverseMatrix
    }
    
    func calculateDeterminant() -> Double
    {
        let matrixSize = self.vectors.count
        if matrixSize == 0
        {
            return 0
        }
        else if matrixSize == 1
        {
            return self.vectors[0].vectorNumbers[0].realValue
        }
        else if matrixSize == 2
        {
            return (self.vectors[0].vectorNumbers[0] * self.vectors[1].vectorNumbers[1] - self.vectors[0].vectorNumbers[1] * self.vectors[1].vectorNumbers[0]).realValue
        }
        else
        {
            var determinant = 0.0
            for i in 0...matrixSize - 1
            {
                var subMatrix = self
                let firstVector = subMatrix.vectors.remove(at: 0)
                
                for j in 0...matrixSize - 2
                {
                    subMatrix.vectors[j].vectorNumbers.remove(at: i)
                }
                determinant += ((2+i) % 2 == 0 ? 1.0 : -1.0) * firstVector.vectorNumbers[i].realValue * subMatrix.calculateDeterminant()
            }
            return determinant
        }
    }
    
    func calculateAdjointMatrix() -> WDSimplexMatrix
    {
        var adjointMatrix = self
        
        for i in 0...vectors.count-1
        {
            for j in 0...vectors.count-1
            {
                var subMatrix = self
                subMatrix.vectors.remove(at: i)
                for k in 0...subMatrix.vectors.count-1
                {
                    subMatrix.vectors[k].vectorNumbers.remove(at: j)
                }
                let subMatrixDeterminant = subMatrix.calculateDeterminant()
                adjointMatrix.vectors[j].vectorNumbers[i] = WDSimplexValue(realValue: ((2+i+j) % 2 == 0 ? 1 : -1) * subMatrixDeterminant, mValue: 0)
            }
        }
        return adjointMatrix
    }
    
    static func *(left: WDSimplexMatrix, right: WDSimplexVector) -> WDSimplexVector
    {
        var product = WDSimplexVector()
        for i in 0...left.vectors.count-1
        {
            var x0value = WDSimplexValue()
            for j in 0...left.vectors[i].vectorNumbers.count-1
            {
                x0value += left.vectors[i].vectorNumbers[j] * right.vectorNumbers[j]
            }
            product.vectorNumbers.append(x0value)
        }
        return product
    }
}
