import simd

let transform = simd_double4x4(rows: [
  simd_double4(1, 0, 0, 5),
  simd_double4(0, 1, 0, -3),
  simd_double4(0, 0, 1, 2),
  simd_double4(0, 0, 0, 1),
])
let point = simd_double4(x: -3, y: 4, z: 5, w: 1)
//let result = matrix_multiply(transform, p)

let transform_matrix = RTMatrix4x4.translation(x: 5, y: -3, z: 2)
let p = RTPoint(x: -3, y: 4, z: 5)
