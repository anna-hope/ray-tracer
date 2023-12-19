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
    let a = Matrix([[1, 2, 8, 0], [2, 4, 6, 0], [3, 4, 4, 0], [4, 2, 1, 1]])
    let b = RTPoint(x: 1, y: 2, z: 3)
    XCTAssertEqual(a * b, RTPoint(x: 18, y: 24, z: 33))
  }

  func testTupleMultiplyIdentity() {
    let identity = Matrix.identity()
    let a = RTPoint(x: 1, y: 2, z: 3)
    XCTAssertEqual(identity * a, a)
  }

  func testScalingPoint() {
    let transform = Matrix.scaling(x: 2, y: 3, z: 4)
    let p = RTPoint(x: -4, y: 6, z: 8)
    XCTAssertEqual(transform * p, RTPoint(x: -8, y: 18, z: 32))
  }

  func testScalingVector() {
    let transform = Matrix.scaling(x: 2, y: 3, z: 4)
    let v = RTVector(x: -4, y: 6, z: 8)
    XCTAssertEqual(transform * v, RTVector(x: -8, y: 18, z: 32))
  }

  func testMultiplyingInverseScalingMatrix() {
    let transform = Matrix.scaling(x: 2, y: 3, z: 4)
    let inv = transform.inverse
    let v = RTVector(x: -4, y: 6, z: 8)
    XCTAssertEqual(inv * v, RTVector(x: -2, y: 2, z: 2))
  }

  func testReflectionIsScalingByNegativeValue() {
    let transform = Matrix.scaling(x: -1, y: 1, z: 1)
    let p = RTPoint(x: 2, y: 3, z: 4)
    XCTAssertEqual(transform * p, RTPoint(x: -2, y: 3, z: 4))
  }
}
