//
//  HomeViewModel.swift
//  Hackathon2024
//
//  Created by Николай Прощалыкин on 19.04.2024.
//

import Foundation

protocol HomeViewModelProtocol {
    var appCoordinator: AppCoordinator? { get }
}

final class HomeViewModel: HomeViewModelProtocol {
   weak var appCoordinator: AppCoordinator?
}
