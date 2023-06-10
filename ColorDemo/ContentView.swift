//
//  ContentView.swift
//  ColorDemo
//
//  Created by Chris Davis on 09/06/2023.
//

import OSLog
import SwiftUI

struct ContentView {

    let logger = Logger()

    @State var rSlider: Float = 0
    @State var gSlider: Float = 0
    @State var bSlider: Float = 0

    @State var colorShader: Bool = true
    @State var layerShader: Bool = false
    @State var distortShader: Bool = false
}


extension ContentView: View {

    func getColorShader(r: Float, g: Float, b: Float) -> Shader {
        let f = ShaderFunction(library: .default,
                               name: "colorEffect")

        let image = Image(.chrisDavis)
        let imageArg = Shader.Argument.image(image)

        var shader = Shader(function: f, arguments: [.float(r),
                                                     .float(g),
                                                     .float(b),
                                                     imageArg])
        shader.dithersColor = true

        logger.info("shader values: \(r) \(g) \(b)")

        return shader
    }

    func getDistortShader(r: Float, g: Float, b: Float) -> Shader {
        let f = ShaderFunction(library: .default,
                               name: "distortEffect")

        let shader = Shader(function: f, arguments: [.float(r),
                                                     .float(g),
                                                     .float(b)])

        return shader
    }

    func getLayerShader(r: Float, g: Float, b: Float) -> Shader {
        let f = ShaderFunction(library: .default,
                               name: "layerEffect")

        let shader = Shader(function: f, arguments: [.float(r),
                                                     .float(g),
                                                     .float(b)])

        return shader
    }

    var body: some View {
        VStack {
            Image("ChrisDavis")
                .frame(width: 300, height: 300)
                .foregroundStyle(.tint)
                .colorEffect(getColorShader(r: rSlider, g: gSlider, b: bSlider), isEnabled: colorShader)
                .layerEffect(getLayerShader(r: rSlider, g: gSlider, b: bSlider), maxSampleOffset: .init(width: 100, height: 100), isEnabled: layerShader)
                .distortionEffect(getDistortShader(r: rSlider, g: gSlider, b: bSlider), maxSampleOffset: .init(width: 100, height: 100), isEnabled: distortShader)

            Text("Chris Davis")

            Slider(value: $rSlider, in: -5...5)
            Slider(value: $gSlider, in: -5...5)
            Slider(value: $bSlider, in: -5...5)

            Toggle(isOn: $colorShader, label: {
                Text("Color Shader")
            })
            Toggle(isOn: $layerShader, label: {
                Text("Layer Shader")
            })
            Toggle(isOn: $distortShader, label: {
                Text("Distort Shader")
            })
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
