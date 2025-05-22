//
//  ProfileCell.swift
//  Hizmet Burada
//
//  Created by turan on 18.11.2023.
//

import UIKit

class Profile: UITableViewCell {
    
 
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir", size: 15)
        
    
        return label
    }()
    
    lazy var logo:UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(systemName: "chevron.forward")
        logo.tintColor = UIColor(hex: "40A6F8")
        logo.contentMode = .scaleAspectFill
     
        return logo
        
    }()
    
    
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(hex: "#F1FAFE")
     
        addSubview(titleLabel)
        addSubview(logo)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
            
            
        ])
        
        logo.anchor(top: nil, bottom: nil, leading: nil, trailing: contentView.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 12),size: .init(width: 16, height: 16))
        logo.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with user: ProfilItem) {
        titleLabel.text = user.header
    }
    
    
    
}
