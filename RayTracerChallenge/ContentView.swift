//
//  ContentView.swift
//  RayTracerChallenge
//
//  Created by Anna Melnikov on 12/12/23.
//

import SwiftUI

private struct RenderPoint {
  var point: CGPoint
  var color: Color
}

extension Color {
  init(_ color: RTColor) {
    self.init(red: color.red, green: color.green, blue: color.blue)
  }
}

struct ContentView: View {
  @State private var runRenderButtonDisabled = false

  @State private var showCanvas = false

  @State private var showClearCanvas = false

  @State private var renderPoints: [RenderPoint] = []

  @State private var progress = 0.0
  @State private var showProgress = false

  private let canvasWidth = 500
  private let canvasHeight = 500

  var body: some View {
    VStack {
      HStack {
        Button("Render", action: runSimulation).keyboardShortcut( /*@START_MENU_TOKEN@*/
          .defaultAction /*@END_MENU_TOKEN@*/
        ).disabled(runRenderButtonDisabled)

        if showClearCanvas {
          Button("Clear") {
            renderPoints.removeAll()
          }
        }
      }

      if showProgress {
        ProgressView(value: progress)
      }

      if showCanvas {
        Canvas { context, size in
          for renderPoint in renderPoints {
            let rect = CGRect(x: renderPoint.point.x, y: renderPoint.point.y, width: 1, height: 1)
            context.fill(Path(rect), with: .color(renderPoint.color))
          }
        }.frame(width: CGFloat(canvasWidth), height: CGFloat(canvasHeight))
      }

    }.padding()
  }

  private func runSimulation() {
    renderPoints.removeAll()

    showProgress = true
    runRenderButtonDisabled = true
    showCanvas = true

    let rayOrigin = RTPoint(x: 0, y: 0, z: -5)
    let wallZ = 10
    let wallSize = 7.0
    let pixelSize = wallSize / Double(canvasWidth)

    let half = wallSize / 2
    let color = RTColor(red: 1, green: 0, blue: 0)
    let shape = Sphere()

    var points: [RenderPoint] = []
    let progressChunk = 1 / Double(canvasHeight)

    DispatchQueue.global(qos: .userInteractive).async {
      for y in 0..<canvasHeight {
        let worldY = half - pixelSize * Double(y)

        for x in 0..<canvasWidth {
          let worldX = -half + pixelSize * Double(x)

          let position = RTPoint(x: worldX, y: worldY, z: Double(wallZ))

          let ray = Ray(origin: rayOrigin, direction: (position - rayOrigin).norm())
          let xs = shape.intersect(ray)

          if hit(xs) != nil {
            let renderPoint = RenderPoint(point: CGPoint(x: x, y: y), color: Color(color))
            points.append(renderPoint)
          }
        }

        DispatchQueue.main.async {
          progress += progressChunk
        }
      }

      DispatchQueue.main.async {
        for point in points {
          renderPoints.append(point)
        }

        runRenderButtonDisabled = false
        showClearCanvas = true
        showProgress = false
        progress = 0.0
      }
    }
  }
}

#Preview {
  ContentView()
}
