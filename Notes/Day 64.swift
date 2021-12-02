/**
 * Day 64
 * Coordinators -> Connecting SwiftUI to UIKit
 */

import PlaygroundSupport
import SwiftUI

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        // Older style callback
        // Uses "self", a pointer to an object and "#selector" to run a function when the save completes
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }
    
    // @objc Tells Swift this should be compiled to run in the Objective C layer
    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
}

// UIViewControllerRepresentable is a special interfact to allow you to wrap UIKit
// code as a SwiftUI view
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    /**
     * Coordinators are special "delegates" that are used to pass events from the
     * UIKit layer to the SwiftUI layer.
     */
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                self.parent.image = uiImage
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    // Runs automatically when the view is initialized
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        // Attach the coordinator to the controller
        // Controller will use this coordinator to send events for the coordinator to handle
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

struct CoordinatorsDemo: View {
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()

            Button("Select Image") {
                self.showingImagePicker = true
            }
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: self.loadImage) {
            // None of the UIKit complexity is exposed within our nice Swift UI view
            ImagePicker(image: self.$inputImage)
        }
    }
    
    func loadImage() {
        guard let inputImage = self.inputImage else {
            return
        }

        self.image = Image(uiImage: inputImage)
        
        let image_saver = ImageSaver()
        image_saver.writeToPhotoAlbum(image: inputImage)
    }
}

PlaygroundPage.current.setLiveView(CoordinatorsDemo())
