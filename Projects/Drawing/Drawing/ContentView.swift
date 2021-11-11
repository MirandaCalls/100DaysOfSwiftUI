//
//  ContentView.swift
//  Drawing
//
//  Created by Geoffrie Maiden Mueller on 11/10/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack() {
            // TriangleRawPath()
            // TriangleShape()
            // InsettableArc()
            PercentageProgress()
            Spacer()
        }
    }
}

struct TriangleRawPath: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 200, y: 100))
            path.addLine(to: CGPoint(x: 100, y: 300))
            path.addLine(to: CGPoint(x: 300, y: 300))
            path.addLine(to: CGPoint(x: 200, y: 100))
        }
        .stroke(Color.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

struct TriangleShape: View {
    var body: some View {
        Triangle()
            .fill(Color.red)
            .frame(width: 300, height: 300)
    }
}

struct Arc: Shape, InsettableShape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    var insetAmount: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        let angle_adjustment = Angle.degrees(90)
        let modified_start = startAngle - angle_adjustment
        let modified_end = endAngle - angle_adjustment
        
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modified_start, endAngle: modified_end, clockwise: !clockwise)
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct InsettableArc: View {
    var body: some View {
        Arc(startAngle: .degrees(-90), endAngle: .degrees(90), clockwise: true)
            .strokeBorder(Color.blue, lineWidth: 40)
    }
}

struct PercentageProgress: View {
    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(Color.blue.opacity(0.5), lineWidth: 20)
            Arc(startAngle: .degrees(0), endAngle: .degrees(270), clockwise: true)
                .strokeBorder(Color.blue, style: StrokeStyle(lineWidth: 20, lineCap: .round))
            Text("75%")
                .font(.system(size: 60))
                .bold()
        }
        .frame(width: 300, height: 300)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
