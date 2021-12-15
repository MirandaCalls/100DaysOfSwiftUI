//
//  ContactAddView.swift
//  MeetupBuddy
//
//  Created by Geoffrie Maiden Mueller on 12/14/21.
//

import SwiftUI
import CoreData

struct ContactAddView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    var saveDisabled: Bool {
        self.contactName == ""
    }
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var contactName = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    if self.inputImage != nil {
                        Image(uiImage: self.inputImage!)
                            .resizable()
                            .frame(width: 200, height: 200)
                            .clipShape(Circle())
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                    } else {
                        Text("Select Image")
                            .frame(width: 200, height: 200)
                            .background(Color(red: 191 / 255, green: 191 / 255, blue: 191 / 255))
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                            .onTapGesture {
                                self.showingImagePicker = true
                            }
                    }
                    
                    TextField("Name", text: self.$contactName)
                }

                Button("Save") {
                    // Save the contact and dismiss the sheet
                    self.saveContact()
                }
                .disabled(self.saveDisabled)
            }
            .navigationBarTitle("Add New Contact")
            .sheet(isPresented: self.$showingImagePicker) {
                ImagePicker(image: self.$inputImage)
            }
        }
    }
    
    func saveContact() {
        guard let new_contact_image = self.inputImage else { return }
        
        let image_id = UUID().uuidString
        let new_image_url = FileManager.default.getDocumentsDirectory().appendingPathComponent(image_id)
        if let jpegData = new_contact_image.jpegData(compressionQuality: 0.8) {
            do {
                try jpegData.write(to: new_image_url, options: [.atomicWrite, .completeFileProtection])
            } catch {
                print("Failed to save new image")
                return
            }
        } else {
            print("Failed to save new image")
            return
        }
        
        let new_contact = Contact(context: self.moc)
        new_contact.name = self.contactName
        new_contact.imageName = image_id
        try? self.moc.save()
        
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct ContactAddView_Previews: PreviewProvider {
    static var previews: some View {
        ContactAddView()
    }
}
