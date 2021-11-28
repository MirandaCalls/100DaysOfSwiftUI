//
//  Networking.swift
//  SwiftWithFriends
//
//  Created by Geoffrie Maiden Mueller on 11/27/21.
//

import Foundation

struct Networking {
    
    static func loadClassmates(completionHandler: @escaping ([ClassMember]) -> Void) {
        let url = URL(string: "http://localhost/SwiftWithFriendsApi/index.php/classmates")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            let decoder = JSONDecoder()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            decoder.dateDecodingStrategy = .formatted(formatter)
            
            if let decoded = try? decoder.decode([ClassMember].self, from: data) {
                completionHandler(decoded)
            } else {
                print("Invalid response from server")
            }
        }.resume()
    }
    
}
