//
//  RegisterView.swift
//  Hackathon2024
//
//  Created by Николай Прощалыкин on 19.04.2024.
//

import UIKit

final class RegisterView: UIView {
    
    private var userData: [String] = ["", "", "", ""] ///Название, почта, логин, пароль
    
    private var bannerImage: UIImage? {
        didSet {
            bannerImageView.image = bannerImage
            addBannerButtom.isHidden  = bannerImage == nil ? false : true
        }
    }
    
    private lazy var bannerImageView = UIImageView()
    private lazy var addBannerButtom = UIButton()
    private lazy var addMemberButton = UIButton()
    
    private lazy var bannerStack = getBannerStack()
    private lazy var membersStack = getMembersStack()
    
    private lazy var goToLoginButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("  Войти", for: .normal)
        btn.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        btn.imageView?.tintColor = .black
        btn.setTitleColor(.black, for: .normal)
        makeSystem(btn)
        btn.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        return btn
    }()
    
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
   
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.text = "Регистрация"
        label.textAlignment = .center
        label.textColor = .black
        
        return label
    }()
    
    private lazy var fieldStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 24
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        let teamName = getField(placeholder: "Название команды", tag: 1)
        let mail = getField(placeholder: "Почта", tag: 2)
        let login = getField(placeholder: "Логин", tag: 3)
        let password = getField(placeholder: "Пароль", tag: 4)
        
        [teamName, mail, login, password, bannerStack, membersStack].forEach {
            stack.addArrangedSubview($0)
        }
        
        return stack
    }()
    
    private lazy var registerButton: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.cornerRadius = 10
        let tap = UITapGestureRecognizer(target: self, action: #selector(registerTapped))
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(registerTapped))
        view.addGestureRecognizer(tap)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.isUserInteractionEnabled = true
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Зарегистрироваться"
        label.textColor = .white
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.top.equalToSuperview().offset(10)
            make.right.bottom.equalToSuperview().offset(-10)
        }
        
        view.snp.makeConstraints { make in
            make.width.equalTo(300)
        }
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        addViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        backgroundColor = .clear
    }
    
    func addViews() {
        addSubview(viewContainer)
        addSubview(registerButton)
        addSubview(goToLoginButton)
        [titleLabel, fieldStack].forEach { viewContainer.addSubview($0) }
    }
    
    func layoutViews() {
        
        goToLoginButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
        }
        
        viewContainer.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(fieldStack.snp.bottom).offset(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(viewContainer.snp.top).offset(20)
            make.left.equalTo(viewContainer.snp.left).offset(20)
            make.right.equalTo(viewContainer.snp.right).offset(-20)
        }
        
        fieldStack.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.equalTo(viewContainer.snp.left).offset(20)
            make.right.equalTo(viewContainer.snp.right).offset(-20)
        }
        
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(fieldStack.snp.bottom).offset(50)
            make.centerX.equalTo(fieldStack.snp.centerX)
            make.height.equalTo(50)
        }
        

    }
}

extension RegisterView {
    func getMembersStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.spacing = 10
        hStack.distribution = .fill
        
        let addMemberLabel = UILabel()
        addMemberLabel.translatesAutoresizingMaskIntoConstraints = false
        addMemberLabel.text = "Добавить участника"
        addMemberLabel.textColor = .systemGray3
        addMemberLabel.font = UIFont.systemFont(ofSize: 18)
        
        addMemberButton.translatesAutoresizingMaskIntoConstraints = false
        addMemberButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addMemberButton.imageView?.tintColor = .black
        addMemberButton.setTitleColor(.black, for: .normal)
        addMemberButton.addTarget(self, action: #selector(addMember), for: .touchUpInside)
        
        hStack.addArrangedSubview(addMemberLabel)
        hStack.addArrangedSubview(addMemberButton)
        
        stack.addArrangedSubview(hStack)
        return stack
    }
    
    func getField(placeholder: String, tag: Int) -> EditText {
        let field = EditText()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.set(placeholder: placeholder)
        field.textChanged(field.textField)
        field.textField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        field.textField.addTarget(self, action: #selector(textChanged(_:)), for: .editingDidEnd)
        field.textField.tag = tag
        return field
    }
    
    func getBannerStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        let addBannerLabel = UILabel()
        addBannerLabel.translatesAutoresizingMaskIntoConstraints = false
        addBannerLabel.text = "Баннер команды"
        addBannerLabel.textColor = .systemGray3
        addBannerLabel.font = UIFont.systemFont(ofSize: 18)
        
        addBannerButtom.translatesAutoresizingMaskIntoConstraints = false
        addBannerButtom.setImage(UIImage(systemName: "plus"), for: .normal)
        addBannerButtom.imageView?.tintColor = .black
        addBannerButtom.setTitleColor(.black, for: .normal)
        addBannerButtom.addTarget(self, action: #selector(pickImage), for: .touchUpInside)
        
        makeSystem(addBannerButtom)
        
        bannerImageView.translatesAutoresizingMaskIntoConstraints = false
        bannerImageView.layer.cornerRadius = 5
        bannerImageView.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(pickImage))
        bannerImageView.addGestureRecognizer(tap)
        bannerImageView.isUserInteractionEnabled = true
        
        
        stack.addArrangedSubview(addBannerLabel)
        stack.addArrangedSubview(addBannerButtom)
        stack.addArrangedSubview(bannerImageView)
        
        return stack
    }
    
    @objc func textChanged(_ sender: UITextField) {
        userData[sender.tag-1] = sender.text ?? ""
        print(userData)
    }
    
    @objc func registerTapped() {
        UIView.animate(withDuration: 0.5) {
            self.registerButton.alpha = 0.5
            self.registerButton.alpha = 1
        }
        
        (parentViewController as? AuthViewController)?.registerTapped()
    }
    
    @objc func backButtonTapped() {
        (parentViewController as? AuthViewController)?.changeView(to: .login)
    }
    
    @objc func pickImage() {
        selectImageFromGallery()
    }
    
    @objc func deleteImage() {
        bannerImage = nil
    }
    
    @objc func addMember() {
        (parentViewController as? AuthViewController)?.viewModel?.appCoordinator?.goToAddMember()
    }
}

extension RegisterView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func selectImageFromGallery() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        parentViewController?.present(imagePickerController, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            bannerImage = pickedImage
        }
        parentViewController?.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        parentViewController?.dismiss(animated: true, completion: nil)
    }
}
