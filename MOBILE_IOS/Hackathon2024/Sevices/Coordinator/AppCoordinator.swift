//
//  AppCoordinator.swift
//  Hackathon2024
//
//  Created by Николай Прощалыкин on 19.04.2024.
//

import UIKit

protocol Coordinator {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

final class AppCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navCon : UINavigationController) {
        self.navigationController = navCon
    }
    
    func start() {
        debugPrint("Application started!")
    }
}

// MARK: - Auth
extension AppCoordinator {
    
    func goToAuth() {
        let authVC = AuthViewController()
        
        let authVM = AuthViewModel()
        authVM.appCoordinator = self
        
        authVC.viewModel = authVM
        
        navigationController.pushViewController(authVC, animated: true)
    }
}
