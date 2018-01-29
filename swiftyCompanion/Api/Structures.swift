//
//  Structures.swift
//  swiftyCompanion
//
//  Created by Jordan MUNOZ on 1/22/18.
//  Copyright © 2018 Jordan MUNOZ. All rights reserved.
//

import Foundation

struct Auth: Codable {
    var access_token: String?
    var token_type: String?
    var expires_in: Int?
    var scope: String?
    var created_at: Int?
}

struct CursusUser: Codable {
    var cursus_id: Int?
    var level: Float?
    var skills: [Skill]?
}

struct Skill: Codable {
    var name: String?
    var level: Float?
}

struct ProjectDetails: Codable {
    var name: String?
}

struct Project: Codable {
    var final_mark: Int?
    var status: String?
    var project: ProjectDetails?
    var validated: Bool?
    
    enum CodingKeys: String, CodingKey {
        case validated = "validated?"
        case final_mark, status, project
    }
}

struct User: Codable {
    var id: Int?
    var login: String?
    var url: String?
    var image_url: String?
    var wallet: Int?
    var phone: String?
    var pool_year: String?
    var cursus_users: [CursusUser]?
    var location: String?
    var displayname: String?
    var email: String?
    var projects_users: [Project]?
}


