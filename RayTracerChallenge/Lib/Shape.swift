//
//  Shape.swift
//  RayTracer
//
//  Created by Anna Melnikov on 12/18/23.
//

import Foundation

protocol Shape: Equatable, Identifiable, AnyObject {
  func intersect(_ ray: Ray) -> [Intersection]
}
