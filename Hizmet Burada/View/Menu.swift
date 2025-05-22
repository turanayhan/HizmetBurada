//
//  Untitled.swift
//  Hizmet Burada
//
//  Created by turan on 16.10.2024.

import UIKit
import JGProgressHUD
import FirebaseStorage







class Menu: UIViewController,UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
let screenHeight = UIScreen.main.bounds.height


    lazy var progresBar: JGProgressHUD = {
         let progresBar = JGProgressHUD(style: .light)
         progresBar.textLabel.text = "Yükleniyor..."
         return progresBar
     }()
     
    var userProfile = [ProfilItem]()
    var selectedImage: UIImage?
      var imageUrl : String?
    var model = UserManager.shared.getUser()
      
    
lazy var container :UIImageView = {
    
    let container = UIImageView()
    container.image = UIImage(named: "network-4348652_640") // Örnek profil
    container.contentMode = .scaleAspectFill
    container.clipsToBounds = true
    return container
}()

let profileImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: "person.circle") // Örnek profil resmi
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 25 // Yuvarlak profil resmi
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.isUserInteractionEnabled = true
    imageView.isUserInteractionEnabled = true
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectImage))
    imageView.addGestureRecognizer(tapGesture)
    return imageView
}()

lazy var nameSurnameText:UITextView = {
    let infoText = UITextView()
    infoText.text = model.nameSurname
    infoText.textColor = .white
    infoText.textAlignment = .left
    infoText.backgroundColor = .clear
    infoText.font = UIFont(name: "Avenir-medium", size: 14)
    infoText.isEditable = false
    return infoText
}()

lazy var mailText:UITextView = {
    let infoText = UITextView()
    infoText.text = model.email
    infoText.textColor = .white
    infoText.textAlignment = .left
    infoText.backgroundColor = .clear
    infoText.font = UIFont(name: "Avenir-medium", size: 12)
    infoText.isEditable = false
    return infoText
}()

let homeButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Home", for: .normal)
    button.addTarget(self, action: #selector(homeButtonTapped), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
}()
    
    lazy var tableView: UITableView = {
           let tableView = UITableView()
        tableView.delegate = self
        tableView.backgroundColor = UIColor(hex: "#F1FAFE")
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        
           return tableView
       }()

override func viewDidLoad() {
    super.viewDidLoad()
    userProfile.append(ProfilItem(id:0, header: "Kişisel Bilgiler", description: "İletişim ve Adress", logo: "person.fill"))
    
    userProfile.append(ProfilItem(id:1, header: "Hesap Ayarları", description: "Şifre ve Bildirimler", logo: "gear"))
    
    userProfile.append(ProfilItem(id:2, header: "Gizlilik Ayarları", description: "Veri ve İzinler", logo: "lock"))
    
    userProfile.append(ProfilItem(id:4, header: "Destek", description: "Yardım ve SSS", logo: "questionmark.circle"))
    
    userProfile.append(ProfilItem(id:6, header: "Çıkış Yap", description: "Hesabınızdan çıkış yapın", logo: "rectangle.portrait.and.arrow.right"))
    fetchProfileImage()


    view.layer.borderWidth = 0.2
    view.layer.borderColor = UIColor(hex: "#40A6F8").cgColor
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOpacity = 0.5
    view.layer.shadowOffset = CGSize(width: 0, height: 2)
    view.layer.shadowRadius = 4


    view.backgroundColor = UIColor(hex: "#F1FAFE")
    
    view.addSubview(container)
    container.addSubview(profileImageView)
    container.addSubview(nameSurnameText)
    container.addSubview(mailText)
    view.addSubview(tableView)
    desing()
    tableView.translatesAutoresizingMaskIntoConstraints = false
         
         // TableView Auto Layout ayarları
         NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: container.bottomAnchor),
             tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
         ])
         
         tableView.delegate = self
         tableView.dataSource = self
    
    
    
}

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userProfile.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.backgroundColor =  UIColor(hex: "#F1FAFE")
        cell.modelDetail = userProfile[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        // Seçilen hücreye animasyon ekle (arka plan rengi değişikliği)
        UIView.animate(withDuration: 0.3, animations: {
            cell?.backgroundColor = UIColor.lightGray // contentView yerine backgroundColor kullandık
        }) { _ in
            UIView.animate(withDuration: 0.3) {
                cell?.backgroundColor = UIColor(hex: "#F1FAFE") // Hücreyi tekrar ilk renginde döndür
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Hücre seçimine göre işlemler
        switch userProfile[indexPath.row].id {
        case 0:
            navigationController?.pushViewController(UserPage(), animated: true)
        case 1:
            print("Şifre değiştir")
            navigationController?.pushViewController(PasswordResetPage(), animated: true)

        case 2:
            print("Arkadaşlarına tavsiye et")
        case 3:
            print("Değerlendir")
        case 4:
            print("Haftanın beşinci günü")
      
        default:
            break
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70 // Hücre yüksekliği
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Hücrelerin yüklenme animasyonu
        cell.alpha = 0
      
        UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row), animations: {
            cell.alpha = 1
        })
    }

func desing(){
    
    container.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,size: .init(width: 0, height: screenHeight*0.25))
    
    
    profileImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: container.leadingAnchor, trailing: nil,padding: .init(top:0, left: 12, bottom: 0, right: 0),size: .init(width: 50, height: 50))
    nameSurnameText.anchor(top: profileImageView.bottomAnchor, bottom: nil, leading: profileImageView.leadingAnchor, trailing: container.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 0),size: .init(width: 0, height: 25))
    mailText.anchor(top: nameSurnameText.bottomAnchor, bottom: nil, leading: profileImageView.leadingAnchor, trailing: container.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 0),size: .init(width: 0, height: 25))
    
    

    
}

@objc func homeButtonTapped() {
    print("Home tapped")
    dismiss(animated: true, completion: nil)
}

@objc func settingsButtonTapped() {
    print("Settings tapped")
    dismiss(animated: true, completion: nil)
}

@objc func logoutButtonTapped() {
    print("Logout tapped")
    dismiss(animated: true, completion: nil)
}
    
    
    
    
    
    
    
    @objc func selectImage() {
         
           let imagePickerController = UIImagePickerController()
           imagePickerController.delegate = self
           imagePickerController.sourceType = .photoLibrary // Galeri kaynağı
           imagePickerController.allowsEditing = true // Düzenlemeye izin ver
           present(imagePickerController, animated: true, completion: nil)
       }
       
       // UIImagePickerControllerDelegate metodları
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           if let selectedImage = info[.originalImage] as? UIImage {
               self.selectedImage = selectedImage
               profileImageView.image = selectedImage
               
               // Görseli Firebase'e yükle
               uploadImageToFirebase(image: selectedImage)
           }
           dismiss(animated: true, completion: nil)
       }

       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           dismiss(animated: true, completion: nil)
       }
       
       func uploadImageToFirebase(image: UIImage) {
           progresBar.show(in: self.view)
           guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }
           let storage = Storage.storage()
           let storageRef = storage.reference()
           let imageRef = storageRef.child("ProfileImage/\(imageUrl).jpg")
           
           // Resmi yükleme
           let uploadTask = imageRef.putData(imageData, metadata: nil) { metadata, error in
               guard let metadata = metadata else {
                   // Hata durumunda burası çalışır
                   print("Hata: \(error?.localizedDescription ?? "Bilinmeyen hata")")
                   return
               }
        
            
           }
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


