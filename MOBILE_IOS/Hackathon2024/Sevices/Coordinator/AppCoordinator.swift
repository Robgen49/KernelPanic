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
//        goToHome()
        goToAuth()
//        goToTeamProfile()
        debugPrint("Application started!")
    }
}

// MARK: - Auth
extension AppCoordinator {
    
    func backToAuth() {
        goToAuth()
    }
    
    func goToAuth() {
        let authVC = AuthViewController()
        
        let authVM = AuthViewModel()
        authVM.appCoordinator = self
        
        authVC.viewModel = authVM
        
        navigationController.pushViewController(authVC, animated: true)
    }
    
    func goToAddMember() {
        let addMemVC = AddMemberViewController()
        
        let addMemVM = AddMemberViewModel()
        addMemVM.appCoordinator = self
        
        addMemVC.viewModel = addMemVM
        navigationController.pushViewController(addMemVC, animated: true)
    }
    
    func goToHome() {
        let homeVC = HomeViewController()
        
        let homeVM = HomeViewModel()
        homeVM.appCoordinator = self
        
        homeVC.viewModel = homeVM
        navigationController.pushViewController(homeVC, animated: true)
    }
    
    func goToTeamProfile() {
        let profileVC = TeamProfileViewController()
        
        let profileVM = TeamProfileViewModel()
        profileVM.appCoordinator = self
        
        profileVC.viewModel = profileVM
        navigationController.pushViewController(profileVC, animated: true)
    }
}
