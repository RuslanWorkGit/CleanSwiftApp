//
//  CustomCell.swift
//  TestTaskCleanSwift
//
//  Created by Ruslan Liulka on 26.04.2025.
//

import UIKit

class CustomCell: UITableViewCell {
    
    var characterImageView = UIImageView()
    var characterNameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(characterImageView)
        addSubview(characterNameLabel)
        
        configureImageView()
        configureNameLable()
        setImageConstraints()
        setNameLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not benn implemented")
    }
    
    func configure(with chardacter: CharacterList.CharacterDisplay) {
        characterNameLabel.text = chardacter.name
        
        if let imageData = chardacter.imageData {
            self.characterImageView.image = UIImage(data: imageData)
        } else if let urlString = chardacter.imageURL, let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, _ , error in
                if let data = data, let imageData = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.characterImageView.image = imageData
                    }
                }
            }.resume()
        }
        
//        if let url = URL(string: chardacter.image) {
//            URLSession.shared.dataTask(with: url) { data, _ , error in
//                if let data = data, let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//                        self.characterImageView.image = image
//                    }
//                }
//            }.resume()
//        }
    }
    
    func configureImageView() {
        characterImageView.contentMode = .scaleToFill
        characterImageView.layer.cornerRadius = 10
        characterImageView.clipsToBounds = true
        
    }
    
    func configureNameLable() {
        characterNameLabel.numberOfLines = 0
        characterNameLabel.adjustsFontSizeToFitWidth = true
    }
    
    func setImageConstraints() {
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            characterImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            characterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            characterImageView.heightAnchor.constraint(equalToConstant: 80),
            characterImageView.widthAnchor.constraint(equalTo: characterImageView.heightAnchor, multiplier: 4/3)
        ])
    }
    
    func setNameLabelConstraints() {
        characterNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            characterNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            characterNameLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 20),
            characterNameLabel.heightAnchor.constraint(equalToConstant: 80),
            characterNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        ])
    }
}
