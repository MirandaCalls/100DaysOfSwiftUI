/**
 * Day 87
 * Timers, More Accessibility, Receiving System Notifications
 **/

import SwiftUI

struct TimerDemo: View {
    // Publishes an event every 1 second
    // Tolerance tells the system that about half a second early or late is okay
    // System does not make any guarantee that the event will be published on time, every time
    let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
    @State private var counter = 0
    
    var body: some View {
        Text("Hello, world!")
            .padding()
            // Receives the timer event and runs a closure every time
            .onReceive(timer) { time in
                if self.counter == 5 {
                    self.timer.upstream.connect().cancel()
                } else {
                    print("The time is now \(time)")
                }
                
                self.counter += 1
            }
    }
}

struct ReceivingSystemNotificationsDemo: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                print("Moving to the background!")
            }
            // UIApplication.willEnterForegroundNotification -> when app moves into the foreground
            // UIApplication.userDidTakeScreenshotNotification -> when user takes a screenshot
    }
}

struct AccessibilityDifferentiateWithoutColorDemo: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    
    var body: some View {
        HStack {
            if differentiateWithoutColor {
                Image(systemName: "checkmark.circle")
            }
            
            Text("Success")
        }
        .padding()
        // Useful when designing an app to use different color schemes for color blind people
        .background((self.differentiateWithoutColor ? Color.black : Color.green))
        .foregroundColor(Color.white)
        .clipShape(Capsule())
    }
}

func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
    if UIAccessibility.isReduceMotionEnabled {
    	// If reduce motion is enabled, run the closure without any animation
        return try body()
    } else {
        return try withAnimation(animation, body)
    }
}

struct AccessibilityReduceAnimationDemo: View {
    @State private var scale: CGFloat = 1
    
    var body: some View {
        Text("Hello world!")
            .scaleEffect(scale)
            .onTapGesture {
                withOptionalAnimation {
                    self.scale *= 1.5
                }
            }
    }
}