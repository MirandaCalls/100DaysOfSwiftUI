/**
 * Day 63
 * Core Image and Wrapping View controllers
 */

import PlaygroundSupport
import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct CoreImageFiltersDemo: View {
    @State private var image: Image?
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: self.loadImage)
    }
    
    func loadImage() {
        guard let input_image = UIImage(named: "Cat.jpg") else {
            return
        }
        
        let begin_image = CIImage(image: input_image)
        let context = CIContext()

        let current_filter = CIFilter.pixellate()
        current_filter.inputImage = begin_image
        current_filter.scale = 150
        
        guard let output_image = current_filter.outputImage else {
            return
        }
        
        if let cgimg = context.createCGImage(output_image, from: output_image.extent) {
            let uiimg = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiimg)
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

// This one won't work in a playground
struct WrappingViewControllerDemo: View {
    @State private var image: Image?
    @State private var showingImage = false
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()

            Button("Select Image") {
                self.showingImage = true
            }
        }
        .sheet(isPresented: $showingImage) {
            ImagePicker()
        }
    }
}

PlaygroundPage.current.setLiveView(CoreImageFiltersDemo())
