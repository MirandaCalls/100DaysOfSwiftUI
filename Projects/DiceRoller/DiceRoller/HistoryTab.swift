//
//  ResultsTab.swift
//  DiceRoller
//
//  Created by Geoffrie Maiden Mueller on 1/1/22.
//

import SwiftUI

struct History: View {
    @FetchRequest(entity: RollResult.entity(), sortDescriptors: [
        NSSortDescriptor(key: "rolledAt", ascending: false)
    ])
    var results: FetchedResults<RollResult>
    
    var body: some View {
        NavigationView {
            List(self.results) { result in
                VStack(alignment: .leading) {
                    Text(result.rolledAtFormatted)
                    
                    HStack(spacing: 10) {
                        ForEach(0..<result.valuesArray.count, id: \.self) { index in
                            Image(systemName: "die.face.\(result.valuesArray[index])")
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                    }
                }
            }
            .navigationBarTitle("History")
        }
    }
}
