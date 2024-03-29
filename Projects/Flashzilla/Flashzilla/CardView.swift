//
//  CardView.swift
//  Flashzilla
//
//  Created by Geoffrie Maiden Mueller on 12/25/21.
//

import SwiftUI

struct CardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    let card: Card
    var removal: ((Bool) -> Void)? = nil
    
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    @State private var feedback = UINotificationFeedbackGenerator()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    self.differentiateWithoutColor ? Color.white : Color.white
                        .opacity(1 - Double(abs(offset.width / 50)))
                )
                .background(
                    self.differentiateWithoutColor ? nil : 
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .answerColorShift(offset: self.offset)
                )
                .shadow(radius: 10)
            
            VStack {
                if self.accessibilityEnabled {
                    Text(self.isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                } else {
                    Text(self.card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                    
                    if self.isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .accessibility(addTraits: .isButton)
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 5, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    self.offset = gesture.translation
                    self.feedback.prepare()
                }
                .onEnded { _ in
                    if abs(self.offset.width) > 100 {
                        var success: Bool
                        if self.offset.width > 0 {
                            self.feedback.notificationOccurred(.success)
                            success = true
                        } else {
                            self.feedback.notificationOccurred(.error)
                            success = false
                        }
                        
                        self.removal?(success)
                    } else {
                        self.offset = .zero
                    }
                }
        )
        .onTapGesture {
            self.isShowingAnswer.toggle()
        }
        .animation(.spring())
    }
}

extension RoundedRectangle {
    func answerColorShift(offset: CGSize) -> some View {
        if offset.width > 0 {
            return AnyView(self.fill(Color.green))
        } else if offset.width < 0 {
            return AnyView(self.fill(Color.red))
        }
        
        return AnyView(self)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
    }
}
