//
//  Sphere.swift
//  RayTracer
//
//  Created by Anna Melnikov on 12/18/23.
//

import Foundation

class Sphere: Shape {
  let id = UUID()
  var transformation = Matrix.identity()

  static func == (lhs: Sphere, rhs: Sphere) -> Bool {
    lhs.id == rhs.id
  }

  func intersect(_ ray: Ray) -> [Intersection] {
    let ray = ray.transform(transformation.inverse())
    let sphere_to_ray = ray.origin - RTPoint(x: 0, y: 0, z: 0)

    let a = ray.direction ** ray.direction
    let b = 2 * ray.direction ** sphere_to_ray
    let c = sphere_to_ray ** sphere_to_ray - 1

    let discriminant = pow(b, 2) - 4 * a * c

    guard discriminant >= 0 else {
      return []
    }

    let t1 = (-b - sqrt(discriminant)) / (2 * a)
    let t2 = (-b + sqrt(discriminant)) / (2 * a)

    return [
      Intersection(t: t1, object: self),
      Intersection(t: t2, object: self),
    ]
  }
}
