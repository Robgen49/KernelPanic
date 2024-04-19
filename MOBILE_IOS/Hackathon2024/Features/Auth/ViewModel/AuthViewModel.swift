//
//  AuthViewModel.swift
//  Hackathon2024
//
//  Created by Николай Прощалыкин on 19.04.2024.
//

import Foundation

protocol AuthViewModelProtocol: AnyObject {
    
}

final class AuthViewModel: AuthViewModelProtocol {
    weak var appCoordinator: AppCoordinator?
}
