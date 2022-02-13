//
//  Networking.swift
//  SwiftWithFriends
//
//  Created by Geoffrie Maiden Mueller on 11/27/21.
//

import Foundation

struct Networking {
    static func loadClassmates(
        completionHandler: @escaping ([ClassMemberDto]) -> Void,
        errorHandler: @escaping () -> Void
    ) {
        let url = URL(string: "http://localhost:8080/api/classmates")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                errorHandler()
                return
            }
            
            let decoder = JSONDecoder()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            decoder.dateDecodingStrategy = .formatted(formatter)
            
            do {
                let decoded = try decoder.decode([ClassMemberDto].self, from: data)
                completionHandler(decoded)
            } catch {
                print("Decode error: \(error.localizedDescription)")
                errorHandler()
            }
        }.resume()
    }
}
