//
//  Ray.swift
//  RayTracer
//
//  Created by Anna Melnikov on 12/18/23.
//

import Foundation

struct Ray: Equatable {
  var origin: RTPoint
  var direction: RTVector

  func position(_ t: Double) -> RTPoint {
    origin + direction * t
  }

  func transform(_ matrix: Matrix) -> Self {
    Ray(origin: matrix * origin, direction: matrix * direction)
  }
}
