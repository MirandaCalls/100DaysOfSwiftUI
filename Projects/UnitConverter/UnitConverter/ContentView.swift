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
        ZStack {
            Color(UIColor.black)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Text("Unit Converter Pro+")
                        .foregroundColor(Color.white)
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }
                
                HStack {
                    Text("Chosen Converter:")
                    Picker("", selection: $chosenConverter) {
                        ForEach(0 ..< converters.count) {
                            Text("\(converters[$0])")
                        }
                    }
                    Spacer()
                }
                .padding(10)
                .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                
                if (chosenConverter == 0) {
                    UnitConverter(plainTextUnits: lengths, dimensions: lengthDimensions)
                } else {
                    UnitConverter(plainTextUnits: temps, dimensions: tempDimensions)
                }
                Spacer()
            }
            .padding(10)
        }
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
                    .frame(maxWidth: .infinity)
                Text("Output")
                    .frame(maxWidth: .infinity)
            }
            .padding(10)
            .overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(Color.gray), alignment: .bottom)
            
            HStack {
                TextField("Input", text: $userInput)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: .infinity)
                Text("=")
                Text("\(runUnitConversion(), specifier: "%G")")
                    .frame(maxWidth: .infinity)
            }
            .padding(10)
            .overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(Color.gray), alignment: .bottom)
            
            HStack {
                Picker("", selection: $inputUnit) {
                    ForEach(0 ..< plainTextUnits.count) {
                        Text("\(plainTextUnits[$0])")
                    }
                }
                .frame(maxWidth: .infinity)
                Picker("", selection: $outputUnit) {
                    ForEach(0 ..< plainTextUnits.count) {
                        Text("\(plainTextUnits[$0])")
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
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
