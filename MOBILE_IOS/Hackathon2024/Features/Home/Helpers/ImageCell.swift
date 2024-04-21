//
//  ImageCell.swift
//  Hackathon2024
//
//  Created by Николай Прощалыкин on 20.04.2024.
//

import UIKit

final class ImageCell: UICollectionViewCell {
    
    private lazy var backView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var bannerImage: UIImageView = {
        let image = UIImage(named: "bannerTest")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.sizeToFit()
        imageView.alpha = 0.5
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Название команды"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var membersImages: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = -10
        
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        addViews()
        layoutViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bannerImage.image = nil
        titleLabel.text = ""
        membersImages.subviews.forEach { view in
            view.removeFromSuperview()
        }
    }
    
    func setupCell(team: Team?) {
        guard let team else { return }
//        let base64image = prepareBase64String(string: team.logo)
        let image = UIImage(data: Data(base64Encoded: team.logo) ?? Data())
        bannerImage.image = image == nil ? UIImage(named: "bannerTest") : image
        
        titleLabel.text = team.teamName
        
        var images: [String] = []
        team.teammates.forEach {_ in
//            images.append($0.photo ?? "")
            images.append("avatar1")
        }
        setMembersImages(images: images)
    }
    
    func prepareBase64String(string: String) -> String {
        var newStr = string
        let startIndex = newStr.index(newStr.startIndex, offsetBy: 21)
        newStr.removeSubrange(newStr.startIndex..<startIndex)
        
        return string
    }
    
    func setMembersImages(images: [String]) {
        images.forEach { imageStr in
//            let image = UIImage(data: Data(base64Encoded: imageStr) ?? Data())
            let image = UIImage(named: imageStr)
            let imageView = getMemberImageView(memberImage: image)
            membersImages.addArrangedSubview(imageView)
        }

    }
    
    func getMemberImageView(memberImage: UIImage?) -> UIImageView {
        var image: UIImage?
        if let memberImage {
            image = memberImage
        } else {
            image = UIImage(systemName: "person.crop.circle")
        }
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.sizeToFit()
        imageView.tintColor = .white
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.snp.makeConstraints { make in
            make.height.width.equalTo(30)
        }
        
        return imageView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        backgroundColor = .black
    }
    
    func layoutViews() {
        backView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
        bannerImage.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(bannerImage.snp.top).offset(10)
            make.left.equalTo(bannerImage.snp.left).offset(10)
        }
        membersImages.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-5)
        }
    }
    
    func addViews() {
        addSubview(backView)
        backView.addSubview(bannerImage)
        backView.addSubview(titleLabel)
        backView.addSubview(membersImages)
    }
    
}
