//
//  Point.swift
//  RayTracerChallenge
//
//  Created by Anna Melnikov on 12/12/23.
//

import Foundation
import simd

struct Point: Equatable {
  var simd_repr: simd_double3

  var x: Double {
    simd_repr.x
  }

  var y: Double {
    simd_repr.y
  }

  var z: Double {
    simd_repr.z
  }

  init(x: Double, y: Double, z: Double) {
    self.simd_repr = simd_double3(x: x, y: y, z: z)
  }

  init(_ simd_repr: simd_double3) {
    self.simd_repr = simd_repr
  }

  static func == (lhs: Point, rhs: Point) -> Bool {
    return equal_simd(lhs.simd_repr, rhs.simd_repr)
  }

  static func + (lhs: Point, rhs: Point) -> Point {
    return Point(lhs.simd_repr + rhs.simd_repr)
  }

  static func + (lhs: Point, rhs: Vector) -> Point {
    return Point(lhs.simd_repr + rhs.simd_repr)
  }

  static func - (lhs: Point, rhs: Point) -> Vector {
    return Vector(lhs.simd_repr - rhs.simd_repr)
  }

  static func - (lhs: Point, rhs: Vector) -> Point {
    return Point(lhs.simd_repr - rhs.simd_repr)
  }

  static prefix func - (this: Point) -> Point {
    return Point(-this.simd_repr)
  }

  static func * (lhs: Point, rhs: Double) -> Point {
    return Point(lhs.simd_repr * rhs)
  }

  static func / (lhs: Point, rhs: Double) -> Point {
    return Point(lhs.simd_repr / rhs)
  }
}
