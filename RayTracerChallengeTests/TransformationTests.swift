//
//  TransformationTests.swift
//  RayTracerChallengeTests
//
//  Created by Anna Melnikov on 12/15/23.
//

import XCTest

@testable import RayTracer

final class TransformationTests: XCTestCase {
  func testMultiplyingByTranslationMatrix() {
    let transform = RTMatrix4x4.translation(x: 5, y: -3, z: 2)
    let p = RTPoint(x: -3, y: 4, z: 5)
    XCTAssertEqual(transform * p, RTPoint(x: 2, y: 1, z: 7))
  }

  func testMultiplyingByInverseTranslationMatrix() {
    let transform = RTMatrix4x4.translation(x: 5, y: -3, z: 2)
    let inv = transform.inverse()
    let p = RTPoint(x: -3, y: 4, z: 5)
    XCTAssertEqual(inv * p, RTPoint(x: -8, y: 7, z: 3))
  }

  func testTranslationDoesNotAffectVectors() {
    let transform = RTMatrix4x4.translation(x: 5, y: -3, z: 2)
    let v = RTVector(x: -3, y: 4, z: 5)
    XCTAssertEqual(transform * v, v)
  }
}
