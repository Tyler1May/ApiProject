//
//  ResponseModel.swift
//  API Project
//
//  Created by Tyler May on 11/9/23.
//

import Foundation

struct DogResponse: Codable {
    let status: String
    let message: String
}

struct RepResponse: Codable {
    let name: String
    let state: String
    let website: URL?
    let party: String
}
