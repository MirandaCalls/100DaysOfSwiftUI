//
//  ContentView.swift
//  Instafilter
//
//  Created by Geoffrie Maiden Mueller on 11/29/21.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    @State private var currentFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    var body: some View {
        let intensity = Binding<Double> (
            get: {
                self.filterIntensity
            },
            set: {
                self.filterIntensity = $0
                self.applyProcessing()
            }
        )
        
        return NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                    
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(Color.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    self.showingImagePicker = true
                }
                
                HStack {
                    Text("Intensity")
                    Slider(value: intensity)
                }
                .padding(.vertical)
                
                HStack {
                    Button("Change Filter") {
                        // Change filter
                    }
                    
                    Spacer()
                    
                    Button("Save") {
                        // Save the picture
                    }
                }
            }
            .padding([.horizontal, .vertical])
            .navigationBarTitle("Instafilter")
            .sheet(isPresented: self.$showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
        }
    }
    
    func loadImage() {
        guard let input_image = self.inputImage else { return }
        
        let begin_image = CIImage(image: input_image)
        currentFilter.setValue(begin_image, forKey: kCIInputImageKey)
        self.applyProcessing()
    }
    
    func applyProcessing() {
        self.currentFilter.intensity = Float(self.filterIntensity)
        guard let output_image = self.currentFilter.outputImage else { return }
        
        if let cg_image = context.createCGImage(output_image, from: output_image.extent) {
            let ui_image = UIImage(cgImage: cg_image)
            self.image = Image(uiImage: ui_image)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
