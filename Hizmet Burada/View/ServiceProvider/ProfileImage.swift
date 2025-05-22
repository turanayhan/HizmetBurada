//
//  ProfileImage.swift
//  Hizmet Burada
//
//  Created by turan on 14.10.2024.
//

import UIKit
import Firebase
import FirebaseStorage
import JGProgressHUD

class ProfileImage: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {


    let selectImageButton = UIButton()
    var selectedImage: UIImage?
    var imageUrl : String?
    
    lazy var progresBar: JGProgressHUD = {
        let progresBar = JGProgressHUD(style: .light)
        progresBar.textLabel.text = "Yükleniyor..."
        return progresBar
    }()
    
    lazy var profileImageText: UITextView = {
        let infoText = UITextView()
        infoText.text = "Profil fotoğrafınızı ekleyin:"
        infoText.textColor = .black
        infoText.textAlignment = .center
        infoText.backgroundColor = UIColor(hex: "#F1FAFE")
        infoText.font = UIFont(name: "Helvetica-Bold", size: 16)
        infoText.isEditable = false
        return infoText
    }()

    lazy var profileImageText2: UITextView = {
        let infoText = UITextView()
        infoText.text = "Müşterilerinizin sizi tanıyabilmesi için güncel bir profil fotoğrafı yükleyin.\n Fotoğrafınızın net ve profesyonel görünmesine dikkat edin."
        infoText.textColor = .black
        infoText.textAlignment = .center
        infoText.backgroundColor = UIColor(hex: "#F1FAFE")
        infoText.font = UIFont(name: "Avenir", size: 11)
        infoText.isEditable = false
        return infoText
    }()
    lazy var profileImage: UIImageView = {
        let profileImage = UIImageView()
        profileImage.image = UIImage(systemName:"plus")
        profileImage.tintColor = UIColor(hex: "40A6F8")
        profileImage.contentMode = .scaleAspectFill
        profileImage.layer.cornerRadius = 50 // Dairenin yarıçapı (yuvarlak kenarlar)
        profileImage.clipsToBounds = true
        
        // Kenarlık ekleme
        profileImage.layer.borderColor = UIColor(hex: "E3F2FD").cgColor// Kenarlık rengi
        profileImage.layer.borderWidth = 2.0 // Kenarlık kalınlığı
        
        // Görsele tıklanabilirlik ekleniyor
        profileImage.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        profileImage.addGestureRecognizer(tapGesture)

        return profileImage
    }()
    
    lazy var registerBtn:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Devam", for: .normal)
     
        button.alpha = 0.5
        button.isEnabled = false
        button.setTitleColor(UIColor(hex: "E3F2FD"), for: .normal)
        button.backgroundColor = UIColor(hex: "#40A6F8")
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 2
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
        
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hex: "#F1FAFE")
        setupCustomBackButton(with: "")
        view.addSubview(profileImageText)
        view.addSubview(profileImageText2)
        view.addSubview(profileImage)
        view.addSubview(registerBtn)
        desing()
    }
    

    
    
    func desing() {
        
        profileImageText.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 10, left: 0, bottom: 0, right: 0),size: .init(width: 0, height: 40))
        
        profileImageText2.anchor(top: profileImageText.bottomAnchor,
                                bottom: nil,
                                leading: view.leadingAnchor,
                                trailing: view.trailingAnchor,
                                padding: .init(top: 0, left: 0, bottom: 0,
                                               right: 0),size: .init(width: 0, height: 80))
        
        profileImage.anchor(top: profileImageText2.bottomAnchor, bottom: nil, leading: nil, trailing: nil,padding: .init(top: 15, left: 0, bottom: 0, right: 0),size: .init(width: 100, height: 100))
        
        profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
    
        registerBtn.anchor(top: nil,
                           bottom: view.safeAreaLayoutGuide.bottomAnchor,
                           leading: profileImageText.leadingAnchor,
                           trailing: profileImageText.trailingAnchor,
                           padding: .init(top: 0, left: 20, bottom:22, right: 20))

       
    
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
            profileImage.image = selectedImage
            
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
            self.registerBtn.alpha = 1
            self.registerBtn.isEnabled = true
            self.progresBar.dismiss(afterDelay: 1.0)
            print("Yükleme tamamlandı: \(metadata.path!)")
        }
    }
    
    @objc func nextButtonTapped(click : UIButton!) {
        self.navigationController?.pushViewController(ProviderLocation(), animated: true)
     
    }

}
