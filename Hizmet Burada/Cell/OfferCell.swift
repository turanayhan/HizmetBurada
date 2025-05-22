//
//  OfferCell.swift
//  Hizmet Burada
//
//  Created by turan on 23.10.2024.
//

//
//  Comment.swift
//  Hizmet Burada
//
//  Created by turan on 14.11.2023.
//

import Foundation
import UIKit
import FirebaseStorage



protocol OfferCellDelegate: AnyObject {
    func didTapButton(in cell: OfferCell)
}



class OfferCell: UICollectionViewCell {
    
    
    weak var delegate: OfferCellDelegate?
    
    
    var modelic : BidModel? {
           didSet {
               if let model = modelic{
                   titleLabel.text = model.providerName
                   
                   
               }
        
           }
       }
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle") // Örnek profil resmi
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12 // Yuvarlak profil resmi
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    
    lazy var titleLabel: UILabel = {
           let label = UILabel()
           label.font = UIFont(name: "Avenir", size: 14)
           label.numberOfLines = 0
           label.textAlignment = .left
           label.text = "Turan Ayhan"
           label.backgroundColor = UIColor.clear
           return label
       }()

    lazy var date: UILabel = {
           let date = UILabel()
           date.backgroundColor = UIColor.clear
           date.textAlignment = .right
           date.text = "14 Kasım 2023"
           date.font = UIFont(name: "Avenir", size: 8)
           return date
       }()
    
    let commentStar1: UIImageView = {
        let commentStar = UIImageView()
        commentStar.tintColor = UIColor(hex: "#40A6F8")
        commentStar.image = UIImage(systemName: "star.fill")
        commentStar.contentMode = .scaleAspectFit // Orantılı ölçekleme
        commentStar.translatesAutoresizingMaskIntoConstraints = false // Auto Layout kullanmak için
        commentStar.widthAnchor.constraint(equalToConstant: 9).isActive = true // Genişlik ayarı
        commentStar.heightAnchor.constraint(equalToConstant: 9).isActive = true // Yükseklik ayarı
        return commentStar
    }()

    let commentStar2: UIImageView = {
        let commentStar = UIImageView()
        commentStar.image = UIImage(systemName: "star.fill")
        commentStar.contentMode = .scaleAspectFit
        commentStar.tintColor = UIColor(hex: "#40A6F8")
        commentStar.translatesAutoresizingMaskIntoConstraints = false
        commentStar.widthAnchor.constraint(equalToConstant: 9).isActive = true
        commentStar.heightAnchor.constraint(equalToConstant: 9).isActive = true
        return commentStar
    }()

    let commentStar3: UIImageView = {
        let commentStar = UIImageView()
        commentStar.image = UIImage(systemName: "star.fill")
        commentStar.contentMode = .scaleAspectFit
        commentStar.tintColor = UIColor(hex: "#40A6F8")
        commentStar.translatesAutoresizingMaskIntoConstraints = false
        commentStar.widthAnchor.constraint(equalToConstant: 9).isActive = true
        commentStar.heightAnchor.constraint(equalToConstant: 9).isActive = true
        return commentStar
    }()

    let commentStar4: UIImageView = {
        let commentStar = UIImageView()
        commentStar.image = UIImage(systemName: "star.fill")
        commentStar.contentMode = .scaleAspectFit
        commentStar.tintColor = UIColor(hex: "#40A6F8")
        commentStar.translatesAutoresizingMaskIntoConstraints = false
        commentStar.widthAnchor.constraint(equalToConstant: 9).isActive = true
        commentStar.heightAnchor.constraint(equalToConstant: 9).isActive = true
        return commentStar
    }()

    let commentStar5: UIImageView = {
        let commentStar = UIImageView()
        commentStar.image = UIImage(systemName: "star.fill")
        commentStar.contentMode = .scaleAspectFit
        commentStar.tintColor = UIColor(hex: "#40A6F8")
        commentStar.translatesAutoresizingMaskIntoConstraints = false
        commentStar.widthAnchor.constraint(equalToConstant: 9).isActive = true
        commentStar.heightAnchor.constraint(equalToConstant: 9).isActive = true
        return commentStar
    }()
    
