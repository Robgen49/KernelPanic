//
//  View.swift
//  Hackathon2024
//
//  Created by Николай Прощалыкин on 20.04.2024.
//

import UIKit

final class AddMemberViewController: UIViewController {
    //MARK: - Properties
    var viewModel: AddMemberViewModelProtocol?
    
    public var memberData: [String] = ["", "", "", "", ""] /// ФИО, стек, направление, оцените, трудности
    
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
    
    private lazy var backgroundView = RadialGradientView()
    private lazy var nameField = getField(placeholder: "ФИО", tag: 1)
    private lazy var photoStack = getPhotoStack()
    private lazy var cvStack = getCVStack()
    
    private lazy var divider = UIView()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.text = "Добавление участника"
        label.textAlignment = .center
        label.textColor = .black
        
        return label
    }()
    
    private lazy var formLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.text = "Заполните анкету (по возможности)"
        label.textAlignment = .center
        label.textColor = .black
        
        return label
    }()
    
    private lazy var addMemberButton: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.cornerRadius = 10
        let tap = UITapGestureRecognizer(target: self, action: #selector(addTapped))
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(addTapped))
        view.addGestureRecognizer(tap)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.isUserInteractionEnabled = true
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Добавить"
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
            make.width.equalTo(200)
        }
        
        return view
    }()
    
    private lazy var photoImageView = UIImageView()
    private lazy var addphotoButtom = UIButton()
    
    private var photoImage: UIImage? {
        didSet {
            photoImageView.image = photoImage
            addphotoButtom.isHidden  = photoImage == nil ? false : true
        }
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addViews()
        layoutViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }
}

// MARK: - public extension
extension AddMemberViewController {
    
}

// MARK: - private extension
private extension AddMemberViewController {
    func configure() {
        navigationController?.navigationBar.tintColor = .black
        view.backgroundColor = .white
        backgroundView.frame = view.frame
        backgroundView.InsideColor = #colorLiteral(red: 0.8983470412, green: 0.9355988067, blue: 1, alpha: 0.9872572943)
        backgroundView.OutsideColor = .white
        
        divider.backgroundColor = .systemGray
        divider.translatesAutoresizingMaskIntoConstraints = false
    }

    func addViews() {
        view.addSubview(backgroundView)
        backgroundView.addSubview(viewContainer)
        backgroundView.addSubview(addMemberButton)
        [titleLabel, nameField, photoStack, formLabel, divider, cvStack].forEach { viewContainer.addSubview($0) }
    }

    func layoutViews() {
        
        viewContainer.snp.makeConstraints { make in
            make.top.equalTo(backgroundView.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalTo(backgroundView.snp.left).offset(20)
            make.right.equalTo(backgroundView.snp.right).offset(-20)
            make.bottom.equalTo(cvStack.snp.bottom).offset(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(viewContainer.snp.top).offset(20)
            make.left.right.equalToSuperview()
        }
        
        nameField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        photoStack.snp.makeConstraints { make in
            make.top.equalTo(nameField.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        
        divider.snp.makeConstraints { make in
            make.top.equalTo(photoStack.snp.bottom).offset(10)
            make.height.equalTo(1)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        formLabel.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.top).offset(40)
            make.left.right.equalToSuperview()
        }
        
        cvStack.snp.makeConstraints { make in
            make.top.equalTo(formLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        addMemberButton.snp.makeConstraints { make in
            make.top.equalTo(cvStack.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
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
    
    func getPhotoStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        let addPhotoLabel = UILabel()
        addPhotoLabel.translatesAutoresizingMaskIntoConstraints = false
        addPhotoLabel.text = "Фото участника"
        addPhotoLabel.textColor = .systemGray3
        addPhotoLabel.font = UIFont.systemFont(ofSize: 18)
        
        addphotoButtom.translatesAutoresizingMaskIntoConstraints = false
        addphotoButtom.setImage(UIImage(systemName: "plus"), for: .normal)
        addphotoButtom.imageView?.tintColor = .black
        addphotoButtom.setTitleColor(.black, for: .normal)
        addphotoButtom.addTarget(self, action: #selector(pickImage), for: .touchUpInside)
        
        view.makeSystem(addphotoButtom)
        
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.layer.cornerRadius = 5
        photoImageView.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(pickImage))
        photoImageView.addGestureRecognizer(tap)
        photoImageView.isUserInteractionEnabled = true
        
        
        stack.addArrangedSubview(addPhotoLabel)
        stack.addArrangedSubview(photoImageView)
        stack.addArrangedSubview(addphotoButtom)
        
        
        return stack
    }
}

// MARK: - objc extension
@objc private extension AddMemberViewController {
    func textChanged(_ sender: UITextField) {
        memberData[sender.tag - 1] = sender.text ?? ""
    }
    
    @objc func pickImage() {
        selectImageFromGallery()
    }

    @objc func addTapped() {
        let imageString = photoImage?.pngData()?.base64EncodedString() ?? ""
        let vc = navigationController?.viewControllers[(navigationController?.viewControllers.count)! - 2] as? AuthViewController
        vc?.registrView.members.append(Teammate(fullName: memberData[0],
                                                                             photo: imageString,
                                                                             stack_tech: memberData[1],
                                                                             direction: memberData[2],
                                                                             assessment: memberData[3],
                                                                             difficulties: memberData[4]))
        navigationController?.popViewController(animated: true)
    }
}

extension AddMemberViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func selectImageFromGallery() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoImage = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func getFAQStack(text: String, placeholder: String, tag: Int) -> UIStackView {
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
        textField.set(placeholder: placeholder)
        textField.textChanged(textField.textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        textField.textField.addTarget(self, action: #selector(textChanged(_:)), for: .editingDidEnd)
        textField.textField.tag = tag
        
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(textField)
        
        return stack
    }
    
    func getCVStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 20
        
        let skills = getFAQStack(text: "Стек технологий", placeholder: "Напишите названия", tag: 2)
        let proffesion = getFAQStack(text: "Направление", placeholder: "Напишите название", tag: 3)
        let memberGrade = getFAQStack(text: "Оцените свой вклад в данной работе", placeholder: "Введите оценку", tag: 4)
        let difficults = getFAQStack(text: "С какими трудностями столкнулись", placeholder: "Опишите трудности", tag: 5)
        
        [skills, proffesion, memberGrade, difficults].forEach {
            stack.addArrangedSubview($0)
        }
        
        return stack
    }
}


