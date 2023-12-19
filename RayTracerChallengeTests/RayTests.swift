//
//  RayTests.swift
//  RayTracerChallengeTests
//
//  Created by Anna Melnikov on 12/19/23.
//

import XCTest

@testable import RayTracer

final class RayTests: XCTestCase {
  func testTranslatingRay() {
    let r = Ray(origin: RTPoint(x: 1, y: 2, z: 3), direction: RTVector(x: 0, y: 1, z: 0))
    let m = Matrix.translation(x: 3, y: 4, z: 5)
    let r2 = r.transform(m)
    XCTAssertEqual(r2.origin, RTPoint(x: 4, y: 6, z: 8))
    XCTAssertEqual(r2.direction, RTVector(x: 0, y: 1, z: 0))
  }

  func testScalingRay() {
    let r = Ray(origin: RTPoint(x: 1, y: 2, z: 3), direction: RTVector(x: 0, y: 1, z: 0))
    let m = Matrix.scaling(x: 2, y: 3, z: 4)
    let r2 = r.transform(m)
    XCTAssertEqual(r2.origin, RTPoint(x: 2, y: 6, z: 12))
    XCTAssertEqual(r2.direction, RTVector(x: 0, y: 3, z: 0))
  }
}
