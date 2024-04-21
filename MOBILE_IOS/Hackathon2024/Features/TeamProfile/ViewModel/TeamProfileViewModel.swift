//
//  TeamProfileViewModel.swift
//  Hackathon2024
//
//  Created by Николай Прощалыкин on 20.04.2024.
//

import UIKit

protocol TeamProfileViewModelProtocol: AnyObject {
    var appCoordinator: AppCoordinator? { get }
    var team: Team? { get }
    var data: [(String, String)] { get }
}
     
final class TeamProfileViewModel: TeamProfileViewModelProtocol {
    weak var appCoordinator: AppCoordinator?
    
    var team: Team? = nil
    var data: [(String, String)] = [("robert", "Генрих Роберт"),
                                    ("dima", "Яковлев Дмитрий"),
                                    ("nikita", "Штанько Никита"),
                                    ("kolya", "Прощалыкин Николай")
    ]
}
