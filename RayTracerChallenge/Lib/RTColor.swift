//
//  RTColor.swift
//  RayTracerChallenge
//
//  Created by Anna Melnikov on 12/14/23.
//

import Foundation
import simd

struct RTColor: Equatable {
    private var simd_repr: simd_double3
    
    var red: Double {
        return self.simd_repr.x
    }
    
    var green: Double {
        return self.simd_repr.y
    }
    
    var blue: Double {
        return self.simd_repr.z
    }
    
    init(red: Double, green: Double, blue: Double) {
        self.simd_repr = simd_double3(x: red, y: green, z: blue)
    }
    
    init(_ simd_repr: simd_double3) {
        self.simd_repr = simd_repr
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return equal_simd(lhs.simd_repr, rhs.simd_repr)
    }
    
    static func + (lhs: Self, rhs: Self) -> Self {
        return RTColor(lhs.simd_repr + rhs.simd_repr)
    }
    
    static func - (lhs: Self, rhs: Self) -> Self {
        return RTColor(lhs.simd_repr - rhs.simd_repr)
    }
    
    static func * (lhs: Self, rhs: Double) -> Self {
        return RTColor(lhs.simd_repr * rhs)
    }
    
    static func * (lhs: Self, rhs: Self) -> Self {
        return RTColor(lhs.simd_repr * rhs.simd_repr)
    }
}
