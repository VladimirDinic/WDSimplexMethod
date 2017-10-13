//
//  WDSimplexMethodTests.swift
//  WDSimplexMethodTests
//
//  Created by Vladimir Dinic on 10/13/17.
//  Copyright © 2017 Vladimir Dinic. All rights reserved.
//

import XCTest
@testable import WDSimplexMethod

class WDSimplexMethodTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testFull()
    {
        func example1()
        {
            let simplex = WDSimplexMethod(mainEquation: WDSimplexEquation(equationNumbers:[9, 24, 12,27]), constraintEquations: [WDSimplexEquation(equationNumbers:[1, 1, 1, 1], equationSolution:210, equationType:.LessOrEqual),WDSimplexEquation(equationNumbers:[2, 1, 2, 1], equationSolution:360, equationType:.GreaterOrEqual),WDSimplexEquation(equationNumbers:[1, 1, -2, -2], equationSolution:0, equationType:.Equal)], equationTarget: .Max)
            XCTAssert(simplex.calculateOptimum()?.optimumSolution.realValue == 3000, "Wrong calculation")
        }
        example1()
        
        func example2()
        {
            let simplex = WDSimplexMethod(mainEquation: WDSimplexEquation(equationNumbers:[8, 12, 8, 6]), constraintEquations: [WDSimplexEquation(equationNumbers:[2, 2, 0, 0], equationSolution:102, equationType:.LessOrEqual),WDSimplexEquation(equationNumbers:[0, 0, 4, 2], equationSolution:240, equationType:.LessOrEqual),WDSimplexEquation(equationNumbers:[3, 4, 4, 2], equationSolution:420, equationType:.Equal)], equationTarget: .Min)
            XCTAssert(simplex.calculateOptimum()?.optimumSolution.realValue == 996, "Wrong calculation")
        }
        example2()
        
        func example3()
        {
            let simplex = WDSimplexMethod(mainEquation: WDSimplexEquation(equationNumbers:[10, 3, 12, 8]), constraintEquations: [WDSimplexEquation(equationNumbers:[1, 0, 2, 1], equationSolution:16, equationType:.GreaterOrEqual),WDSimplexEquation(equationNumbers:[1, 1, 0, -1], equationSolution:4, equationType:.Equal),WDSimplexEquation(equationNumbers:[3, 2, 4, 2], equationSolution:38, equationType:.LessOrEqual)], equationTarget: .Min)
            XCTAssert(simplex.calculateOptimum()?.optimumSolution.realValue == 110, "Wrong calculation")
        }
        example3()
        
        func example4()
        {
            let simplex = WDSimplexMethod(mainEquation: WDSimplexEquation(equationNumbers:[7, 5, 6, 8]), constraintEquations: [WDSimplexEquation(equationNumbers:[1, 1, 1, 1], equationSolution:24, equationType:.Equal),WDSimplexEquation(equationNumbers:[3, 4, 2, 3], equationSolution:50, equationType:.LessOrEqual),WDSimplexEquation(equationNumbers:[1, 2, 2, 2], equationSolution:420, equationType:.GreaterOrEqual)], equationTarget: .Max)
            XCTAssert(simplex.calculateOptimum()?.optimumSolution.realValue == 148, "Wrong calculation")
        }
        example4()
        
        func example5()
        {
            let simplex = WDSimplexMethod(mainEquation: WDSimplexEquation(equationNumbers:[6, 7, 8]), constraintEquations: [WDSimplexEquation(equationNumbers:[1, 2, 1], equationSolution:900, equationType:.LessOrEqual),WDSimplexEquation(equationNumbers:[1, 3, 2], equationSolution:1600, equationType:.LessOrEqual),WDSimplexEquation(equationNumbers:[2, -1, -1], equationSolution:420, equationType:.LessOrEqual)], equationTarget: .Max)
            XCTAssert(simplex.calculateOptimum()?.optimumSolution.realValue == 6800, "Wrong calculation")
        }
        example5()
        
        func example6()
        {
            let simplex = WDSimplexMethod(mainEquation: WDSimplexEquation(equationNumbers:[6, 7, 5, 4]), constraintEquations: [WDSimplexEquation(equationNumbers:[1, 1, 1, 1], equationSolution:22, equationType:.Equal),WDSimplexEquation(equationNumbers:[2, 2, 0, 2], equationSolution:20, equationType:.GreaterOrEqual),WDSimplexEquation(equationNumbers:[3, 2, 1, 1], equationSolution:34, equationType:.LessOrEqual)], equationTarget: .Max)
            XCTAssert(simplex.calculateOptimum()?.optimumSolution.realValue == 134, "Wrong calculation")
        }
        example6()
        
        func example7()
        {
            let simplex = WDSimplexMethod(mainEquation: WDSimplexEquation(equationNumbers:[-4, 3, -4]), constraintEquations: [WDSimplexEquation(equationNumbers:[1, 2, 1], equationSolution:4, equationType:.LessOrEqual),WDSimplexEquation(equationNumbers:[-2, -1, 1], equationSolution:2, equationType:.LessOrEqual)], equationTarget: .Max)
            XCTAssert(simplex.calculateOptimum()?.optimumSolution.realValue == 6, "Wrong calculation")
        }
        example7()
        
        func example8()
        {
            let simplex = WDSimplexMethod(mainEquation: WDSimplexEquation(equationNumbers:[-4, 3, -7, 5]), constraintEquations: [WDSimplexEquation(equationNumbers:[1, 4, 4, -7], equationSolution:4, equationType:.LessOrEqual),WDSimplexEquation(equationNumbers:[-3, -1, 11, 4], equationSolution:25, equationType:.LessOrEqual),WDSimplexEquation(equationNumbers:[1, -4, -1, 4], equationSolution:0, equationType:.GreaterOrEqual),WDSimplexEquation(equationNumbers:[3, -1, 6, 5], equationSolution:20, equationType:.LessOrEqual)], equationTarget: .Max)
            XCTAssert(simplex.calculateOptimum()?.optimumSolution.realValue == 40, "Wrong calculation")
        }
        //FIXME: error
        //example8()
    }
    
    
    func testFirstIteration()
    {
        func example1()
        {
            let simplex = WDSimplexMethod(mainEquation: WDSimplexEquation(equationNumbers:[9, 24, 12,27]), constraintEquations: [WDSimplexEquation(equationNumbers:[1, 1, 1, 1], equationSolution:210, equationType:.LessOrEqual),WDSimplexEquation(equationNumbers:[2, 1, 2, 1], equationSolution:360, equationType:.GreaterOrEqual),WDSimplexEquation(equationNumbers:[1, 1, -2, -2], equationSolution:0, equationType:.Equal)], equationTarget: .Max)
            simplex.generateVectors()
            simplex.nextIteration()
            if let criteriaFunctionValue = simplex.solution
            {
                XCTAssert(criteriaFunctionValue.optimumSolution == WDSimplexValue(mValue: -360), "Wrong z0 value")
                XCTAssert(criteriaFunctionValue.xVectorIndexes == [1,2,3,4,5], "Wrong vector indexes")
                XCTAssert(criteriaFunctionValue.solutionFound == false, "Wrong detection if solution is found")
                XCTAssert(criteriaFunctionValue.inVectorIndex == 1, "Wrong in vector index")
                XCTAssert(criteriaFunctionValue.outVectorIndex == 8, "Wrong out vector index")
                var solutionFound = true
                for singleZCValue in simplex.zcValues
                {
                    solutionFound = solutionFound && (singleZCValue.mValue >= 0 && singleZCValue.realValue >= 0)
                }
                XCTAssert(!solutionFound, "Error during solution found checking")
            }
            else
            {
                XCTAssert(false, "z0 value is nil")
            }
        }
        example1()
        
        func example2()
        {
            let simplex = WDSimplexMethod(mainEquation: WDSimplexEquation(equationNumbers:[8, 12, 8, 6]), constraintEquations: [WDSimplexEquation(equationNumbers:[2, 2, 0, 0], equationSolution:102, equationType:.LessOrEqual),WDSimplexEquation(equationNumbers:[0, 0, 4, 2], equationSolution:240, equationType:.LessOrEqual),WDSimplexEquation(equationNumbers:[3, 4, 4, 2], equationSolution:420, equationType:.Equal)], equationTarget: .Min)
            simplex.generateVectors()
            simplex.nextIteration()
            if let criteriaFunctionValue = simplex.solution
            {
                XCTAssert(criteriaFunctionValue.optimumSolution == WDSimplexValue(mValue: 420), "Wrong z0 value")
                XCTAssert(criteriaFunctionValue.xVectorIndexes == [1,2,3,4], "Wrong vector indexes")
                XCTAssert(criteriaFunctionValue.solutionFound == false, "Wrong detection if solution is found")
                XCTAssert(criteriaFunctionValue.inVectorIndex == 3, "Wrong in vector index")
                XCTAssert(criteriaFunctionValue.outVectorIndex == 6, "Wrong out vector index")
                var solutionFound = true
                for singleZCValue in simplex.zcValues
                {
                    solutionFound = solutionFound && (singleZCValue.mValue >= 0 && singleZCValue.realValue >= 0)
                }
                XCTAssert(!solutionFound, "Error during solution found checking")
            }
            else
            {
                XCTAssert(false, "z0 value is nil")
            }
        }
        example2()
        
        func example3()
        {
            let simplex = WDSimplexMethod(mainEquation: WDSimplexEquation(equationNumbers:[10, 3, 12, 8]), constraintEquations: [WDSimplexEquation(equationNumbers:[1, 0, 2, 1], equationSolution:16, equationType:.GreaterOrEqual),WDSimplexEquation(equationNumbers:[1, 1, 0, -1], equationSolution:4, equationType:.Equal),WDSimplexEquation(equationNumbers:[3, 2, 4, 2], equationSolution:38, equationType:.LessOrEqual)], equationTarget: .Min)
            simplex.generateVectors()
            simplex.nextIteration()
            if let criteriaFunctionValue = simplex.solution
            {
                XCTAssert(criteriaFunctionValue.optimumSolution == WDSimplexValue(mValue: 20), "Wrong z0 value")
                XCTAssert(criteriaFunctionValue.xVectorIndexes == [1,2,3,4,5], "Wrong vector indexes")
                XCTAssert(criteriaFunctionValue.solutionFound == false, "Wrong detection if solution is found")
                XCTAssert(criteriaFunctionValue.inVectorIndex == 3, "Wrong in vector index")
                XCTAssert(criteriaFunctionValue.outVectorIndex == 6, "Wrong out vector index")
                var solutionFound = true
                for singleZCValue in simplex.zcValues
                {
                    solutionFound = solutionFound && (singleZCValue.mValue >= 0 && singleZCValue.realValue >= 0)
                }
                XCTAssert(!solutionFound, "Error during solution found checking")
            }
            else
            {
                XCTAssert(false, "z0 value is nil")
            }
        }
        example3()
        
        func example4()
        {
            let simplex = WDSimplexMethod(mainEquation: WDSimplexEquation(equationNumbers:[30, 27, 25, 30]), constraintEquations: [WDSimplexEquation(equationNumbers:[1, 4, 3, 2], equationSolution:40, equationType:.GreaterOrEqual),WDSimplexEquation(equationNumbers:[4, 1, 4, 2], equationSolution:61, equationType:.LessOrEqual),WDSimplexEquation(equationNumbers:[5, 2, 1, 4], equationSolution:92, equationType:.Equal)], equationTarget: .Min)
            simplex.generateVectors()
            simplex.nextIteration()
            if let criteriaFunctionValue = simplex.solution
            {
                XCTAssert(criteriaFunctionValue.optimumSolution == WDSimplexValue(mValue: 132), "Wrong z0 value")
                XCTAssert(criteriaFunctionValue.xVectorIndexes == [1,2,3,4,5], "Wrong vector indexes")
                XCTAssert(criteriaFunctionValue.solutionFound == false, "Wrong detection if solution is found")
                XCTAssert(criteriaFunctionValue.inVectorIndex == 4, "Wrong in vector index")
                XCTAssert(criteriaFunctionValue.outVectorIndex == 6, "Wrong out vector index")
                var solutionFound = true
                for singleZCValue in simplex.zcValues
                {
                    solutionFound = solutionFound && (singleZCValue.mValue >= 0 && singleZCValue.realValue >= 0)
                }
                XCTAssert(!solutionFound, "Error during solution found checking")
            }
            else
            {
                XCTAssert(false, "z0 value is nil")
            }
        }
        example4()
    }
    
    func testMatricesAndVectorsGeneration()
    {
        func testMatrixAndVectorsInitializaztion(simplex:WDSimplexMethod, cVectorNumbers:[WDSimplexValue], a0VectorNumbers:[WDSimplexValue])
        {
            simplex.generateVectors()
            if let cVector = simplex.cVector
            {
                XCTAssert(cVector.vectorNumbers == cVectorNumbers)
            }
            else
            {
                XCTAssert(false, "cVector is nil")
            }
            if let a0Vector = simplex.a0Vector
            {
                XCTAssert(a0Vector.vectorNumbers == a0VectorNumbers)
            }
            else
            {
                XCTAssert(false, "a0Vector is nil")
            }
            simplex.generateBMatrix()
            for i in 0...simplex.constraintEquations.count-1
            {
                XCTAssert(simplex.bMatrix.vectors[i].vectorNumbers == WDSimplexVector(vectorNumbers: simplex.aVectors[simplex.extendedSystemOfEquationsSize - simplex.constraintEquations.count + i].vectorNumbers).vectorNumbers)
            }
        }
        
        func example1()
        {
            let simplex = WDSimplexMethod(mainEquation: WDSimplexEquation(equationNumbers:[9, 24, 12, 27]), constraintEquations: [WDSimplexEquation(equationNumbers:[1, 1, 1, 1], equationSolution:210, equationType:.LessOrEqual),WDSimplexEquation(equationNumbers:[2, 1, 2, 1], equationSolution:360, equationType:.GreaterOrEqual),WDSimplexEquation(equationNumbers:[1, 1, -2, -2], equationSolution:0, equationType:.Equal)], equationTarget: .Max)
            testMatrixAndVectorsInitializaztion(simplex: simplex, cVectorNumbers: [WDSimplexValue(realValue: 9), WDSimplexValue(realValue: 24), WDSimplexValue(realValue: 12), WDSimplexValue(realValue: 27), WDSimplexValue(), WDSimplexValue(), WDSimplexValue(mValue: -1), WDSimplexValue(mValue: -1)], a0VectorNumbers: [WDSimplexValue(realValue:210), WDSimplexValue(realValue:360), WDSimplexValue()])
        }
        example1()
        
        func example2()
        {
            let simplex = WDSimplexMethod(mainEquation: WDSimplexEquation(equationNumbers:[6, 7, 8]), constraintEquations: [WDSimplexEquation(equationNumbers:[1, 2, 1], equationSolution:900, equationType:.LessOrEqual),WDSimplexEquation(equationNumbers:[1, 3, 2], equationSolution:1600, equationType:.LessOrEqual),WDSimplexEquation(equationNumbers:[2, -1, -1], equationSolution:0, equationType:.LessOrEqual)], equationTarget: .Max)
            testMatrixAndVectorsInitializaztion(simplex: simplex, cVectorNumbers: [WDSimplexValue(realValue: 6), WDSimplexValue(realValue: 7), WDSimplexValue(realValue: 8), WDSimplexValue(), WDSimplexValue(), WDSimplexValue()], a0VectorNumbers: [WDSimplexValue(realValue: 900), WDSimplexValue(realValue: 1600), WDSimplexValue()])
        }
        example2()
        
        func example3()
        {
            let simplex = WDSimplexMethod(mainEquation: WDSimplexEquation(equationNumbers:[80, 50, 40, 20]), constraintEquations: [WDSimplexEquation(equationNumbers:[8, 6, 4, 2], equationSolution:400, equationType:.LessOrEqual),WDSimplexEquation(equationNumbers:[1, 1, 1, 1], equationSolution:100, equationType:.Equal),WDSimplexEquation(equationNumbers:[8, 4, 4, 0], equationSolution:300, equationType:.GreaterOrEqual)], equationTarget: .Max)
            testMatrixAndVectorsInitializaztion(simplex: simplex, cVectorNumbers: [WDSimplexValue(realValue: 80), WDSimplexValue(realValue: 50), WDSimplexValue(realValue: 40), WDSimplexValue(realValue: 20), WDSimplexValue(), WDSimplexValue(), WDSimplexValue(mValue:-1), WDSimplexValue(mValue:-1)], a0VectorNumbers: [WDSimplexValue(realValue: 400), WDSimplexValue(realValue: 100), WDSimplexValue(realValue: 300)])
        }
        example3()
        
        func example4()
        {
            let simplex = WDSimplexMethod(mainEquation: WDSimplexEquation(equationNumbers:[7, 5, 6, 8]), constraintEquations: [WDSimplexEquation(equationNumbers:[1, 1, 1, 1], equationSolution:24, equationType:.Equal),WDSimplexEquation(equationNumbers:[3, 4, 2, 3], equationSolution:50, equationType:.LessOrEqual),WDSimplexEquation(equationNumbers:[1, 2, 2, 2], equationSolution:40, equationType:.GreaterOrEqual)], equationTarget: .Max)
            testMatrixAndVectorsInitializaztion(simplex: simplex, cVectorNumbers: [WDSimplexValue(realValue: 7), WDSimplexValue(realValue: 5), WDSimplexValue(realValue: 6), WDSimplexValue(realValue: 8), WDSimplexValue(), WDSimplexValue(mValue:-1), WDSimplexValue(), WDSimplexValue(mValue:-1)], a0VectorNumbers: [WDSimplexValue(realValue: 24), WDSimplexValue(realValue: 50), WDSimplexValue(realValue: 40)])
        }
        example4()
        
        func example5()
        {
            let simplex = WDSimplexMethod(mainEquation: WDSimplexEquation(equationNumbers:[10, 3, 12, 8]), constraintEquations: [WDSimplexEquation(equationNumbers:[1, 0, 2, 1], equationSolution:16, equationType:.GreaterOrEqual),WDSimplexEquation(equationNumbers:[1, 1, 0, -1], equationSolution:4, equationType:.Equal),WDSimplexEquation(equationNumbers:[3, 2, 4, 2], equationSolution:38, equationType:.LessOrEqual)], equationTarget: .Min)
            testMatrixAndVectorsInitializaztion(simplex: simplex, cVectorNumbers: [WDSimplexValue(realValue: 10), WDSimplexValue(realValue: 3), WDSimplexValue(realValue: 12), WDSimplexValue(realValue: 8), WDSimplexValue(), WDSimplexValue(mValue:1), WDSimplexValue(mValue:1), WDSimplexValue()], a0VectorNumbers: [WDSimplexValue(realValue: 16), WDSimplexValue(realValue: 4), WDSimplexValue(realValue: 38)])
        }
        example5()
        
        func example6()
        {
            let simplex = WDSimplexMethod(mainEquation: WDSimplexEquation(equationNumbers:[30, 27, 25, 30]), constraintEquations: [WDSimplexEquation(equationNumbers:[1, 4, 3, 2], equationSolution:40, equationType:.GreaterOrEqual),WDSimplexEquation(equationNumbers:[4, 1, 4, 2], equationSolution:61, equationType:.LessOrEqual),WDSimplexEquation(equationNumbers:[5, 2, 1, 4], equationSolution:92, equationType:.Equal)], equationTarget: .Min)
            testMatrixAndVectorsInitializaztion(simplex: simplex, cVectorNumbers: [WDSimplexValue(realValue:30), WDSimplexValue(realValue:27), WDSimplexValue(realValue:25), WDSimplexValue(realValue:30), WDSimplexValue(), WDSimplexValue(mValue:1), WDSimplexValue(), WDSimplexValue(mValue:1)], a0VectorNumbers: [WDSimplexValue(realValue:40), WDSimplexValue(realValue:61), WDSimplexValue(realValue:92)])
        }
        example6()
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
