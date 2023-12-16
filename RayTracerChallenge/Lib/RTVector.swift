//
//  Vector.swift
//  RayTracerChallenge
//
//  Created by Anna Melnikov on 12/12/23.
//

import Foundation
import simd

infix operator **  // dot
infix operator !!  // cross

struct RTVector: Tuple {
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

  init(_ tuple: simd_double4) {
    self.simd_repr = simd_double3(x: tuple.x, y: tuple.y, z: tuple.z)
  }

  static func == (lhs: RTVector, rhs: RTVector) -> Bool {
    return equal_simd(lhs.simd_repr, rhs.simd_repr)
  }

  static func + (lhs: RTVector, rhs: RTVector) -> RTVector {
    return RTVector(lhs.simd_repr + rhs.simd_repr)
  }

  static func - (lhs: RTVector, rhs: RTVector) -> RTVector {
    return RTVector(lhs.simd_repr - rhs.simd_repr)
  }

  static prefix func - (this: RTVector) -> RTVector {
    return RTVector(-this.simd_repr)
  }

  static func * (lhs: RTVector, rhs: Double) -> RTVector {
    return RTVector(lhs.simd_repr * rhs)
  }

  static func / (lhs: RTVector, rhs: Double) -> RTVector {
    return RTVector(lhs.simd_repr / rhs)
  }

  static func ** (lhs: Self, rhs: Self) -> Double {
    return dot(lhs.simd_repr, rhs.simd_repr)
  }

  static func !! (lhs: Self, rhs: Self) -> Self {
    return RTVector(cross(lhs.simd_repr, rhs.simd_repr))
  }

  func norm() -> Self {
    return RTVector(normalize(self.simd_repr))
  }

  func tuple() -> simd_double4 {
    simd_double4(x: self.x, y: self.y, z: self.z, w: 0)
  }
}
