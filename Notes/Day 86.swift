/**
 * Day 86
 * Advanced Gestures, Haptics, Hit Testing
 **/

import SwiftUI
import CoreHaptics

struct AdvancedGesturesDemo: View {
    @State private var currentAmount: CGFloat = 0
    @State private var finalAmount: CGFloat = 1
    
    @State private var offset = CGSize.zero
    @State private var isDragging = false
    
    var body: some View {
        VStack {
            Text("Long Press")
                .onLongPressGesture(minimumDuration: 1, pressing: { inProgress in
                    // Closure run when the gesture is started and when the user stops
                    print("In progress: \(inProgress)")
                }) {
                    // Run when minimum duration condition is met
                    print("Long pressed!")
                }
            
            Text("Magnify")
                .scaleEffect(finalAmount + currentAmount)
                .gesture (
                    MagnificationGesture()
                        .onChanged { amount in
                            self.currentAmount = amount - 1
                        }
                        .onEnded { amount in
                            self.finalAmount += self.currentAmount
                            self.currentAmount = 0
                        }
                )
            
            VStack {
                Text("Child gesture")
                    // Child gestures will get initial priority
                    .onTapGesture {
                        print("Child tapped!")
                    }
            }
            // High priority does as the name says, runs this gesture instead
            // of any competing child gestures
            // Use simultaneousGesture if you want both gestures to run
            .highPriorityGesture (
                TapGesture()
                    .onEnded { _ in
                        print("Parent tapped!")
                    }
            )
            
            let dragGesture = DragGesture()
                .onChanged { value in
                    self.offset = value.translation
                }
                .onEnded { _ in
                    withAnimation {
                        self.offset = .zero
                        self.isDragging = false
                    }
                }
            
            let pressGesture = LongPressGesture()
                .onEnded { value in
                    withAnimation {
                        self.isDragging = true
                    }
                }
            
            // pressGesture must be triggered before dragGesture can start to be triggered
            let combined = pressGesture.sequenced(before: dragGesture)
            
            Circle()
                .fill(Color.red)
                .frame(width: 64, height: 64)
                .scaleEffect(isDragging ? 1.5 : 1)
                .offset(offset)
                .gesture(combined)
        }
    }
}

struct HapticsDemo: View {
    @State private var engine: CHHapticEngine?
    
    var body: some View {
        Text("Simple Vibrate")
            .onTapGesture {
                self.simpleSuccess()
            }
        
        Text("Complex Haptic")
            .onAppear(perform: self.prepareHaptics)
            .onTapGesture(perform: self.complexSuccess)
    }
    
    func simpleSuccess() {
        // Easy, built-in success and failure haptics
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func prepareHaptics() {
        // The CoreHaptics engine needs to be set up before triggering any vibrations
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            self.engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func complexSuccess() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        var events = [CHHapticEvent]()
        // Create series of haptic events to make custom vibrations
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }
        
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
            events.append(event)
        }
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription)")
        }
    }
}

struct HitTestingDemo: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.blue)
                .frame(width: 300, height: 300)
                .onTapGesture {
                    print("Rectangle tapped!")
                }
            
            Circle()
                .fill(Color.red)
                .frame(width: 300, height: 300)
                // Makes the interactive portion a rectangle to use the full frame
                .contentShape(Rectangle())
                .onTapGesture {
                    print("Circle tapped!")
                }
                //Disables user interactivity with the circle element
                //.allowsHitTesting(false)
        }
    }
}

