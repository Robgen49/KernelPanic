//
//  TeamProfileViewModel.swift
//  Hackathon2024
//
//  Created by Николай Прощалыкин on 20.04.2024.
//

import UIKit

protocol TeamProfileViewModelProtocol: AnyObject {
    var appCoordinator: AppCoordinator? { get }
}

final class TeamProfileViewModel: TeamProfileViewModelProtocol {
    weak var appCoordinator: AppCoordinator?
}
