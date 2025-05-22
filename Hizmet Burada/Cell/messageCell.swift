//
//  messageCell.swift
//  Hizmet Burada
//
//  Created by turan on 25.10.2024.
//
import UIKit
import FirebaseStorage

class messageCell: UITableViewCell {
    
    // Örneğin, her hücrede gösterilecek metin
    var question: ChatModel? {
        didSet {
            question?.timestamp
        }
    }
    var model: User? {
        didSet {
            
            nameSurname.text = model?.nameSurname
            

  
        }
        
        
    }
    
    var lastMessage : LastMessage? {
        
        
        didSet {
            
            chat.text = lastMessage?.text
            

  
        }
    }

    lazy var container: UIView = {
        let container = UIView()
        container.layer.cornerRadius = 6
        return container
    }()
    
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle") // Örnek profil resmi
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20 // Yuvarlak profil resmi
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    private let nameSurname: UILabel = {
        let nameSurname = UILabel()
        nameSurname.translatesAutoresizingMaskIntoConstraints = false
        nameSurname.textAlignment = .left
        nameSurname.font = UIFont(name: "Avenir-Medium", size: 14)
        return nameSurname
    }()
    
    private let chat: UILabel = {
        let chat = UILabel()
        chat.translatesAutoresizingMaskIntoConstraints = false
        chat.textAlignment = .left
        chat.text = "Estağfirullah kolay gelsin"
        chat.font = UIFont(name: "Avenir", size: 10)
        return chat
    }()


    private let date: UILabel = {
        let date = UILabel()
        date.translatesAutoresizingMaskIntoConstraints = false
        date.textAlignment = .left
        date.text = "14:46"
        date.font = UIFont(name: "Avenir", size: 9)
        return date
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        setupViews()
        fetchProfileImage()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubview(container)
        container.addSubview(profileImageView)
        container.addSubview(nameSurname)
        container.addSubview(chat)
        container.addSubview(date)
        container.anchor(top: contentView.topAnchor,
                         bottom: contentView.bottomAnchor,
                         leading: contentView.leadingAnchor,
                         trailing: nil,
                         padding: .init(top: 6, left: 6, bottom: 0, right: 0))
        
        container.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        container.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        
 
        
        nameSurname.anchor(top: profileImageView.topAnchor,
                     bottom: nil,
                     leading: profileImageView.trailingAnchor,
                     trailing: container.trailingAnchor,
                     padding: .init(top: 0, left: 12, bottom: 0, right: 0))
        

        
        
        chat.anchor(top: nameSurname.bottomAnchor, bottom: nil, leading: nameSurname.leadingAnchor, trailing: container.trailingAnchor,padding: .init(top: 2, left: 0, bottom: 0, right: 0))
        
        profileImageView.anchor(top: nil, bottom: nil, leading: container.leadingAnchor, trailing: nil,padding: .init(top: 8, left: 8, bottom: 0, right: 0),size: .init(width: 40, height: 40))
        profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        
        date.anchor(top: nameSurname.topAnchor, bottom: nil, leading: nil, trailing: container.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 12))
        
    }

    @objc func checkBoxTapped() {
 
    }
    
   
    
    
    func fetchProfileImage() {
        // Firebase Storage referansı
        let image = model?.profileImage
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

