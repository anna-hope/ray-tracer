//
//  RayTracerChallengeTests.swift
//  RayTracerChallengeTests
//
//  Created by Anna Melnikov on 12/12/23.
//

import XCTest

@testable import RayTracer

final class TupleTests: XCTestCase {

  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testPointCreatesPoints() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    // Any test you write for XCTest can be annotated as throws and async.
    // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
    // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    let p = RTPoint(x: 4, y: -4, z: 3)
    XCTAssertEqual(p, p)
  }

  func testVectorCreatesVectors() {
    let v = RTVector(x: 4, y: -4, z: 3)
    XCTAssertEqual(v, v)
  }

  func testAddingTwoPoints() {
    let a1 = RTPoint(x: 3, y: -2, z: 5)
    let a2 = RTPoint(x: -2, y: 3, z: 1)
    XCTAssertEqual(a1 + a2, RTPoint(x: 1, y: 1, z: 6))
  }

  func testAddingTwoVectors() {
    let a1 = RTVector(x: 3, y: -2, z: 5)
    let a2 = RTVector(x: -2, y: 3, z: 1)
    XCTAssertEqual(a1 + a2, RTVector(x: 1, y: 1, z: 6))
  }

  func testAddingPointAndVector() {
    let a1 = RTPoint(x: 3, y: -2, z: 5)
    let a2 = RTVector(x: -2, y: 3, z: 1)
    XCTAssertEqual(a1 + a2, RTPoint(x: 1, y: 1, z: 6))
  }

  func testSubtractingTwoPoints() {
    let p1 = RTPoint(x: 3, y: 2, z: 1)
    let p2 = RTPoint(x: 5, y: 6, z: 7)
    XCTAssertEqual(p1 - p2, RTVector(x: -2, y: -4, z: -6))
  }

  func testSubtractingVectorFromPoint() {
    let p = RTPoint(x: 3, y: 2, z: 1)
    let v = RTVector(x: 5, y: 6, z: 7)
    XCTAssertEqual(p - v, RTPoint(x: -2, y: -4, z: -6))
  }

  func testSubtractingTwoVectors() {
    let v1 = RTVector(x: 3, y: 2, z: 1)
    let v2 = RTVector(x: 5, y: 6, z: 7)
    XCTAssertEqual(v1 - v2, RTVector(x: -2, y: -4, z: -6))
  }

  func testSubtractingVectorFromZeroVector() {
    let zero = RTVector(x: 0, y: 0, z: 0)
    let v = RTVector(x: 1, y: -2, z: 3)
    XCTAssertEqual(zero - v, RTVector(x: -1, y: 2, z: -3))
  }

  func testNegateVector() {
    let a = RTVector(x: 1, y: -2, z: 3)
    XCTAssertEqual(-a, RTVector(x: -1, y: 2, z: -3))
  }

  func testNegatePoint() {
    let a = RTPoint(x: 1, y: -2, z: 3)
    XCTAssertEqual(-a, RTPoint(x: -1, y: 2, z: -3))
  }

  func testMultiplyingVectorByScalar() {
    let a = RTVector(x: 1, y: -2, z: 3)
    XCTAssertEqual(a * 3.5, RTVector(x: 3.5, y: -7, z: 10.5))
  }

  func testMultiplyingVectorByFraction() {
    let a = RTVector(x: 1, y: -2, z: 3)
    XCTAssertEqual(a * 0.5, RTVector(x: 0.5, y: -1, z: 1.5))
  }

  func testMultiplyingPointByScalar() {
    let a = RTPoint(x: 1, y: -2, z: 3)
    XCTAssertEqual(a * 3.5, RTPoint(x: 3.5, y: -7, z: 10.5))
  }

  func testMultiplyingPointByFraction() {
    let a = RTPoint(x: 1, y: -2, z: 3)
    XCTAssertEqual(a * 0.5, RTPoint(x: 0.5, y: -1, z: 1.5))
  }

  func testDivideVectorByScalar() {
    let a = RTVector(x: 1, y: -2, z: 3)
    XCTAssertEqual(a / 2, RTVector(x: 0.5, y: -1, z: 1.5))
  }

  func testDividePointByScalar() {
    let a = RTPoint(x: 1, y: -2, z: 3)
    XCTAssertEqual(a / 2, RTPoint(x: 0.5, y: -1, z: 1.5))
  }

  func testNormalizeVector() {
    let vectors = [RTVector(x: 4, y: 0, z: 0), RTVector(x: 1, y: 2, z: 3)]
    let expectedResults = [
      RTVector(x: 1, y: 0, z: 0),
      RTVector(x: 1 / 14.squareRoot(), y: 2 / 14.squareRoot(), z: 3 / 14.squareRoot()),
    ]
    for (vector, expected) in zip(vectors, expectedResults) {
      XCTAssertEqual(vector.norm(), expected)
    }
  }

  func testDotProduct() {
    let a = RTVector(x: 1, y: 2, z: 3)
    let b = RTVector(x: 2, y: 3, z: 4)
    XCTAssertEqual(a ** b, 20)
  }

  func testCrossProduct() {
    let a = RTVector(x: 1, y: 2, z: 3)
    let b = RTVector(x: 2, y: 3, z: 4)
    XCTAssertEqual(a !! b, RTVector(x: -1, y: 2, z: -1))
    XCTAssertEqual(b !! a, RTVector(x: 1, y: -2, z: 1))
  }

  //    func testPerformanceExample() throws {
  //        // This is an example of a performance test case.
  //        self.measure {
  //            // Put the code you want to measure the time of here.
  //        }
  //    }

}
