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
        
        for i in 0...4 {
            stack.addArrangedSubview(getMemberImageView())
        }
        
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
    }
    
    func setupCell() {
        
    }
    
    func getMemberImageView() -> UIImageView {
        let image = UIImage(systemName: "person.crop.circle")
        
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.sizeToFit()
        imageView.tintColor = .white
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
