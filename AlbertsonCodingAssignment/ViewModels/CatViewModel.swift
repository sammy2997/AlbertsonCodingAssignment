//
//  CatViewModel.swift
//  AlbertsonCodingAssignment
//
//  Created by Samuel Adama on 1/25/23.
//

import Foundation
import UIKit
//import SwiftUI

class CatViewModel: ObservableObject {
    
    // instead of Aync Image for pre ios15 support
    func downloadImage(url: String? = nil, completion:@escaping (UIImage) -> ()) {
        let catImageUrl = Constants.imageUrl.rawValue + "\(getRandomImageForHeight())"
        
        guard let url = URL(string: url ?? catImageUrl) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in

            guard let data = data, error == nil else {
                return
            }

            let image = UIImage(data: data)
            completion(image ?? UIImage())

        }.resume()
        
    }
    
    func getRandomImageForHeight() -> Int {
        let randomInt = Int.random(in: 300..<500)
        return randomInt
    }
    
    func loadFacts(url: String? = nil, completion:@escaping (Fact) -> ()) {
        let factsUrl = Constants.factsUrl.rawValue + UUID().uuidString
        let urlString: String? = url ?? factsUrl
        
        guard let urlString = urlString, let url = URL(string: urlString) else {
            print("Invalid url...")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print("Request error: ", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Response error: ", APIHandlerError.httpError)
                return
            }
            
            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decodedFacts = try JSONDecoder().decode(Fact.self, from: data)
                        completion(decodedFacts)
                    } catch _ {
                        print("Error decoding: ", APIHandlerError.decodeError)
                    }
                }
            }
        }
        .resume()
    }
}

enum APIHandlerError: Error {
    case fetchError, decodeError, httpError
}
