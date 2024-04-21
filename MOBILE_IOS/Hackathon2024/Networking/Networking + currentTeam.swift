//
//  Networking + currentTeam.swift
//  Hackathon2024
//
//  Created by Николай Прощалыкин on 21.04.2024.
//

import Foundation

extension Networking {
    static func fetchCurrentTeam(completion: @escaping (Bool) -> Void) {
        
        self.performRequest(method: .get,
                            endPoint: .fetchCurrentTeam,
                            params: nil,
                            withToken: true) { json in
            if let json {
                do {
                    let parsed = try JSONDecoder().decode(Team.self, from: json.rawData())
                } catch let error {
                    debugPrint(error.localizedDescription)
                }
                completion(true)
            } else {
                completion(false)
            }
            
        }
    }
}
