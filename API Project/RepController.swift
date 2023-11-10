//
//  RepController.swift
//  API Project
//
//  Created by Tyler May on 11/9/23.
//

import Foundation

class RepController {
    
    enum RepControllerError: Error, LocalizedError {
        case zipNotFound
    }
    
    let baseURL = URL(string: "https://whoismyrepresentative.com/")!
    
    func fetchReps(forZipCode zipCode: String) async throws -> [RepResponse] {
            guard let requestURL = URL(string: "getall_mems.php?zip=\(zipCode)&output=json", relativeTo: baseURL) else {
                throw RepControllerError.zipNotFound
            }
    
            do {
                let (data, _) = try await URLSession.shared.data(from: requestURL)
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]

                if let representatives = json?["results"] as? [[String: String]] {
                    print("representatives: ", representatives)
                    let parsedReps = representatives.compactMap { repData in
                        if let name = repData["name"],
                           let state = repData["state"],
                           let websiteString = repData["link"],
                           let websiteURL = URL(string: websiteString),
                           let party = repData["party"] {
                            return RepResponse(name: name, state: state, website: websiteURL, party: party)
                        }
                        return nil
                    }
                    return parsedReps
                } else {
                    print("wrong data type")
                    throw RepControllerError.zipNotFound
                }
            } catch {
                throw error
            }
        }
}
