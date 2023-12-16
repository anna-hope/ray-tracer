//
//  Tuple.swift
//  RayTracer
//
//  Created by Anna Melnikov on 12/15/23.
//

import Foundation
import simd

protocol Tuple: Equatable {
  init(_ tuple: simd_double4)
  func tuple() -> simd_double4
}
