//
//  Networking + sinIn.swift
//  Hackathon2024
//
//  Created by Николай Прощалыкин on 20.04.2024.
//

import Foundation

extension Networking {
    static func signIn(login: String, password: String, completion: @escaping (Bool) -> Void) {
        let params: [String: Any] = [
            "login": login,
            "password": password
        ]
        
        self.performRequest(method: .post,
                            endPoint: .signIn,
                            params: params,
                            withToken: false) { json in
            if let json {
                token = json["token"].stringValue
                completion(true)
            } else {
                completion(false)
            }
            
        }
    }
}

