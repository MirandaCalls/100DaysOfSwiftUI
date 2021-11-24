//
//  DetailView.swift
//  Bookworm
//
//  Created by Geoffrie Maiden Mueller on 11/22/21.
//

import SwiftUI
import CoreData

struct DetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showingDeleteAlert = false
    
    let book: Book
    var formattedDateAdded: String {
        let date = self.book.dateAdded ?? Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    Image(self.book.genre ?? "Fantasy")
                        .frame(maxWidth: geo.size.width)
                    
                    Text(self.book.genre?.uppercased() ?? "FANTASY")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }
                
                Text("WRITTEN BY")
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding([.top])
                Text(self.book.author ?? "Unknown author")
                    .font(.title)
                    .foregroundColor(.secondary)
                
                RatingView(rating: .constant(Int(self.book.rating)))
                    .font(.largeTitle)
                    .padding(EdgeInsets(top: 2, leading: 0, bottom: 0, trailing: 0))
                
                VStack(alignment: .leading) {
                    Divider()
                    Text("ADDED ON")
                        .font(.caption)
                        .fontWeight(.bold)
                    Text(self.formattedDateAdded)
                        .padding(EdgeInsets(top: 2, leading: 0, bottom: 0, trailing: 0))
                    
                    Divider()
                    Text("REVIEW")
                        .font(.caption)
                        .fontWeight(.bold)
                    if self.book.review == nil {
                        HStack {
                            Spacer()
                            Text("No review")
                            Spacer()
                        }
                        .padding(EdgeInsets(top: 2, leading: 0, bottom: 0, trailing: 0))
                    } else {
                        Text(self.book.review!)
                            .padding(EdgeInsets(top: 2, leading: 0, bottom: 0, trailing: 0))
                    }
                    
                }
                .padding()
                
                Spacer()
            }
        }
        .navigationBarTitle(self.book.title ?? "Unknown book", displayMode: .inline)
        .alert(isPresented: $showingDeleteAlert) {
            Alert(title: Text("Delete book"), message: Text("Are you sure?"), primaryButton: .destructive(Text("Delete")) {
                self.deleteBook()
            }, secondaryButton: .cancel())
        }
        .navigationBarItems(trailing: Button(action: {
            self.showingDeleteAlert = true
        }) {
            Image(systemName: "trash")
        })
    }
    
    func deleteBook() {
        self.moc.delete(self.book)
        try? self.moc.save()
        presentationMode.wrappedValue.dismiss()
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Fullmetal Alchemist vol. 1"
        book.author = "Hiromu Arakawa"
        book.genre = "Fantasy"
        book.rating = 5
        book.review = "10/10 would read again"
        
        return NavigationView {
            DetailView(book: book)
        }
    }
}
