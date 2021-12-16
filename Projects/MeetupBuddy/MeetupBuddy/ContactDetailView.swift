//
//  ContactDetailView.swift
//  MeetupBuddy
//
//  Created by Geoffrie Maiden Mueller on 12/15/21.
//

import SwiftUI
import CoreData
import CoreLocation
import MapKit

struct ContactDetailView: View {
    var contact: Contact
    
    var locationPin: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.coordinate = self.contact.contactLocation
        return annotation
    }
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                AsyncImage(url: self.contact.imageUrl) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: geo.size.width)
                .padding(.bottom)
                
                if self.contact.savedLocation {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "location.fill")
                            Text("Meetup Location")
                        }

                        MapView(centerCoordinate: .constant(self.contact.contactLocation), selectedPlace: .constant(nil), showingPlaceDetails: .constant(false), annotations: [self.locationPin])
                            .frame(height: 300)
                            .cornerRadius(10)
                            .disabled(true)
                    }
                    .padding(.horizontal)

                } else {
                    HStack {
                        Image(systemName: "location.fill")
                        Text("No meetup location saved.")
                    }
                }
                
                Spacer()
            }

        }
        .navigationBarTitle("\(self.contact.wrappedName)", displayMode: .inline)
    }
}

struct ContactDetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let contact = Contact(context: moc)
        contact.name = "Test"
        contact.savedLocation = true
        
        return NavigationView {
            ContactDetailView(contact: contact)
        }
    }
}
