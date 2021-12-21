//
//  MeView.swift
//  HotProspects
//
//  Created by Geoffrie Maiden Mueller on 12/19/21.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct MeView: View {
    @State private var name = "Anonymous"
    @State private var emailAddress = "you@yoursite.com"
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationView {
            Form {
                Image(uiImage: self.generateQRCode(from: "\(self.name)\n\(self.emailAddress)"))
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                
                Section(header: Text("Your Details")) {
                    TextField("Name", text: self.$name)
                        .textContentType(.name)
                        .font(.title)
                    TextField("Email Address", text: self.$emailAddress)
                        .textContentType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .font(.title)
                }
                
            }
            .navigationBarTitle("Your Code")
        }
    }
    
    func generateQRCode(from string: String) -> UIImage {
        let data = Data(string.utf8)
        self.filter.setValue(data, forKey: "inputMessage")
        
        if let output_image = filter.outputImage {
            if let cgimg = context.createCGImage(output_image, from: output_image.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
