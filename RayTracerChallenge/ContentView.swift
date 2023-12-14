//
//  ContentView.swift
//  RayTracerChallenge
//
//  Created by Anna Melnikov on 12/12/23.
//

import SwiftUI

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

  @State private var numTicks = "0"

  @State private var showTicks = false

  @State private var runSimulationButtonDisabled = false

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

      if showTicks {
        HStack {
          Text("Ticks taken to hit the ground")
          Text(numTicks)
        }
      }
    }.padding()
  }

  private func runSimulation() {
    self.runSimulationButtonDisabled = true
    self.showTicks = true

    let position = RTPoint(
      x: Double(self.position_x)!,
      y: Double(self.position_y)!,
      z: Double(self.position_z)!
    )

    let velocity = RTVector(
      x: Double(self.velocity_x)!,
      y: Double(self.velocity_y)!,
      z: Double(self.velocity_z)!
    )

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

        DispatchQueue.main.async {
          self.numTicks = String(ticksToGround)
        }
      }

    }

    runSimulationButtonDisabled = false
  }
}

#Preview {
  ContentView()
}
