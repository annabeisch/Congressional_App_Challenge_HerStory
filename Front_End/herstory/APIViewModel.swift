//
//  APIViewModel.swift
//  herstory
//
//  Created by Anna Beischer on 9/8/24.
//

import Foundation
import Combine

class HeroesViewModel: ObservableObject {
    @Published var heroes: [UnsungHero] = []
    @Published var createdWikithon: Wikithon?
    private var cancellable: AnyCancellable?
    
    private var localBaseUrl = "http://127.0.0.1:8000"
    private var deployedBaseUrl = "https://herstorybackend.onrender.com"
    
    private var apiBaseUrl = "https://herstorybackend.onrender.com"

    func fetchHeroes() {
        guard let url = URL(string: "\(apiBaseUrl)/heroes/") else { return }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [UnsungHero].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching heroes: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] heroes in
                self?.heroes = heroes
            })
    }
    // Function to create a new Wikithon
    func createWikithon(name: String, createdDate: Date, n: Int) {
        guard let url = URL(string: "\(apiBaseUrl)/wikithon/create") else { return }

        // Convert Date to String
        let dateFormatter = ISO8601DateFormatter()
        let createdDateString = dateFormatter.string(from: createdDate)

        // Create the request body
        let requestBody: [String: Any] = [
            "name": name,
            "date": createdDateString,
            "n": n
        ]

        // Convert the dictionary to JSON data
        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestBody) else { return }

        // Prepare the URL request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        // Send the request using URLSession
        cancellable = URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: Wikithon.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .failure(let error):
                    print("Error creating Wikithon: \(error)")
                    case .finished:
                    break
                }
            }, receiveValue: { [weak self] wikithon in
                print(wikithon)
            self?.createdWikithon = wikithon
        })
    }
}
