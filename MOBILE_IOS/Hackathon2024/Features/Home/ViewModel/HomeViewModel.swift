//
//  HomeViewModel.swift
//  Hackathon2024
//
//  Created by Николай Прощалыкин on 19.04.2024.
//

import Foundation
import UIKit

protocol HomeViewModelProtocol {
    var appCoordinator: AppCoordinator? { get }
    var teams: [Team] { get set}
}

final class HomeViewModel: HomeViewModelProtocol {
    var teams: [Team] = []
    
    weak var appCoordinator: AppCoordinator?
    
}
