////
////  Network.swift
////  AlbertsonCodingAssignment
////
////  Created by Samuel Adama on 1/25/23.
////
//
//import Foundation
//
//class Network {
//    static let shared = Network()
//    
//    func loadFacts(url: String? = nil, completion:@escaping (Result<Fact, Error>) -> ()) {
//        let urlString: String? = url ?? "https://meowfacts.herokuapp.com/?id=\(UUID().uuidString)"
//        
//        guard let urlString = urlString, let url = URL(string: urlString) else {
//            print("Invalid url...")
//            return
//        }
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            
//            if let error = error {
//                print("Request error: ", error)
//                completion(.failure(APIHandlerError.fetchError))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse else {
//                completion(.failure(APIHandlerError.httpError))
//                return
//            }
//            
//            if response.statusCode == 200 {
//                guard let data = data else { return }
//                DispatchQueue.main.async {
//                    do {
//                        let decodedFacts = try JSONDecoder().decode(Fact.self, from: data)
//                        completion(.success(decodedFacts))
//                    } catch let error {
//                        print("Error decoding: ", error)
//                        completion(.failure(APIHandlerError.decodeError))
//                    }
//                }
//            }
//        }
//        .resume()
//    }
//    
//    func getData(completion: @escaping (Result<[Photo], Error>) -> Void){
//        guard let photoURL = URL(string: photoURLString) else {
//            print("Failed to get URL from URLString")
//            return
//        }
//        URLSession.shared.dataTask(with: photoURL) { data, response, error in
//            if let error = error {
//                print("Failed to fetch: \(error)")
//                completion(.failure(APIHandlerError.fetchError))
//            }
//            
//            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
//                print("HTTP Error")
//                completion(.failure(APIHandlerError.httpError))
//                return
//            }
//            
//            if let data = data {
//                let jsonDecoder = JSONDecoder()
//                do {
//                    let photos = try jsonDecoder.decode([Photo].self, from: data)
//                    completion(.success(photos))
//                }
//                catch {
//                    print("Decoding error \(error)")
//                    completion(.failure(APIHandlerError.decodeError))
//                }
//                
//            }
//        }.resume()
//    }
//}
//
//enum APIHandlerError: Error {
//    case fetchError, decodeError, httpError
//}
