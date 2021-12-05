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
    
    @State private var displayFilterIntensity = false
    @State private var filterIntensity = 0.5
    @State private var displayFilterRadius = false
    @State private var filterRadius = 200.0
    @State private var displayFilterScale = false
    @State private var filterScale = 40.0
    
    @State private var showingFilterSheet = false
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    
    @State private var changeFilterTitle = "Sepia Tone"
    @State private var alertDisplayedNoImage = false
    
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
        
        let radius = Binding<Double> (
            get: {
                self.filterRadius
            },
            set: {
                self.filterRadius = $0
                self.applyProcessing()
            }
        )
        
        let scale = Binding<Double> (
            get: {
                self.filterScale
            },
            set: {
                self.filterScale = $0
                self.applyProcessing()
            }
        )
        
        return NavigationView {
            ScrollView(.vertical) {
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
                .frame(height: 550)
                .onTapGesture {
                    self.showingImagePicker = true
                }
                
                if self.displayFilterIntensity {
                    HStack {
                        Text("Intensity")
                        Slider(value: intensity)
                    }
                    .padding([.vertical], 5)
                }
                
                if self.displayFilterRadius {
                    HStack {
                        Text("Radius")
                        Slider(value: radius, in: 10...200, step: 10)
                    }
                    .padding([.vertical], 5)
                }
                
                if self.displayFilterScale {
                    HStack {
                        Text("Scale")
                        Slider(value: scale, in: 10...200, step: 10)
                    }
                    .padding([.vertical], 5)
                }
            }
            .padding(.horizontal)
            .navigationBarTitle("Instafilter")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button(self.changeFilterTitle) {
                        self.showingFilterSheet = true
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    Button("Save") {
                        guard let processedImage = self.processedImage else {
                            self.alertDisplayedNoImage = true
                            return
                        }
                        
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
            .sheet(isPresented: self.$showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
            .actionSheet(isPresented: self.$showingFilterSheet) {
                ActionSheet(title: Text("Select a filter"), buttons: [
                    .default(Text("Crystallize")) { self.setFilter(CIFilter.crystallize(), "Crystallize") },
                    .default(Text("Edges")) { self.setFilter(CIFilter.edges(), "Edges") },
                    .default(Text("Gaussian Blur")) { self.setFilter(CIFilter.gaussianBlur(), "Gaussian Blur") },
                    .default(Text("Pixellate")) { self.setFilter(CIFilter.pixellate(), "Pixellate") },
                    .default(Text("Sepia Tone")) { self.setFilter(CIFilter.sepiaTone(), "Sepia Tone") },
                    .default(Text("Unsharp Mask")) { self.setFilter(CIFilter.unsharpMask(), "Unsharp Mask") },
                    .default(Text("Vignette")) { self.setFilter(CIFilter.vignette(), "Vignette") },
                    .cancel()
                ])
            }
            .alert(isPresented: self.$alertDisplayedNoImage) {
                Alert(title: Text("No Image"), message: Text("Choose an image before saving."), dismissButton: .default(Text("OK")))
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
        
        self.displayFilterIntensity = false
        if input_keys.contains(kCIInputIntensityKey) {
            self.displayFilterIntensity = true
            self.currentFilter.setValue(self.filterIntensity, forKey: kCIInputIntensityKey)
        }
        self.displayFilterRadius = false
        if input_keys.contains(kCIInputRadiusKey) {
            self.displayFilterRadius = true
            self.currentFilter.setValue(self.filterRadius, forKey: kCIInputRadiusKey)
        }
        self.displayFilterScale = false
        if input_keys.contains(kCIInputScaleKey) {
            self.displayFilterScale = true
            self.currentFilter.setValue(self.filterScale, forKey: kCIInputScaleKey)
        }
        
        guard let output_image = self.currentFilter.outputImage else { return }
        
        if let cg_image = context.createCGImage(output_image, from: output_image.extent) {
            let ui_image = UIImage(cgImage: cg_image)
            self.processedImage = ui_image
            self.image = Image(uiImage: ui_image)
        }
    }
    
    func setFilter(_ filter: CIFilter, _ filterName: String) {
        self.changeFilterTitle = filterName
        self.currentFilter = filter
        self.loadImage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
