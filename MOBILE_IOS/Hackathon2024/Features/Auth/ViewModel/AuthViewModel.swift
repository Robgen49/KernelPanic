//
//  AuthViewModel.swift
//  Hackathon2024
//
//  Created by Николай Прощалыкин on 19.04.2024.
//

import Foundation

protocol AuthViewModelProtocol: AnyObject {
    var appCoordinator: AppCoordinator? { get }
    func logIn(login: String, password: String, completion: @escaping (Bool) -> Void)
    
    func validateFiels(login: String, password: String) -> Bool
}

final class AuthViewModel: AuthViewModelProtocol {
    func logIn(login: String, password: String, completion: @escaping (Bool) -> Void) {
        Networking.signIn(login: login, password: password) { result in
            completion(result)
        }
    }
    
    weak var appCoordinator: AppCoordinator?
    
    func validateFiels(login: String, password: String) -> Bool {
        guard login.count >= 4, password.count >= 4 else { return false }
        return true
    }
}
