//
//  CGPoint+VectorAdditionTests.swift
//  LochTests
//
//  Created by Eric Cormack on 3/18/18.
//  Copyright © 2018 the Odin Spire. All rights reserved.
//

import XCTest
@testable import Loch

class CGPoint_VectorArithmaticTests: XCTestCase {
    let a = CGPoint(x: 1, y: 2)
    let b = CGPoint(x: 4, y: 8)
    
    let duple: (x: CGFloat, y: CGFloat) = (4, 8)
    
    let scalar: CGFloat = 2
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
//
//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//        super.tearDown()
//    }
    
    func testAddTwoPoints() {
        let target = CGPoint(x: a.x + b.x, y: a.y + b.y)
        
        XCTAssertEqual(target, a + b)
    }
    
    func testAddPointAndDoubleOfCGFloats() {
        let target = CGPoint(x: a.x + duple.x, y: a.y + duple.y)
        
        XCTAssertEqual(target, a + duple)
        XCTAssertEqual(target, duple + a)
    }
    
    func testAddPointAndDoubleOfNumbers() {
        let target = CGPoint(x: a.x + b.x, y: a.y + b.y)
        
        XCTAssertEqual(target, a + b)
        XCTAssertEqual(target, b + a)
    }
    
    func testScalarMultiplyDoesSo() {
        let target = CGPoint(x: scalar * a.x, y: scalar * a.y)
        
        XCTAssertEqual(target, scalar * a)
    }
    
    func testInvertFlipsPointAcrossOrigin() {
        let target = CGPoint(x: -a.x, y: -a.y)
        
        XCTAssertEqual(target, -a)
    }
    
    func testSubtractionOfTwoCGPoints() {
        let target = CGPoint(x: a.x - b.x, y: a.y - b.y)
        
        XCTAssertEqual(target, a - b)
    }
    
    func testSubtractionOfTupleAndPoint() {
        let target = CGPoint(x: duple.x - b.x, y: duple.y - b.y)
        
        XCTAssertEqual(target, duple - b)
    }
    
    func testSubtractionOfPointAndTuple() {
        let target = CGPoint(x: a.x - duple.x, y: a.y - duple.y)
        
        XCTAssertEqual(target, a - duple)
    }
}
