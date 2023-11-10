//
//  DogController.swift
//  API Project
//
//  Created by Tyler May on 11/9/23.
//

import Foundation
import UIKit

class DogController {
   
    
    enum DogControllerError: Error, LocalizedError {
        case dogNotFound
    }
    
    func fetchDog() async throws -> String {
        let dogApiURL = URL(string: "https://dog.ceo/api/breeds/image/random")!
        let (data, response) = try await URLSession.shared.data(from: dogApiURL)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw DogControllerError.dogNotFound
        }
        
        let decoder = JSONDecoder()
        let dogResponse = try decoder.decode(DogResponse.self, from: data)
        
        return dogResponse.message    }
    
}
