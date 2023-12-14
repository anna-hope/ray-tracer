//
//  Helpers.swift
//  RayTracerChallenge
//
//  Created by Anna Melnikov on 12/12/23.
//

import Foundation
import simd

let epsilon = 0.00001

func equal(_ a: Double, _ b: Double) -> Bool {
  return abs(a - b) < epsilon
}

func equal_simd(_ a: simd_double3, _ b: simd_double3) -> Bool {
    return equal(a.x, b.x) && equal(a.y, b.y) && equal(a.z, b.z) 
}

