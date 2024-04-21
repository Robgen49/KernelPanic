//
//  Team.swift
//  Hackathon2024
//
//  Created by Николай Прощалыкин on 20.04.2024.
//

//   let team = try? JSONDecoder().decode(Team.self, from: jsonData)

import Foundation

// MARK: - Team
struct Team: Codable {
    let id: Int? = nil
    let teamName, logo: String
    let teammates: [Teammate]
    let email, login, password : String
    let role: String? = nil
    let enabled: Bool? = nil
    let accountNonExpired: Bool? = nil
    let authorities: [Authority]? = nil
    let username: String? = nil
    let accountNonLocked: Bool? = nil
    let credentialsNonExpired: Bool? = nil
}

// MARK: - Authority
struct Authority: Codable {
    let authority: String
}

// MARK: - Teammate
struct Teammate: Codable {
    let id: Int? = nil
    let fullName, photo, stack_tech, direction, assessment, difficulties: String?

    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case photo
        case stack_tech
        case assessment
        case direction
        case difficulties
    }
}

extension Teammate {
    func toDictionary() -> [String: Any] {
        return [
            "fullName": fullName,
            "photo": photo,
            "stack_tech": stack_tech,
            "assessment": assessment,
            "direction": direction,
            "difficulties": difficulties
        ]
    }
}
