//
//  MemberInfoViewController.swift
//  Hackathon2024
//
//  Created by Николай Прощалыкин on 21.04.2024.
//

import UIKit

class MemberInfoViewController: UIViewController {

//MARK: - Properties
    private lazy var fullNameLabel: UILabel = {
       let label = UILabel()
        
        return label
    }()
    
    private lazy var photoView: UIImageView = {
        let image = UIImage(named: "")
        let imageView = UIImageView(image: image)
        
        return imageView
    }()
    
    private lazy var memberView = getMemberView(name: "Фамилия имя отчество", image: "")

// MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addViews()
        layoutViews()
    }
}

// MARK: - private extension
private extension MemberInfoViewController {
    func configure() {
        view.backgroundColor = .white
    }

    func addViews() {
        view.addSubview(memberView)
    }

    func layoutViews() {
        memberView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    func getMemberView(name: String, image: String) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let memberImage = UIImage(systemName: "person.crop.circle") //image
        let memberImageView = UIImageView(image: memberImage)
        memberImageView.translatesAutoresizingMaskIntoConstraints = false
        memberImageView.snp.makeConstraints { make in
            make.width.height.equalTo(60)
        }
        memberImageView.clipsToBounds = true
        memberImageView.layer.cornerRadius = 30
        
        let memberName = UILabel()
        memberName.translatesAutoresizingMaskIntoConstraints = false
        memberName.text = name
        memberName.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        memberName.numberOfLines = 0
        
        
        let skills = getFAQStack(text: "Стек технологий", placeholder: "Технологии", tag: 2, valueText: "")
        let proffesion = getFAQStack(text: "Направление", placeholder: "направление", tag: 3, valueText: "")
        let memberGrade = getFAQStack(text: "Оцените свой вклад в данной работе", placeholder: "вклад", tag: 4, valueText: "")
        let difficults = getFAQStack(text: "С какими трудностями столкнулись", placeholder: "трудности", tag: 5, valueText: "")
        
        [memberImageView, memberName, skills, proffesion, memberGrade, difficults].forEach {
            view.addSubview($0)
        }
        
        view.snp.makeConstraints { make in
            make.height.equalTo(450)
        }
        
        memberImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
        }
        
        memberName.snp.makeConstraints { make in
            make.left.equalTo(memberImageView.snp.right).offset(20)
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalTo(memberImageView.snp.centerY)
        }
        
        skills.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(memberImageView.snp.bottom).offset(20)
        }
        
        proffesion.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(skills.snp.bottom).offset(20)
        }
        
        memberGrade.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(proffesion.snp.bottom).offset(20)
        }
        
        difficults.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(memberGrade.snp.bottom).offset(20)
        }
        
        
//        memberCV.snp.makeConstraints { make in
//            make.top.equalTo(memberImageView.snp.bottom).offset(10)
//            make.left.equalToSuperview().offset(20)
//            make.right.equalToSuperview().offset(-20)
//            make.height.equalTo(100)
//        }
        
        return view
    }
    
    func getFAQStack(text: String, placeholder: String, tag: Int, valueText: String) -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 2
        
        let textField = EditText()
        textField.textField.text = valueText
        textField.set(placeholder: placeholder)
        textField.textChanged(textField.textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.textField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
//        textField.textField.addTarget(self, action: #selector(textChanged(_:)), for: .editingDidEnd)
        textField.textField.tag = tag
        textField.isUserInteractionEnabled = false
        
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(textField)
        
        return stack
    }
}

// MARK: - objc extension
@objc private extension AuthViewController {

}
