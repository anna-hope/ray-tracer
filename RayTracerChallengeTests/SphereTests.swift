//
//  RaySphereIntersectionTests.swift
//  RayTracerChallengeTests
//
//  Created by Anna Melnikov on 12/18/23.
//

import XCTest

@testable import RayTracer

final class SphereTests: XCTestCase {
  func testCreateRay() {
    let origin = RTPoint(x: 1, y: 2, z: 3)
    let direction = RTVector(x: 4, y: 5, z: 6)
    let r = Ray(origin: origin, direction: direction)
    XCTAssertEqual(r.origin, origin)
    XCTAssertEqual(r.direction, direction)
  }

  func testComputingPointFromDistance() {
    let r = Ray(origin: RTPoint(x: 2, y: 3, z: 4), direction: RTVector(x: 1, y: 0, z: 0))
    XCTAssertEqual(r.position(0), RTPoint(x: 2, y: 3, z: 4))
    XCTAssertEqual(r.position(1), RTPoint(x: 3, y: 3, z: 4))
    XCTAssertEqual(r.position(-1), RTPoint(x: 1, y: 3, z: 4))
    XCTAssertEqual(r.position(2.5), RTPoint(x: 4.5, y: 3, z: 4))
  }

  func testRayIntersectsSphereAtTwoPoints() {
    let r = Ray(origin: RTPoint(x: 0, y: 0, z: -5), direction: RTVector(x: 0, y: 0, z: 1))
    let s = Sphere()
    let xs = s.intersect(r)
    XCTAssertEqual(xs.count, 2)
    XCTAssertEqual(xs[0].t, 4)
    XCTAssertEqual(xs[1].t, 6)
  }

  func testRayIntersectsSphereAtTangent() {
    let r = Ray(origin: RTPoint(x: 0, y: 1, z: -5), direction: RTVector(x: 0, y: 0, z: 1))
    let s = Sphere()
    let xs = s.intersect(r)
    XCTAssertEqual(xs.count, 2)
    XCTAssertEqual(xs[0].t, 5)
    XCTAssertEqual(xs[1].t, 5)
  }

  func testRayMissesSphere() {
    let r = Ray(origin: RTPoint(x: 0, y: 2, z: -5), direction: RTVector(x: 0, y: 0, z: 1))
    let s = Sphere()
    let xs = s.intersect(r)
    XCTAssert(xs.isEmpty)
  }

  func testRayInsideSphere() {
    let r = Ray(origin: RTPoint(x: 0, y: 0, z: 0), direction: RTVector(x: 0, y: 0, z: 1))
    let s = Sphere()
    let xs = s.intersect(r)
    XCTAssertEqual(xs.count, 2)
    XCTAssertEqual(xs[0].t, -1)
    XCTAssertEqual(xs[1].t, 1)
  }

  func testSphereBehindRay() {
    let r = Ray(origin: RTPoint(x: 0, y: 0, z: 5), direction: RTVector(x: 0, y: 0, z: 1))
    let s = Sphere()
    let xs = s.intersect(r)
    XCTAssertEqual(xs.count, 2)
    XCTAssertEqual(xs[0].t, -6)
    XCTAssertEqual(xs[1].t, -4)
  }

  func testCreateIntersection() {
    let s = Sphere()
    let i = Intersection(t: 3.5, object: s)
    XCTAssertEqual(i.t, 3.5)
    XCTAssertEqual(i.object as! Sphere, s)
  }

  func testAggregatingIntersections() {
    let s = Sphere()
    let i1 = Intersection(t: 1, object: s)
    let i2 = Intersection(t: 2, object: s)
    let xs = [i1, i2]
    XCTAssertEqual(xs.count, 2)
    XCTAssertEqual(xs[0].t, 1)
    XCTAssertEqual(xs[1].t, 2)
  }

  func testHitIntersectionsHavePositiveT() {
    let s = Sphere()
    let i1 = Intersection(t: 1, object: s)
    let i2 = Intersection(t: 2, object: s)
    let xs = [i2, i1]
    let i = hit(xs)
    XCTAssertEqual(i, i1)
  }

  func testHitSomeIntersectionsHaveNegativeT() {
    let s = Sphere()
    let i1 = Intersection(t: -1, object: s)
    let i2 = Intersection(t: 1, object: s)
    let xs = [i2, i1]
    let i = hit(xs)
    XCTAssertEqual(i, i2)
  }

  func testHitAllIntersectionsHaveNegativeT() {
    let s = Sphere()
    let i1 = Intersection(t: -2, object: s)
    let i2 = Intersection(t: -1, object: s)
    let xs = [i2, i1]
    let i = hit(xs)
    XCTAssertEqual(i, nil)
  }

  func testHitIsAlwaysLowestNonnegativeIntersection() {
    let s = Sphere()
    let i1 = Intersection(t: 5, object: s)
    let i2 = Intersection(t: 7, object: s)
    let i3 = Intersection(t: -3, object: s)
    let i4 = Intersection(t: 2, object: s)
    let xs = [i1, i2, i3, i4]
    let i = hit(xs)
    XCTAssertEqual(i, i4)
  }

  func testSphereDefaultTransformation() {
    let s = Sphere()
    XCTAssertEqual(s.transformation, Matrix.identity())
  }

  func testChangeSphereDefaultTransformation() {
    let s = Sphere()
    let t = Matrix.translation(x: 2, y: 3, z: 4)
    s.transformation = t
    XCTAssertEqual(s.transformation, t)
  }

  func testIntersectScaledSphereWithRay() {
    let r = Ray(origin: RTPoint(x: 0, y: 0, z: -5), direction: RTVector(x: 0, y: 0, z: 1))
    let s = Sphere()
    s.transformation = Matrix.scaling(x: 2, y: 2, z: 2)
    let xs = s.intersect(r)
    XCTAssertEqual(xs.count, 2)
    XCTAssertEqual(xs[0].t, 3)
    XCTAssertEqual(xs[1].t, 7)
  }

  func testIntersectTranslatedSphereWithRay() {
    let r = Ray(origin: RTPoint(x: 0, y: 0, z: -5), direction: RTVector(x: 0, y: 0, z: 1))
    let s = Sphere()
    s.transformation = Matrix.translation(x: 5, y: 0, z: 0)
    let xs = s.intersect(r)
    XCTAssert(xs.isEmpty)
  }
}
