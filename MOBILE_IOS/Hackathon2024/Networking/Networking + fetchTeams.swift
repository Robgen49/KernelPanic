//
//  Networking + fetchTeams.swift
//  Hackathon2024
//
//  Created by Николай Прощалыкин on 20.04.2024.
//

import Foundation

extension Networking {
    static func fetchTeams(completion: @escaping (([Team]?,Bool)) -> Void) {
        
        self.performRequest(method: .get,
                            endPoint: .fetchAllTeams,
                            params: nil,
                            withToken: true) { json in
            if let json {
                do {
                    let teams: [Team] = try JSONDecoder().decode([Team].self, from: json.rawData())
                    
                    completion((teams,true))
                } catch let error{
                    completion((nil, false))
                }
                
                
            } else {
                completion((nil,false))
            }
            
        }
    }
}
