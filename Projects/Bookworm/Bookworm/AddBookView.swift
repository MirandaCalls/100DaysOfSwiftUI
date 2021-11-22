//
//  AddBookView.swift
//  Bookworm
//
//  Created by Geoffrie Maiden Mueller on 11/21/21.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    RatingView(rating: $rating)
                    TextField("Write a review", text: $review)
                }
                
                Section {
                    Button("Save", action: self.saveBook)
                }
            }
            .navigationBarTitle("Add Book")
        }
    }
    
    func saveBook() {
        let new_book = Book(context: self.moc)
        new_book.title = self.title
        new_book.author = self.author
        new_book.rating = Int16(self.rating)
        new_book.genre = self.genre
        new_book.review = self.review
        
        try? self.moc.save()
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
