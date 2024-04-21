//
//  OverlayIndicatorController.swift
//  Beauty
//
//  Created by для интернета on 07.04.2021.
//

import UIKit
import SVProgressHUD

final class OverlayIndicator: UIViewController {
    static let overlayWindow = UIWindow()
    static let screenFrame = UIScreen.main.bounds
    static let activity = UIActivityIndicatorView(frame: CGRect(x: screenFrame.midX, y: screenFrame.midY, width: 100, height: 100))
    
    static func present() {
        DispatchQueue.main.async {
            overlayWindow.overrideUserInterfaceStyle = .light
            
            activity.color = .blue
//            let overlayVC = UIViewController()
//            overlayVC.view.backgroundColor = .black
//            overlayVC.view.addSubview(activity)
            overlayWindow.addSubview(activity)
            overlayWindow.frame = screenFrame
            overlayWindow.backgroundColor = .clear
//            overlayWindow.rootViewController = overlayVC
            overlayWindow.isHidden = false
            activity.startAnimating()
            
            SVProgressHUD.show()
        }
    }
    
    static func hide() {
        DispatchQueue.main.async {
            activity.stopAnimating()
            overlayWindow.isHidden = true
            SVProgressHUD.dismiss()
        }
    }
}

//class OverlayIndicatorController: UIViewController {
//
//    static let overlayWindow = UIWindow()
//
//    /// Добавление на экран анимированного индикатора при загрузке данных
//    static func present() {
//        DispatchQueue.main.async {
//            if #available(iOS 13.0, *) {
//                overlayWindow.overrideUserInterfaceStyle = .light
//            }
//
//            let id = "OverlayIndicatorController"
//            let storyboard = UIStoryboard(name: "Shared", bundle: nil)
//            let dim = storyboard.instantiateViewController(withIdentifier: id)
//
//            dim.setNeedsStatusBarAppearanceUpdate()
//
//            overlayWindow.frame = UIScreen.main.bounds
//            overlayWindow.backgroundColor = .clear
//            overlayWindow.rootViewController = dim
//            overlayWindow.isHidden = false
//
//            SVProgressHUD.show()
//        }
//    }
//
//    static func hide() {
//        DispatchQueue.main.async {
//            overlayWindow.isHidden = true
//            SVProgressHUD.dismiss()
//
//            messageLabel.removeFromSuperview()
//            titleLabel.removeFromSuperview()
//            centralView.removeFromSuperview()
//        }
//    }
//
//    private static let centralView = UIView()
//
//    private static let titleLabel = UILabel()
//
//    private static let messageLabel = UILabel()
//
//    private static var progress = 0
//
//    static func upgradeProgress(value: Int) {
//        progress += value
//        if progress < 100 {
//            messageLabel.text = "\(progress)% выполнено..."
//        } else {
//            messageLabel.text = "Пожалуйста, подождите..."
//        }
//    }
//
//    static func upgradeProgress(set: Int) {
//        progress = set
//        if progress < 100 {
//            messageLabel.text = "\(progress)% выполнено..."
//        } else {
//            messageLabel.text = "Пожалуйста, подождите..."
//        }
//    }
//
//    static func displayMessageAlert(title: String) {
//        guard
//            let titleFont = UIFont(name: "PlayfairDisplay-Bold", size: 20),
//            let itemsFont = UIFont(name: "PlayfairDisplay-Regular", size: 20)
//        else {
//            return
//        }
//
//        progress = 0
//
//        if #available(iOS 13.0, *) {
//            overlayWindow.overrideUserInterfaceStyle = .light
//        }
//
//        overlayWindow.frame = UIScreen.main.bounds
//        overlayWindow.backgroundColor = UIColor.black.withAlphaComponent(0.25)
//        overlayWindow.isHidden = false
//
//        overlayWindow.addSubview(centralView)
//        centralView.backgroundColor = .white
//        centralView.translatesAutoresizingMaskIntoConstraints = false
//        centralView.widthAnchor.constraint(lessThanOrEqualToConstant: UIScreen.main.bounds.width).isActive = true
//        centralView.centerXAnchor.constraint(equalTo: overlayWindow.centerXAnchor).isActive = true
//        centralView.centerYAnchor.constraint(equalTo: overlayWindow.centerYAnchor).isActive = true
//
//        centralView.addSubview(titleLabel)
//        titleLabel.textAlignment = .center
//        titleLabel.text = title
//        titleLabel.numberOfLines = 0
//        titleLabel.font = titleFont
//
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        titleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: UIScreen.main.bounds.width).isActive = true
//        titleLabel.leftAnchor.constraint(equalTo: centralView.leftAnchor, constant: 20).isActive = true
//        titleLabel.rightAnchor.constraint(equalTo: centralView.rightAnchor, constant: -20).isActive = true
//        titleLabel.topAnchor.constraint(equalTo: centralView.topAnchor, constant: 20).isActive = true
//        titleLabel.sizeToFit()
//
//        centralView.addSubview(messageLabel)
//        messageLabel.textAlignment = .center
//        messageLabel.text = "\(progress)% выполнено..."
//        messageLabel.font = itemsFont
//
//        messageLabel.translatesAutoresizingMaskIntoConstraints = false
//        messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: UIScreen.main.bounds.width).isActive = true
//        messageLabel.leftAnchor.constraint(equalTo: centralView.leftAnchor, constant: 20).isActive = true
//        messageLabel.rightAnchor.constraint(equalTo: centralView.rightAnchor, constant: -20).isActive = true
//        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
//        messageLabel.bottomAnchor.constraint(equalTo: centralView.bottomAnchor, constant: -20).isActive = true
//        messageLabel.sizeToFit()
//
//        centralView.sizeToFit()
//
//        centralView.clipsToBounds = true
//        centralView.layer.cornerRadius = 25
//    }
//}