    // StackView oluşturma
    let commentStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal // Dikey veya yatay olabileceğini belirleyin
        stackView.distribution = .fillEqually // Elemanların eşit dağıtılmasını sağlar
        stackView.spacing = 2 // Elemanlar arasındaki boşluk
        return stackView
    }()
    
  
    
    lazy var commentText: UITextView = {
        let commentText = UITextView()
        commentText.isEditable = false
        commentText.isScrollEnabled = false
        commentText.textAlignment = .left
        commentText.backgroundColor = UIColor.clear
        commentText.text = "Teklif edilen fiyat: 1200 TL"
        commentText.font = UIFont(name: "Avenir", size: 10)
        return commentText
    }()
   
    lazy var about:UILabel = {
        let about = UILabel()
        about.text = "Hakkında"
        about.textColor = .black
        about.textAlignment = .left
        about.font = UIFont(name: "Avenir-Heavy", size: 10)
        return about
    }()
    lazy var activityTextofferMessage: UITextView = {
        let offerMessage = UITextView()
        offerMessage.isEditable = false
        offerMessage.isScrollEnabled = false
        offerMessage.textAlignment = .left
        offerMessage.backgroundColor = UIColor.clear
        offerMessage.text = "İhtiyacınız dahilinde gereği titizlikle yapılır."
        offerMessage.font = UIFont(name: "Avenir", size: 10)
        return offerMessage
    }()
    
    
    lazy var activity:UILabel = {
        let activity = UILabel()
        activity.text = "Aktivite"
        activity.textColor = .black
        activity.textAlignment = .left
        activity.font = UIFont(name: "Avenir-Heavy", size: 10)
        return activity
    }()
    
    
    lazy var activityText: UITextView = {
        let activityText = UITextView()
           activityText.isEditable = false
           activityText.isScrollEnabled = false
           activityText.textAlignment = .left
           activityText.backgroundColor = UIColor.clear
           let checkmarkImage = UIImage(systemName: "briefcase")?.withRenderingMode(.alwaysOriginal)
           let imageAttachment = NSTextAttachment()
           imageAttachment.image = checkmarkImage
           imageAttachment.bounds = CGRect(x: 0, y: -2.5, width: 12, height: 12) // Yüksekliği ayarlayın
           let attributedString = NSMutableAttributedString()
           attributedString.append(NSAttributedString(attachment: imageAttachment))
           attributedString.append(NSAttributedString(string: "  0 iş tamamladı")) // Simgeden sonra metin ekleyin
           activityText.attributedText = attributedString
           activityText.font = UIFont(name: "Avenir", size: 10)
           return activityText
    }()
    
    lazy var serviceAreas:UILabel = {
        let serviceAreas = UILabel()
        serviceAreas.text = "Hizmet Alanları"
        serviceAreas.textColor = .black
        serviceAreas.textAlignment = .left
        serviceAreas.font = UIFont(name: "Avenir-Heavy", size: 10)
        return serviceAreas
    }()
    
    lazy var serviceAreasText: UITextView = {
        let serviceAreasText = UITextView()
        serviceAreasText.isEditable = false
        serviceAreasText.isScrollEnabled = false
        serviceAreasText.textAlignment = .left
        serviceAreasText.backgroundColor = UIColor.clear
           let checkmarkImage = UIImage(systemName: "hammer")?.withRenderingMode(.alwaysOriginal)
           let imageAttachment = NSTextAttachment()
           imageAttachment.image = checkmarkImage
           imageAttachment.bounds = CGRect(x: 0, y: -2.5, width: 12, height: 12) // Yüksekliği ayarlayın
           let attributedString = NSMutableAttributedString()
           attributedString.append(NSAttributedString(attachment: imageAttachment))
           attributedString.append(NSAttributedString(string: "  Boyacı")) // Simgeden sonra metin ekleyin
        serviceAreasText.attributedText = attributedString
        serviceAreasText.font = UIFont(name: "Avenir", size: 10)
           return serviceAreasText
    }()
    
    lazy var location:UILabel = {
        let location = UILabel()
        location.text = "Konum"
        location.textColor = .black
        location.textAlignment = .left
        location.font = UIFont(name: "Avenir-Heavy", size: 10)
        return location
    }()
    
    lazy var locationText:UITextView = {
        let locationText = UITextView()
        locationText.isEditable = false
        locationText.isScrollEnabled = false
        locationText.textAlignment = .left
        locationText.backgroundColor = UIColor.clear
           let checkmarkImage = UIImage(systemName: "location.fill")?.withRenderingMode(.alwaysOriginal)
           let imageAttachment = NSTextAttachment()
           imageAttachment.image = checkmarkImage
           imageAttachment.bounds = CGRect(x: 0, y: -2.5, width: 12, height: 12) // Yüksekliği ayarlayın
           let attributedString = NSMutableAttributedString()
           attributedString.append(NSAttributedString(attachment: imageAttachment))
           attributedString.append(NSAttributedString(string: "  Yeşilyurt,Malatya")) // Simgeden sonra metin ekleyin
        locationText.attributedText = attributedString
        locationText.font = UIFont(name: "Avenir", size: 10)
           return locationText
    }()
    
    
    lazy var offerText:UILabel = {
        let offerText = UILabel()
        offerText.text = "Teklif Fiyatı"
        offerText.textColor = .black
        offerText.textAlignment = .left
        offerText.font = UIFont(name: "Avenir-Heavy", size: 10)
        return offerText
    }()
    
    lazy var offerText2: UITextView = {
        let offerText2 = UITextView()
        offerText2.isEditable = false
        offerText2.isScrollEnabled = false
        offerText2.textAlignment = .left
        offerText2.backgroundColor = UIColor.clear

        // Simgeyi oluşturun
        let checkmarkImage = UIImage(systemName: "tag")?.withRenderingMode(.alwaysOriginal)
        
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = checkmarkImage
        imageAttachment.bounds = CGRect(x: 0, y: -2.5, width: 12, height: 12) // Yüksekliği ayarlayın

        // Atıf metni oluşturun
        let attributedString = NSMutableAttributedString()
        attributedString.append(NSAttributedString(attachment: imageAttachment))
        
        // Fiyat metni oluşturun ve altını çizin
        let priceString = NSAttributedString(string: "  2000", attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
        attributedString.append(priceString) // Simgeden sonra metin ekleyin

        offerText2.attributedText = attributedString
        offerText2.font = UIFont(name: "Avenir", size: 10)

        return offerText2
    }()

    
    
    lazy var stackView: UIStackView = {
         let stackView = UIStackView()
         stackView.axis = .vertical // Dikey yerleşim
         stackView.spacing = 0 // Elemanlar arasındaki boşluk
         stackView.translatesAutoresizingMaskIntoConstraints = false // Auto Layout için
         return stackView
     }()
    
    let communicationBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("İletişime Geç", for: .normal)
        button.setTitleColor(UIColor(hex: "E3F2FD"), for: .normal)
        button.backgroundColor = UIColor(hex: "#40A6F8")
        button.layer.cornerRadius = 4
        button.titleLabel?.font = UIFont(name: "Avenir", size: 12)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
           return button
       }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 0.3
        contentView.layer.borderColor =  UIColor.lightGray.cgColor
        stackView.addArrangedSubview(about)
        stackView.addArrangedSubview(activityTextofferMessage)
        stackView.addArrangedSubview(activity)
        stackView.addArrangedSubview(activityText)
        stackView.addArrangedSubview(serviceAreas)
        stackView.addArrangedSubview(serviceAreasText)
        stackView.addArrangedSubview(location)
        stackView.addArrangedSubview(locationText)
        stackView.addArrangedSubview(offerText)
        stackView.addArrangedSubview(offerText2)
        contentView.addSubview(profileImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(date)
        contentView.addSubview(commentStack)
        commentStack.addArrangedSubview(commentStar1)
        commentStack.addArrangedSubview(commentStar2)
        commentStack.addArrangedSubview(commentStar3)
        commentStack.addArrangedSubview(commentStar4)
        commentStack.addArrangedSubview(commentStar5)

        contentView.addSubview(stackView)
        contentView.addSubview(communicationBtn)
        fetchProfileImage()
        desing()
        
  
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func nextButtonTapped() {
     
        delegate?.didTapButton(in: self)
        }
    
    func desing(){
        
        profileImageView.anchor(top: contentView.topAnchor, bottom: nil, leading: contentView.leadingAnchor, trailing: nil,padding: .init(top: 8, left: 8, bottom: 0, right: 0),size: .init(width: 24, height: 24))
        
        titleLabel.anchor(top: profileImageView.topAnchor,
                          bottom: nil,
                          leading: profileImageView.trailingAnchor,
                          trailing: contentView.trailingAnchor,padding: .init(top: 0, left: 6, bottom: 0, right: 0),
                          size: .init(width: 0, height: 0)
        )
        
        commentStack.anchor(top: titleLabel.bottomAnchor, bottom: nil, leading: profileImageView.trailingAnchor, trailing: nil,padding: .init(top: 0, left: 7, bottom: 0, right: 0),size: .init(width: 0, height: 0))
     
        date.anchor(top: titleLabel.topAnchor,
                    bottom: titleLabel.bottomAnchor,
                    leading:nil,
                    trailing: contentView.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 6))
        
        
        stackView.anchor(top: profileImageView.bottomAnchor, bottom: nil, leading: profileImageView.leadingAnchor, trailing: contentView.trailingAnchor,padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        
        communicationBtn.anchor(top: nil, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor,padding: .init(top: 0, left: 16, bottom: 8, right: 18),size: .init(width: 0, height: 20))

        
        
    }
    
    
    func fetchProfileImage() {
        // Firebase Storage referansı
        let image = UserManager.shared.getUser().profileImage
        let storageRef = Storage.storage().reference(withPath: "ProfileImage/\(image).jpg")

        // URL'yi alma ve görseli yükleme
        storageRef.downloadURL { (url, error) in
            if let error = error {
                print("Error getting URL: \(error.localizedDescription)")
                return
            }

            guard let url = url else { return }
            self.loadImage(from: url)
        }
    }

    func loadImage(from url: URL) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.profileImageView.image = UIImage(data: data)
                }
            }
        }
    }
    


}
