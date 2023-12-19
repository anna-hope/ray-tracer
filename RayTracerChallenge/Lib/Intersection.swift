//
//  Intersection.swift
//  RayTracer
//
//  Created by Anna Melnikov on 12/19/23.
//

import Foundation

struct Intersection: Equatable {
  var t: Double
  var object: any Shape

  static func == (lhs: Intersection, rhs: Intersection) -> Bool {
    lhs.t == rhs.t && lhs.object === rhs.object
  }
}

func hit(_ xs: [Intersection]) -> Intersection? {
  xs.filter { $0.t > 0 }.sorted { $0.t < $1.t }.first
}
