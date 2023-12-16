//
//  Matrix.swift
//  RayTracer
//
//  Created by Anna Melnikov on 12/15/23.
//

import Foundation
import simd

struct RTMatrix4x4 {
  private var simd_repr: simd_double4x4

  init(_ simd_repr: simd_double4x4) {
    self.simd_repr = simd_repr
  }

  init(_ columns: [[Double]]) {
    var simd_columns: [simd_double4] = []

    for column in columns {
      let column = simd_double4(column)
      simd_columns.append(column)
    }

    self.simd_repr = simd_double4x4(simd_columns)
  }

  static func * <T: Tuple>(lhs: Self, rhs: T) -> T {
    let result = matrix_multiply(lhs.simd_repr, rhs.tuple())
    return T(result)
  }

  static func eye() -> Self {
    Self.init(matrix_identity_double4x4)
  }

  static func translation(x: Double, y: Double, z: Double) -> Self {
    Self.init([[1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0], [x, y, z, 1]])
  }

  func inverse() -> Self {
    Self.init(self.simd_repr.inverse)
  }
}
