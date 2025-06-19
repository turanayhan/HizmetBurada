//
//  Comment.swift
//  Hizmet Burada
//
//   fgg

import Foundation
import UIKit
class Comment: UICollectionViewCell {
    
    var modelic : Comment2? {
           didSet {
      
               
               if let model = modelic{
                   titleLabel.text = modelic?.nameSurname
                   date.text = modelic?.date
                   commentText.text = modelic?.comment
                   
                   
               }
        
           }
       }
    
    lazy var titleLabel: UILabel = {
           let label = UILabel()
           label.font = UIFont(name: "Avenir", size: 14)
           label.numberOfLines = 0
           label.textAlignment = .center
           label.text = "Turan Ayhan"
           label.backgroundColor = UIColor.clear
           return label
       }()

    lazy var date: UITextView = {
           let date = UITextView()
           date.isEditable = false
           date.isScrollEnabled = false
           date.backgroundColor = UIColor.clear
           date.textAlignment = .center
           date.text = "14 Kasım 2023"
           date.font = UIFont(name: "Avenir", size: 8)
           return date
       }()
    
    lazy var commentStar: UIImageView = {
        let commentStar = UIImageView()
        commentStar.image = UIImage(systemName: "star.fill")
        return commentStar
    }()
    
    
    lazy var commentText: UITextView = {
        let commentText = UITextView()
        commentText.isEditable = false
        commentText.isScrollEnabled = false
        commentText.textAlignment = .center
        commentText.backgroundColor = UIColor.clear
        commentText.text = "Çok Memnun kaldım teşekkür ediyorum."
        commentText.font = UIFont(name: "Avenir", size: 10)
        return commentText
    }()
   
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = UIColor(red: 255/255, green: 250/255, blue: 250/255, alpha: 1.0)
        contentView.layer.borderWidth = 0.3
        contentView.layer.borderColor =  UIColor.lightGray.cgColor
        contentView.layer.cornerRadius = 6
        contentView.addSubview(titleLabel)
        contentView.addSubview(date)
        contentView.addSubview(commentStar)
        contentView.addSubview(commentText)
   
        
        desing()
        
  
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func desing(){
        
        titleLabel.anchor(top: contentView.topAnchor, 
                          bottom: nil,
                          leading: contentView.leadingAnchor,
                          trailing: contentView.trailingAnchor,
                          size: .init(width: 0, height: 30)
        )
     
        date.anchor(top: titleLabel.bottomAnchor,
                    bottom: nil,
                    leading:contentView.leadingAnchor,
                    trailing: contentView.trailingAnchor)
        
        commentStar.anchor(top: date.bottomAnchor, 
                           bottom: nil, leading: nil,
                           trailing: nil,
                           size: .init(width: 12,
                                       height: 12))
        commentStar.centerXAnchor.constraint(equalTo: date.centerXAnchor).isActive = true
        
        commentText.anchor(top: commentStar.bottomAnchor, bottom: nil, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor,padding: .init(top: 5, left: 25, bottom: 0, right: 25))
   

        
        
    }
    


}
