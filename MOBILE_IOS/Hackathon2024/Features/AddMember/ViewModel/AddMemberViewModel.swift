//
//  AddMemberViewModel.swift
//  Hackathon2024
//
//  Created by Николай Прощалыкин on 20.04.2024.
//

import Foundation

protocol AddMemberViewModelProtocol: AnyObject {
    var appCoordinator: AppCoordinator? { get }
}

final class AddMemberViewModel: AddMemberViewModelProtocol {
    weak var appCoordinator: AppCoordinator?
}
