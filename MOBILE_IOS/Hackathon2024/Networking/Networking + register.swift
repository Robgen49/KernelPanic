//
//  Networking + register.swift
//  Hackathon2024
//
//  Created by Николай Прощалыкин on 20.04.2024.
//

import Foundation

extension Networking {
    static func signUp(team: Team, completion: @escaping (Bool) -> Void) {
        let params: [String: Any] = [
            "teamName": team.teamName,
            "logo": team.logo,
            "email": team.email,
            "login": team.login,
            "password": team.password,
            "teammates": team.teammates.map { $0.toDictionary() },
        ]
        
        self.performRequest(method: .post,
                            endPoint: .signUp,
                            params: params,
                            withToken: false) { json in
            if let json {
                completion(true)
            } else {
                completion(false)
            }
            
        }
    }
}
