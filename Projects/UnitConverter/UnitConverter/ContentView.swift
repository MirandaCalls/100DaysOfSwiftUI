//
//  ContentView.swift
//  UnitConverter
//
//  Created by Geoffrie Maiden Mueller on 10/17/21.
//

import SwiftUI

struct ContentView: View {
    @State private var chosenConverter = 0
    
    let converters = ["Length", "Temperature"]
    let lengths = ["meters", "kilometers", "feet", "yards", "miles"]
    let temps = ["fahrenheit", "celcius", "kelvin"]
    
    let lengthDimensions: [Dimension] = [
        UnitLength.meters,
        UnitLength.kilometers,
        UnitLength.feet,
        UnitLength.yards,
        UnitLength.miles
    ]
    
    let tempDimensions: [Dimension] = [
        UnitTemperature.fahrenheit,
        UnitTemperature.celsius,
        UnitTemperature.kelvin
    ]
    
    var body: some View {
        VStack() {
            Text("Unit Converter Pro+")
                .font(.title)
            HStack {
                Text("Chosen Converter:")
                Picker("", selection: $chosenConverter) {
                    ForEach(0 ..< converters.count) {
                        Text("\(converters[$0])")
                    }
                }
            }
            if (chosenConverter == 0) {
                UnitConverter(plainTextUnits: lengths, dimensions: lengthDimensions)
            } else {
                UnitConverter(plainTextUnits: temps, dimensions: tempDimensions)
            }
        }
        .frame(minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        .padding(10)
    }
}

struct UnitConverter: View {
    @State private var inputUnit = 0
    @State private var outputUnit = 0
    @State private var userInput = "0"
    
    let plainTextUnits: [String]
    let dimensions: [Dimension]
    
    init(plainTextUnits: [String], dimensions: [Dimension]) {
        self.plainTextUnits = plainTextUnits
        self.dimensions = dimensions
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Input")
                    .frame(maxWidth: .infinity, maxHeight: 20)
                Text("Output")
                    .frame(maxWidth: .infinity, maxHeight: 20)
            }
            .padding(5)
            .overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(Color.gray), alignment: .bottom)
            
            HStack {
                TextField("Input", text: $userInput)
                    .keyboardType(.decimalPad)
                    .frame(width: 150, height: 25, alignment: .center)
                    .textFieldStyle(.roundedBorder)
                Text("=")
                Text("\(runUnitConversion(), specifier: "%G")")
                    .frame(width: 150, height: 25, alignment: .center)
            }
            .padding(10)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0)
            .overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(Color.gray), alignment: .bottom)
            
            HStack {
                Picker("", selection: $inputUnit) {
                    ForEach(0 ..< plainTextUnits.count) {
                        Text("\(plainTextUnits[$0])")
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 30)
                Picker("", selection: $outputUnit) {
                    ForEach(0 ..< plainTextUnits.count) {
                        Text("\(plainTextUnits[$0])")
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 30)
            }
        }
    }
    
    func runUnitConversion() -> Double {
        let input_dimension = dimensions[inputUnit]
        let output_dimension = dimensions[outputUnit]
        let input = Double(userInput) ?? 0
        
        let measurement = Measurement(value: input, unit: input_dimension)
        return measurement.converted(to: output_dimension).value
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
