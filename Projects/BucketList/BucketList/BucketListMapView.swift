//
//  BucketListMapView.swift
//  BucketList
//
//  Created by Geoffrie Maiden Mueller on 12/10/21.
//

import SwiftUI
import MapKit

struct BucketListMapView: View {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingPlaceDetails = false
    @State private var locations = [CodableMKPointAnnotation]()
    @State private var showingEditScreen = false
    
    var body: some View {
        MapView(centerCoordinate: self.$centerCoordinate, selectedPlace: self.$selectedPlace, showingPlaceDetails: self.$showingPlaceDetails, annotations: locations)
            .edgesIgnoringSafeArea(.all)
        Circle()
            .fill(Color.blue)
            .opacity(0.3)
            .frame(width: 32, height: 32)
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    let new_location = CodableMKPointAnnotation()
                    new_location.title = "Example Location"
                    new_location.coordinate = self.centerCoordinate
                    self.locations.append(new_location)
                    
                    self.selectedPlace = new_location
                    self.showingEditScreen = true
                }) {
                    Image(systemName: "plus")
                        .padding()
                        .background(Color.black.opacity(0.75))
                        .foregroundColor(.white)
                        .font(.title)
                        .clipShape(Circle())
                        .padding(.trailing)
                }
            }
        }
        .alert(isPresented: self.$showingPlaceDetails) {
            Alert(title: Text(selectedPlace?.title ?? "Unknown"), message: Text(selectedPlace?.subtitle ?? "Missing place information"), primaryButton: .default(Text("OK")), secondaryButton: .default(Text("Edit")) {
                    self.showingEditScreen = true
                }
            )
        }
        .sheet(isPresented: self.$showingEditScreen, onDismiss: self.saveData) {
            if self.selectedPlace != nil {
                EditView(placemark: self.selectedPlace!)
            }
        }
        .onAppear {
            self.loadData()
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadData() {
        let filename = self.getDocumentsDirectory().appendingPathComponent("SavedPlaces")
        do {
            let data = try Data(contentsOf: filename)
            self.locations = try JSONDecoder().decode([CodableMKPointAnnotation].self, from: data)
        } catch {
            print("Unable to load saved places")
        }
    }
    
    func saveData() {
        do {
            let filename = self.getDocumentsDirectory().appendingPathComponent("SavedPlaces")
            let data = try JSONEncoder().encode(self.locations)
            try data.write(to: filename, options: [.atomicWrite])
        } catch {
            print("Unable to save data")
        }
    }
    
}

struct BucketListMapView_Previews: PreviewProvider {
    static var previews: some View {
        BucketListMapView()
    }
}
