//
//  ColorTests.swift
//  RayTracerChallengeTests
//
//  Created by Anna Melnikov on 12/14/23.
//

import XCTest

@testable import RayTracer

final class ColorTests: XCTestCase {

  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testMakeColor() {
    let c = RTColor(red: -0.5, green: 0.4, blue: 1.7)
    XCTAssertEqual(c.red, -0.5)
    XCTAssertEqual(c.green, 0.4)
    XCTAssertEqual(c.blue, 1.7)
  }

  func testAddition() {
    let c1 = RTColor(red: 0.9, green: 0.6, blue: 0.75)
    let c2 = RTColor(red: 0.7, green: 0.1, blue: 0.25)
    XCTAssertEqual(c1 + c2, RTColor(red: 1.6, green: 0.7, blue: 1.0))
  }

  func testSubtraction() {
    let c1 = RTColor(red: 0.9, green: 0.6, blue: 0.75)
    let c2 = RTColor(red: 0.7, green: 0.1, blue: 0.25)
    XCTAssertEqual(c1 - c2, RTColor(red: 0.2, green: 0.5, blue: 0.5))
  }

  func testMultiplyingByScalar() {
    let c = RTColor(red: 0.2, green: 0.3, blue: 0.4)
    XCTAssertEqual(c * 2, RTColor(red: 0.4, green: 0.6, blue: 0.8))
  }

  func testMultiplyingColors() {
    let c1 = RTColor(red: 1, green: 0.2, blue: 0.4)
    let c2 = RTColor(red: 0.9, green: 1, blue: 0.1)
    XCTAssertEqual(c1 * c2, RTColor(red: 0.9, green: 0.2, blue: 0.04))
  }

}
