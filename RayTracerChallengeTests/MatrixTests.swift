//
//  MatrixTests.swift
//  RayTracerChallengeTests
//
//  Created by Anna Melnikov on 12/15/23.
//

import XCTest

@testable import RayTracer

final class MatrixTests: XCTestCase {
  func testTupleMultiply() {
    let a = RTMatrix4x4([[1, 2, 8, 0], [2, 4, 6, 0], [3, 4, 4, 0], [4, 2, 1, 1]])
    let b = RTPoint(x: 1, y: 2, z: 3)
    XCTAssertEqual(a * b, RTPoint(x: 18, y: 24, z: 33))
  }

  func testTupleMultiplyIdentity() {
    let identity = RTMatrix4x4.eye()
    let a = RTPoint(x: 1, y: 2, z: 3)
    XCTAssertEqual(identity * a, a)
  }
}
