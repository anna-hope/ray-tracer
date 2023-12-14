//
//  Tick.swift
//  RayTracerChallenge
//
//  Created by Anna Melnikov on 12/13/23.
//

import Foundation

struct Projectile {
    var position: Point
    var velocity: Vector
}

struct Environment {
    private var gravity: Vector
    private var wind: Vector
    
    init(gravity: Vector, wind: Vector) {
        self.gravity = gravity
        self.wind = wind
    }
    
    func tick(projectile: Projectile) -> Projectile {
        let position = projectile.position + projectile.velocity
        let velocity = projectile.velocity + self.gravity + self.wind
        return Projectile(position: position, velocity: velocity)
    }
}
