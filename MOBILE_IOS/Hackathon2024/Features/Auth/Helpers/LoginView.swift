//
//  loginView.swift
//  Hackathon2024
//
//  Created by Николай Прощалыкин on 19.04.2024.
//

import UIKit

final class LoginView: UIView {
    
    public var loginData: String = ""
    public var passwordData: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        addViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.text = "Вход"
        label.textAlignment = .center
        label.textColor = .black
        
        return label
    }()
    
    private lazy var loginField = EditText()
    private lazy var passwordField = EditText()
    
    private lazy var viewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        
        return view
    }()
    
    private lazy var fieldsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 24
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.addArrangedSubview(loginField)
        stack.addArrangedSubview(passwordField)
        
        return stack
    }()
    
    private lazy var logInButton: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.cornerRadius = 10
        let tap = UITapGestureRecognizer(target: self, action: #selector(logInTapped))
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(logInTapped))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Войти"
        label.textColor = .white
        label.textAlignment = .center
        
        
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.top.equalToSuperview().offset(10)
            make.right.bottom.equalToSuperview().offset(-10)
        }
        
        view.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
        
        return view
    }()
    
    private lazy var registrationButton: UIButton = {
       let btn = UIButton()
        btn.setTitle("Зарегистрироваться", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        makeSystem(btn)
        
        return btn
    }()
    
    func configure() {
        backgroundColor = .clear
        configureFields()
    }
    
    func addViews() {
        addSubview(viewContainer)
        addSubview(logInButton)
        [titleLabel,fieldsStack, registrationButton].forEach { viewContainer.addSubview($0) }
    }
    
    func layoutViews() {
        
        viewContainer.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(registrationButton.snp.bottom).offset(15)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(viewContainer.snp.top).offset(20)
            make.left.equalTo(viewContainer.snp.left).offset(20)
            make.right.equalTo(viewContainer.snp.right).offset(-20)
        }
        
        fieldsStack.snp.makeConstraints { make in
            make.left.equalTo(viewContainer.snp.left).offset(20)
            make.right.equalTo(viewContainer.snp.right).offset(-20)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
        
        registrationButton.snp.makeConstraints { make in
            make.top.equalTo(fieldsStack.snp.bottom).offset(10)
            make.right.equalTo(fieldsStack.snp.right)
        }
        
        logInButton.snp.makeConstraints { make in
            make.top.equalTo(registrationButton.snp.bottom).offset(30)
            make.centerX.equalTo(self.snp.centerX)
        }
    }
    
    func configureFields() {
        
        loginField.translatesAutoresizingMaskIntoConstraints = false
        loginField.set(placeholder: "Логин")
        loginField.textChanged(loginField.textField)
        loginField.textField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        loginField.textField.addTarget(self, action: #selector(textChanged(_:)), for: .editingDidEnd)
        loginField.textField.tag = 1
        
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.set(placeholder: "Пароль",isPassword: true)
        passwordField.textChanged(loginField.textField)
        passwordField.textField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        passwordField.textField.addTarget(self, action: #selector(textChanged(_:)), for: .editingDidEnd)
        passwordField.isPassword = true
        passwordField.textField.isSecureTextEntry = true
        passwordField.textField.tag = 2
    }
    
    @objc func textChanged(_ sender: UITextField) {
        switch sender.tag {
        case 1:
            loginData = sender.text ?? ""
        case 2:
            passwordData = sender.text ?? ""
        default:
            break
        }
        
        print(loginData, passwordData)
    }
    
    @objc func logInTapped() {
        UIView.animate(withDuration: 0.5) {
            self.logInButton.alpha = 0.5
            self.logInButton.alpha = 1
        }
        (parentViewController as? AuthViewController)?.logInTapped()
    }
    
    @objc func registerTapped() {
        (parentViewController as? AuthViewController)?.changeView(to: .registration)
    }
}
