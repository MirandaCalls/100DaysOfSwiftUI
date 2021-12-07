/**
 * Day 69
 * MapKit and Biometric Authentication
 **/

import SwiftUI
import LocalAuthentication
import MapKit

// UIViewRepresentable is a Protocol that allow you to display a UIKit view inside a SwiftUI view.
struct MapView: UIViewRepresentable {
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            print(mapView.centerCoordinate)
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            // Customizes how pinned locations on the map are displayed
            let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            view.canShowCallout = true
            return view
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let map_view = MKMapView()
        map_view.delegate = context.coordinator
        
        // Point of interest that you want to callout on the map
        let annotation = MKPointAnnotation()
        annotation.title = "Your Name stairs"
        annotation.subtitle = "Location where Mitsuha and Taki meet at the end of the film."
        annotation.coordinate = CLLocationCoordinate2D(latitude: 35.6851235, longitude: 139.7225555)
        map_view.addAnnotation(annotation)
        
        return map_view
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        
    }
}


struct BiometricAuthDemo: View {
    @State private var isUnlocked = false
    
    var body: some View {
        VStack {
            if self.isUnlocked {
                Text("Unlocked")
            } else {
                Text("Locked")
            }
        }
        .onAppear {
            self.authenticate()
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // Face ID reason must be specified in your Info.plist file
            let reason = "We need to unlock your data."
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        // Face or fingerprint match failed
                    }
                }
            }
        } else {
            // No biometric authentication available
            // Probably switch to using some kind of passcode
        }
    }
}