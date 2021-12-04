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
    
    @State private var showingFilterSheet = false
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
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
                        self.showingFilterSheet = true
                    }
                    
                    Spacer()
                    
                    Button("Save") {
                        guard let processedImage = self.processedImage else { return }
                        
                        let saver = ImageSaver()
                        saver.successHandler = {
                            print("Success!")
                        }
                        saver.errorHandler = {
                            print("Error: \($0.localizedDescription)")
                        }
                        
                        saver.writeToPhotoAlbum(image: processedImage)
                    }
                }
            }
            .padding([.horizontal, .vertical])
            .navigationBarTitle("Instafilter")
            .sheet(isPresented: self.$showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
            .actionSheet(isPresented: self.$showingFilterSheet) {
                ActionSheet(title: Text("Select a filter"), buttons: [
                    .default(Text("Crystallize")) { self.setFilter(CIFilter.crystallize()) },
                    .default(Text("Edges")) { self.setFilter(CIFilter.edges()) },
                    .default(Text("Gaussian Blur")) { self.setFilter(CIFilter.gaussianBlur()) },
                    .default(Text("Pixellate")) { self.setFilter(CIFilter.pixellate()) },
                    .default(Text("Sepia Tone")) { self.setFilter(CIFilter.sepiaTone()) },
                    .default(Text("Unsharp Mask")) { self.setFilter(CIFilter.unsharpMask()) },
                    .default(Text("Vignette")) { self.setFilter(CIFilter.vignette()) },
                    .cancel()
                ])
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
        let input_keys = self.currentFilter.inputKeys
        if input_keys.contains(kCIInputIntensityKey) {
            self.currentFilter.setValue(self.filterIntensity, forKey: kCIInputIntensityKey)
        }
        if input_keys.contains(kCIInputRadiusKey) {
            self.currentFilter.setValue(self.filterIntensity * 200, forKey: kCIInputRadiusKey)
        }
        if input_keys.contains(kCIInputScaleKey) {
            self.currentFilter.setValue(self.filterIntensity * 10, forKey: kCIInputScaleKey)
        }
        
        guard let output_image = self.currentFilter.outputImage else { return }
        
        if let cg_image = context.createCGImage(output_image, from: output_image.extent) {
            let ui_image = UIImage(cgImage: cg_image)
            self.processedImage = ui_image
            self.image = Image(uiImage: ui_image)
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        self.currentFilter = filter
        self.loadImage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
