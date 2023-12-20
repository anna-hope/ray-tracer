//
//  TransformationTests.swift
//  RayTracerChallengeTests
//
//  Created by Anna Melnikov on 12/15/23.
//

import XCTest

@testable import RayTracer

final class TransformationTests: XCTestCase {
  let sqrt_2_over_2 = sqrt(2) / 2

  func testMultiplyingByTranslationMatrix() {
    let transform = Matrix.translation(x: 5, y: -3, z: 2)
    let p = RTPoint(x: -3, y: 4, z: 5)
    XCTAssertEqual(transform * p, RTPoint(x: 2, y: 1, z: 7))
  }

  func testMultiplyingByInverseTranslationMatrix() {
    var transform = Matrix.translation(x: 5, y: -3, z: 2)
    let inv = transform.inverse()
    let p = RTPoint(x: -3, y: 4, z: 5)
    XCTAssertEqual(inv * p, RTPoint(x: -8, y: 7, z: 3))
  }

  func testTranslationDoesNotAffectVectors() {
    let transform = Matrix.translation(x: 5, y: -3, z: 2)
    let v = RTVector(x: -3, y: 4, z: 5)
    XCTAssertEqual(transform * v, v)
  }

  func testRotatingAroundX() {
    let p = RTPoint(x: 0, y: 1, z: 0)
    let half_quarter = Matrix.rotation_x(Double.pi / 4)
    let full_quarter = Matrix.rotation_x(Double.pi / 2)
    XCTAssertEqual(half_quarter * p, RTPoint(x: 0, y: self.sqrt_2_over_2, z: self.sqrt_2_over_2))
    XCTAssertEqual(full_quarter * p, RTPoint(x: 0, y: 0, z: 1))
  }

  func testInverseXRotation() {
    let p = RTPoint(x: 0, y: 1, z: 0)
    var half_quarter = Matrix.rotation_x(Double.pi / 4)
    let inv = half_quarter.inverse()
    XCTAssertEqual(inv * p, RTPoint(x: 0, y: sqrt_2_over_2, z: -sqrt_2_over_2))
  }

  func testRotatingAroundY() {
    let p = RTPoint(x: 0, y: 0, z: 1)
    let half_quarter = Matrix.rotation_y(Double.pi / 4)
    let full_quarter = Matrix.rotation_y(Double.pi / 2)
    XCTAssertEqual(half_quarter * p, RTPoint(x: sqrt_2_over_2, y: 0, z: sqrt_2_over_2))
    XCTAssertEqual(full_quarter * p, RTPoint(x: 1, y: 0, z: 0))
  }

  func testRotatingAroundZ() {
    let p = RTPoint(x: 0, y: 1, z: 0)
    let half_quarter = Matrix.rotation_z(Double.pi / 4)
    let full_quarter = Matrix.rotation_z(Double.pi / 2)
    XCTAssertEqual(half_quarter * p, RTPoint(x: -sqrt_2_over_2, y: sqrt_2_over_2, z: 0))
    XCTAssertEqual(full_quarter * p, RTPoint(x: -1, y: 0, z: 0))
  }

  func testShearingXY() {
    let transform = Matrix.shearing(1, 0, 0, 0, 0, 0)
    let p = RTPoint(x: 2, y: 3, z: 4)
    XCTAssertEqual(transform * p, RTPoint(x: 5, y: 3, z: 4))
  }

  func testShearingXZ() {
    let transform = Matrix.shearing(0, 1, 0, 0, 0, 0)
    let p = RTPoint(x: 2, y: 3, z: 4)
    XCTAssertEqual(transform * p, RTPoint(x: 6, y: 3, z: 4))
  }

  func testShearingYX() {
    let transform = Matrix.shearing(0, 0, 1, 0, 0, 0)
    let p = RTPoint(x: 2, y: 3, z: 4)
    XCTAssertEqual(transform * p, RTPoint(x: 2, y: 5, z: 4))
  }

  func testShearingYZ() {
    let transform = Matrix.shearing(0, 0, 0, 1, 0, 0)
    let p = RTPoint(x: 2, y: 3, z: 4)
    XCTAssertEqual(transform * p, RTPoint(x: 2, y: 7, z: 4))
  }

  func testShearingZX() {
    let transform = Matrix.shearing(0, 0, 0, 0, 1, 0)
    let p = RTPoint(x: 2, y: 3, z: 4)
    XCTAssertEqual(transform * p, RTPoint(x: 2, y: 3, z: 6))
  }

  func testShearingZY() {
    let transform = Matrix.shearing(0, 0, 0, 0, 0, 1)
    let p = RTPoint(x: 2, y: 3, z: 4)
    XCTAssertEqual(transform * p, RTPoint(x: 2, y: 3, z: 7))
  }

  func testIndividualTransformations() {
    let p = RTPoint(x: 1, y: 0, z: 1)
    let A = Matrix.rotation_x(Double.pi / 2)
    let B = Matrix.scaling(x: 5, y: 5, z: 5)
    let C = Matrix.translation(x: 10, y: 5, z: 7)
    // Apply rotation first.
    let p2 = A * p
    XCTAssertEqual(p2, RTPoint(x: 1, y: -1, z: 0))
    // Then apply scaling.
    let p3 = B * p2
    XCTAssertEqual(p3, RTPoint(x: 5, y: -5, z: 0))
    // Then apply translation.
    let p4 = C * p3
    XCTAssertEqual(p4, RTPoint(x: 15, y: 0, z: 7))
  }

  func testChainedTransformations() {
    let p = RTPoint(x: 1, y: 0, z: 1)
    let T = Matrix.identity().rotate_x(Double.pi / 2).scale(x: 5, y: 5, z: 5)
      .translate(x: 10, y: 5, z: 7)
    XCTAssertEqual(T * p, RTPoint(x: 15, y: 0, z: 7))
  }
}
