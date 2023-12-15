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
  @State private var position_x = "0"
  @State private var position_y = "1"
  @State private var position_z = "0"

  @State private var velocity_x = "1"
  @State private var velocity_y = "1"
  @State private var velocity_z = "0"

  @State private var gravity_x = "0"
  @State private var gravity_y = "-0.1"
  @State private var gravity_z = "0"

  @State private var wind_x = "-0.01"
  @State private var wind_y = "0"
  @State private var wind_z = "0"

  @State private var runSimulationButtonDisabled = false

  @State private var showCanvas = false

  @State private var renderPoints: [RenderPoint] = []

  private let canvasWidth = 900
  private let canvasHeight = 550

  var body: some View {
    VStack {
      HStack {
        Text("Projectile")
          .padding()

        VStack {
          TextField("Position x", text: $position_x)
          TextField("Position y", text: $position_y)
          TextField("Position z", text: $position_z)
        }.padding()

        VStack {
          TextField("Velocity x", text: $velocity_x)
          TextField(
            "Velocity y",
            text: $velocity_y)
          TextField(
            "Velocity z",
            text: $velocity_z)
        }.padding()
      }

      HStack {
        Text("Environment").padding()

        VStack {
          TextField("Gravity x", text: $gravity_x)
          TextField(
            "Gravity y",
            text: $gravity_y)
          TextField(
            "Gravity z",
            text: $gravity_z)
        }.padding()

        VStack {
          TextField("Wind x", text: $wind_x)
          TextField("Wind y", text: $wind_y)
          TextField("Wind z", text: $wind_z)

        }.padding()
      }

      Button("Run simulation", action: runSimulation).keyboardShortcut( /*@START_MENU_TOKEN@*/
        .defaultAction /*@END_MENU_TOKEN@*/
      ).disabled(runSimulationButtonDisabled)

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
    self.renderPoints.removeAll()
    self.runSimulationButtonDisabled = true
    self.showCanvas = true

    let position = RTPoint(
      x: Double(self.position_x)!,
      y: Double(self.position_y)!,
      z: Double(self.position_z)!
    )

    let velocity =
      RTVector(
        x: Double(self.velocity_x)!,
        y: Double(self.velocity_y)!,
        z: Double(self.velocity_z)!
      ).norm() * 11.25

    let gravity = RTVector(
      x: Double(self.gravity_x)!,
      y: Double(self.gravity_y)!,
      z: Double(self.gravity_z)!
    )

    let wind = RTVector(
      x: Double(self.wind_x)!,
      y: Double(self.wind_y)!,
      z: Double(self.wind_z)!
    )

    var ticksToGround = 0
    var projectile = Projectile(position: position, velocity: velocity)
    let environment = Environment(gravity: gravity, wind: wind)

    DispatchQueue.global(qos: .userInteractive).async {
      while projectile.position.y > 0 {
        projectile = environment.tick(projectile: projectile)
        ticksToGround += 1

        let point = CGPoint(
          x: projectile.position.x, y: Double(canvasHeight) - projectile.position.y)
        let color = Color.red
        let renderPoint = RenderPoint(point: point, color: color)

        DispatchQueue.main.async {
          renderPoints.append(renderPoint)
        }
      }

    }

    runSimulationButtonDisabled = false
  }
}

#Preview {
  ContentView()
}
