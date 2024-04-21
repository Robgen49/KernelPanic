//
//  MemberCell.swift
//  Hackathon2024
//
//  Created by Николай Прощалыкин on 21.04.2024.
//

import UIKit

final class MemberCell: UITableViewCell {
    
    private lazy var memberPhoto: UIImageView = {
        let image = UIImage(systemName: "person.crop.circle")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.snp.makeConstraints { make in
            make.height.width.equalTo(50)
        }
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25
        
        return imageView
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Фамилия Имя Отчество"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        addViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData(image: String, fio: String) {
        memberPhoto.image = UIImage(named: image)
        fullNameLabel.text = fio
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

extension MemberCell {
    
    func configure() {
        contentView.backgroundColor = .white
    }
    
    func addViews() {
        [memberPhoto, fullNameLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    func layoutViews() {
        memberPhoto.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
        }
        
        fullNameLabel.snp.makeConstraints { make in
            make.left.equalTo(memberPhoto.snp.right).offset(20)
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalTo(memberPhoto.snp.centerY)
        }
    }
}
