//
//  APIService.swift
//  InterviewKOKOFriend
//
//  Created by allen on 2023/11/25.
//

import Foundation
import Combine

enum HTTPError: LocalizedError {
    case statusCode
}

let kokoFriendUrl1 = "https://dimanyen.github.io/friend1.json"
let kokoFriendUrl2 = "https://dimanyen.github.io/friend2.json"
let kokoFriendUrl3 = "https://dimanyen.github.io/friend3.json"


final class APIService{
    init() {}
    
    
    struct Contants{
        
        static let apiUrl = URL(string: kokoFriendUrl1)
    }
    
    var listings = KOKOFriend(response:[])
    
    func fetechListing() {
        getListings { result in
            switch result {
            case .success(let models):
                self.listings = models
            case .failure:
                break
            }
        }
    }
    
    public func getListings(completion:@escaping(Result<KOKOFriend,Error>) -> Void)
    {
        guard let url = Contants.apiUrl else { return }
        
        var res:KOKOFriend = KOKOFriend(response: [])
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data,_,error in
            
            guard let data else{
                if let error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
                return
            }
            
            
            
            do{
                let response = try JSONDecoder().decode(KOKOFriend.self, from: data)
                
                print("response \(response.response.count)")
                DispatchQueue.main.async {
                    res = response
                    completion(.success(response))
                }
     
            }catch{
                let json = try? JSONSerialization.jsonObject(with: data)
                print(String(describing: json))
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            
        }
        task.resume()
       
        
    }
    
    
}


//var cancellable: AnyCancellable?
//let apiClient = APIClient()
//var baseURL = URL(string: kokoFriendUrl1)!

//cancellable = apiClient.fetchData(KOKOFriend.self, from: baseURL)
//    .sink(receiveCompletion: { completion in
//        switch completion {
//        case .finished:
//            print("Request completed successfully.")
//        case .failure(let error):
//            print("Request failed with error: \(error)")
//        }
//    }, receiveValue: { todoItems in
//        print("Received todo items: \(todoItems.response.count)")
////                todoItems.forEach { print("- \($0.title)") }
//    })


class APIClient {
    private let session: URLSession
    
    init() {
        // Initialize URLSession
        session = URLSession.shared
    }
    
    // Define a generic method to fetch data and decode it
    func fetchData<T: Decodable>(_ type: T.Type, from endpoint: URL) -> AnyPublisher<T, Error> {
        
        // Create a URLSession Data Task Publisher
        return session.dataTaskPublisher(for: endpoint)
//            .map(\.data) // Extract only the data from the response
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw HTTPError.statusCode
                }
                return output.data
            }
            .decode(type: T.self, decoder: JSONDecoder()) // Decode JSON into the specified type
        
            .eraseToAnyPublisher() // Type erase to AnyPublisher
        
        
    }
    
    
    
    
}




