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

  static func * (lhs: Self, rhs: Self) -> Self {
    let result = matrix_multiply(lhs.simd_repr, rhs.simd_repr)
    return Self.init(result)
  }

  static func eye() -> Self {
    Self.init(matrix_identity_double4x4)
  }

  static func translation(x: Double, y: Double, z: Double) -> Self {
    Self.init([[1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0], [x, y, z, 1]])
  }

  static func scaling(x: Double, y: Double, z: Double) -> Self {
    Self.init([[x, 0, 0, 0], [0, y, 0, 0], [0, 0, z, 0], [0, 0, 0, 1]])
  }

  func inverse() -> Self {
    Self.init(self.simd_repr.inverse)
  }

  static func rotation_x(_ radians: Double) -> Self {
    Self.init([
      [1, 0, 0, 0], [0, cos(radians), sin(radians), 0], [0, -sin(radians), cos(radians), 0],
      [0, 0, 0, 1],
    ])
  }

  static func rotation_y(_ radians: Double) -> Self {
    Self.init([
      [cos(radians), 0, -sin(radians), 0], [0, 1, 0, 0],
      [sin(radians), 0, cos(radians), 0], [0, 0, 0, 1],
    ])
  }

  static func rotation_z(_ radians: Double) -> Self {
    Self.init([
      [cos(radians), sin(radians), 0, 0], [-sin(radians), cos(radians), 0, 0], [0, 0, 1, 0],
      [0, 0, 0, 1],
    ])
  }

  static func shearing(
    _ xy: Double, _ xz: Double, _ yx: Double,
    _ yz: Double, _ zx: Double, _ zy: Double
  ) -> Self {
    Self.init([
      [1, yx, zx, 0], [xy, 1, zy, 0], [xz, yz, 1, 0],
      [0, 0, 0, 1],
    ])
  }

  func rotate_x(_ radians: Double) -> Self {
    Self.rotation_x(radians) * self
  }

  func rotate_y(_ radians: Double) -> Self {
    Self.rotation_y(radians) * self
  }

  func rotate_z(_ radians: Double) -> Self {
    Self.rotation_z(radians) * self
  }

  func scale(x: Double, y: Double, z: Double) -> Self {
    Self.scaling(x: x, y: y, z: z) * self
  }

  func translate(x: Double, y: Double, z: Double) -> Self {
    Self.translation(x: x, y: y, z: z) * self
  }

  func shear(
    _ xy: Double, _ xz: Double, _ yx: Double,
    _ yz: Double, _ zx: Double, _ zy: Double
  ) -> Self {
    Self.shearing(xy, xz, yx, yz, zx, zy) * self
  }
}
