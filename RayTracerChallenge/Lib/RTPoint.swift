//
//  RTPoint.swift
//  RayTracerChallenge
//
//  Created by Anna Melnikov on 12/12/23.
//

import Foundation
import simd

struct RTPoint: Equatable {
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

  static func == (lhs: RTPoint, rhs: RTPoint) -> Bool {
    return equal_simd(lhs.simd_repr, rhs.simd_repr)
  }

  static func + (lhs: RTPoint, rhs: RTPoint) -> RTPoint {
    return RTPoint(lhs.simd_repr + rhs.simd_repr)
  }

  static func + (lhs: RTPoint, rhs: RTVector) -> RTPoint {
    return RTPoint(lhs.simd_repr + rhs.simd_repr)
  }

  static func - (lhs: RTPoint, rhs: RTPoint) -> RTVector {
    return RTVector(lhs.simd_repr - rhs.simd_repr)
  }

  static func - (lhs: RTPoint, rhs: RTVector) -> RTPoint {
    return RTPoint(lhs.simd_repr - rhs.simd_repr)
  }

  static prefix func - (this: RTPoint) -> RTPoint {
    return RTPoint(-this.simd_repr)
  }

  static func * (lhs: RTPoint, rhs: Double) -> RTPoint {
    return RTPoint(lhs.simd_repr * rhs)
  }

  static func / (lhs: RTPoint, rhs: Double) -> RTPoint {
    return RTPoint(lhs.simd_repr / rhs)
  }
}
