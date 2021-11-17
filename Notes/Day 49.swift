/**
 * Day 49
 * Custom codable structs, loading web data, disabling form elements
 */

import SwiftUI
import PlaygroundSupport

// Due to the @Published property to name, we need to tell Swift how to decode and encode this class
class User: ObservableObject, Codable {
    enum CodingKeys: CodingKey {
        case name
    }
    
    @Published var name = "Geoffrie Alena"
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct URLRequestTaylorSwiftSongs: View {
    @State var results = [Result]()
    
    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
        .onAppear(perform: loadData)
    }
    
    func loadData() {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decoded_response = try? JSONDecoder().decode(Response.self, from: data) {
                    // This is very important
                    // The URLSession task runs on a background thread and we don't want the background thread to update data on the main thread
                    // Queue up a task for the main thread to update the view with our fresh data
                    DispatchQueue.main.async {
                        self.results = decoded_response.results
                    }
                    
                    return
                }
            }
            
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

struct FormDisabledDemo: View {
    @State private var username = ""
    @State private var email = ""
    
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            
            Section {
                Button("Create Account") {
                    print("Creating account...")
                }
                .disabled(disableForm) // Disable the button if the fields aren't filled out
            }
        }
    }
}

PlaygroundPage.current.setLiveView(FormDisabledDemo())
