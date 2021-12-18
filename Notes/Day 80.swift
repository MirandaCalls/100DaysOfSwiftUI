/**
 * Day 80
 * Result, publishing ObservableObject changes, Image interpolation
 */

import SwiftUI

enum NetworkError: Error {
    case badURL, requestFailed, unknown
}

struct ResultDemo: View {
    var body: some View {
        Text("Hello, world!")
            .onAppear {
                self.fetchData(from: "https://www.apple.com") { result in
                	// Since our closure parameter type is Result, we can always expect to get back either Result.success or Result.failure
                	// Rather than having to deal with a bunch of URLSession error/response handling in our higher level code
                    switch result {
                    case .success(let str):
                        print(str)
                    case .failure(let error):
                        switch error {
                        case .badURL:
                            print("Bad URL")
                        case .requestFailed:
                            print("Network problems")
                        case .unknown:
                            print("Unknown error")
                        }
                    }
                }
            }
    }
    
    // @escaping is needed when a closure won't be run right away
    // It tells Swift to keep required data in memory for later use
    func fetchData(from urlString: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
    	/**
    	 * Result<...,...> is a generic type that lets you set what type .success will contain
    	 * and what type .failure will contain.
    	 * 
    	 * In this case our string is an http response string and the failure is an enum value.
    	 **/

        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    let stringData = String(decoding: data, as: UTF8.self)
                    completion(.success(stringData))
                } else if error != nil {
                    completion(.failure(.requestFailed))
                } else {
                    completion(.failure(.unknown))
                }
            }
        }.resume()
    }
}

class DelayedUpdater: ObservableObject {
    var value = 0 {
        willSet {
        	// objectWillChange is a property given to objects conforming to the ObservableObject protocol
        	// @Published properties use this to notify views that data needs to be re-rendered

        	// We can use it to manually publish changes ourselves, if we want more control over what
        	// a published property will do
            objectWillChange.send()
        }
    }
    
    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
            	// Schedules an event to be run every second that adds one to self.value
                self.value += 1
            }
        }
    }
}

struct ManuallyPublishingObjectUpdatesDemo: View {
    @ObservedObject var updater = DelayedUpdater()
    
    var body: some View {
    	// Displayed view will count from 1 to 10
        Text("Value is \(updater.value)")
    }
}

struct ImageInterpolationDemo: View {
    var body: some View {
        Image("ExampleAlien")
        	// .interpolation modifier gives us more control over how SwiftUI renders images
        	// SwiftUI applies blending to images as they get larger to hide the fact they've been stretched
        	// But sometimes the blending is very noticable and we want to get rid of it
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .frame(maxHeight: .infinity)
            .background(.black)
            .edgesIgnoringSafeArea(.all)
    }
}
