//
//  Profile.swift
//  Hizmet Burada
//
//  Created by turan on 5.11.2023.
//


import UIKit
import Firebase

import FirebaseStorage
import JGProgressHUD



class ProfilePage: UIViewController ,UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    lazy var progresBar: JGProgressHUD = {
        let progresBar = JGProgressHUD(style: .light)
        progresBar.textLabel.text = "Yükleniyor..."
        return progresBar
    }()
    
    var userProfile = [ProfilItem]()
    
   
    var selectedImage: UIImage?
    var imageUrl : String?
    
    
    lazy var container:UIView = {
        let container = UIView()
        return container
    }()
    
    lazy var containerProfile:UIView = {
        let container = UIView()
        return container
    }()
    
    lazy var stackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 6
        return stackView
    }()
    
    lazy var profileImage: UIImageView = {
        let profileImage = UIImageView()
        profileImage.image = UIImage(systemName:"plus")
        profileImage.tintColor = .black
        profileImage.contentMode = .scaleAspectFill
        profileImage.layer.cornerRadius = 50 // Dairenin yarıçapı (yuvarlak kenarlar)
        profileImage.clipsToBounds = true
        
        // Kenarlık ekleme
        profileImage.layer.borderColor = UIColor.gray.cgColor // Kenarlık rengi
        profileImage.layer.borderWidth = 2.0 // Kenarlık kalınlığı
        profileImage.tintColor = UIColor(hex: "40A6F8")
        
        // Görsele tıklanabilirlik ekleniyor
        profileImage.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        profileImage.addGestureRecognizer(tapGesture)

        return profileImage
    }()
    
    lazy var infoText:UITextView = {
        let infoText = UITextView()
        infoText.text = "Giriş yapınca profilini buradan\ndüzenleyebilirsin."
        infoText.textColor = .black
        infoText.textAlignment = .center
        infoText.font = UIFont(name: "Avenir", size: 10.5)
        infoText.isEditable = false
        return infoText
    }()
    
    lazy var registerBtn:UIButton = {
        let registerBtn = UIButton()
        registerBtn.setTitle("Üye Ol", for: .normal)
        registerBtn.backgroundColor = UIColor(hex: "#E3F2FD")
        registerBtn.setTitleShadowColor(.white, for: .focused)
        registerBtn.addTarget(self, action: #selector(registerClick), for: .touchUpInside)
        registerBtn.setTitleColor(UIColor(hex: "40A6F8"), for: .normal)
        registerBtn.setTitleColor(.white, for: .highlighted)
        registerBtn.isEnabled = true
        registerBtn.titleLabel?.font = UIFont(name: "Avenir", size: 14)
        registerBtn.layer.cornerRadius = 6
        return registerBtn
    }()
    
    lazy var loginBtn:UIButton = {
        let loginBtn = UIButton()
        loginBtn.setTitle("Giriş Yap", for: .normal)
        loginBtn.backgroundColor = UIColor(hex: "#E3F2FD")
        loginBtn.setTitleColor(UIColor(hex: "40A6F8"), for: .normal)
        loginBtn.setTitleColor(.white, for: .highlighted)
        loginBtn.layer.cornerRadius = 6

        loginBtn.addTarget(self, action: #selector(loginClick), for: .touchUpInside)
     
        loginBtn.titleLabel?.font = UIFont(name: "Avenir", size: 14)
        return loginBtn
    }()
    
    lazy var logo:UIImageView = {
          let logo = UIImageView()
          logo.image = UIImage(named: "12144997_Wavy_Cst-01_Single-09")
          logo.contentMode = .scaleAspectFill
          return logo
      }()
    

    
    lazy var nameSurname:UITextView = {
        let nameSurname = UITextView()
        nameSurname.backgroundColor = UIColor.clear
        nameSurname.font = UIFont.boldSystemFont(ofSize: 24)
        nameSurname.isEditable = false
        nameSurname.textAlignment = .center
        nameSurname.font = UIFont(name: "Avenir-Medium", size: 16)
       
        return nameSurname
    }()
    
    lazy var accountİnformation:UIButton = {
        let accountİnformation = UIButton()
        accountİnformation.setTitle("Giriş Yap", for: .normal)
        accountİnformation.backgroundColor = .red
        accountİnformation.setTitleShadowColor(.white, for: .focused)
        accountİnformation.setTitleColor(.white, for: .normal)
        accountİnformation.setTitleColor(.red, for: .highlighted)
        accountİnformation.isEnabled = true
        accountİnformation.layer.cornerRadius = 4
        return accountİnformation
    }()
    
    lazy var tableView: UITableView = {
           let tableView = UITableView()
        tableView.delegate = self
        tableView.backgroundColor = UIColor(hex: "#F1FAFE")
        tableView.dataSource = self
        tableView.register(Profile.self, forCellReuseIdentifier: "cell")
           return tableView
       }()
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            view.backgroundColor = UIColor(hex: "#F1FAFE")
            if navigationController != nil {
                self.navigationController?.setNavigationBarHidden(true, animated: true)
                self.navigationController?.isNavigationBarHidden = true
            }
        if UserManager.shared.checkUserLoginStatus(){
            container.isHidden = true
            containerProfile.isHidden = false
        }
        else{
            container.isHidden = false
            containerProfile.isHidden = true
            
        }
        
        nameSurname.text = UserManager.shared.getUser().nameSurname
      
        }
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProfileImage()
        tableView.backgroundColor = UIColor(hex: "#F1FAFE")
        desing()
    }
    
    func desing (){
        navigationItem.title = ""
        self.navigationController?.isNavigationBarHidden = true
        view.addSubview(container)
        view.addSubview(containerProfile)
        containerProfile.addSubview(profileImage)
        containerProfile.addSubview(nameSurname)
        containerProfile.addSubview(tableView)
        stackView.addArrangedSubview(registerBtn)
        stackView.addArrangedSubview(loginBtn)
        container.addSubview(stackView)
        view.backgroundColor = .white
        container.addSubview(logo)
        container.addSubview(infoText)
        
        
        logo.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                    bottom: infoText.topAnchor,
                    leading: container.leadingAnchor,
                    trailing: container.trailingAnchor,
                    padding: .init(top: 10, left: 60, bottom:6, right: 60),
                    size: .init(width: 0, height: 0))

        
        
        container.anchor(top: view.topAnchor,
                         bottom: view.bottomAnchor,
                         leading: view.leadingAnchor,
                         trailing: view.trailingAnchor)
        
        containerProfile.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         bottom: view.bottomAnchor,
                         leading: view.leadingAnchor,
                         trailing: view.trailingAnchor)
        
        profileImage.anchor(top: containerProfile.topAnchor,
                            bottom: nil,
                            leading: nil,
                            trailing: nil,
                            padding: .init(top: 12, left: 0, bottom: 0, right: 0),
                            size: .init(width: 140, height: 140)
                           )
        profileImage.centerXAnchor.constraint(equalTo: containerProfile.centerXAnchor).isActive = true
        
        nameSurname.anchor(top: profileImage.bottomAnchor,
                           bottom: nil,
                           leading: containerProfile.leadingAnchor,
                           trailing: containerProfile.trailingAnchor,
                           size: .init(width: 0, height: 40))
        
        tableView.anchor(top: nameSurname.bottomAnchor,
                         bottom: containerProfile.bottomAnchor,
                         leading: containerProfile.leadingAnchor,
                         trailing: containerProfile.trailingAnchor)
        stackView.anchor(top: nil,
                         bottom: nil,
                         leading: container.leadingAnchor,
                         trailing: container.trailingAnchor,
                         padding: .init(top: 0, left: 32, bottom: 0, right: 32),
                         size: .init(width: 0, height: 80))
        stackView.centerAnchor()
        
       
        profileImage.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                            bottom: nil,
                            leading: nil,
                            trailing: nil,
                            padding: .init(top: 15, left: 0, bottom: 0, right: 0),
                            size: .init(width: 120, height: 120))
        
        profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        infoText.anchor(top: nil,
                        bottom: stackView.topAnchor,
                        leading: stackView.leadingAnchor,
                        trailing: stackView.trailingAnchor,
                        padding: .init(top: 0, left: 0, bottom: 16, right: 0),
                        size: .init(width: 0, height: 60))
    }

    @objc func registerClick(click :UIButton!){
        print("kayıt olundu")
        navigationItem.title = ""
        navigationController?.navigationBar.tintColor = .black
        navigationController?.pushViewController(RecipientName(), animated: true)
    }
    
    @objc func loginClick(click :UIButton!){
        print("giriş yapıldı")
        navigationItem.title = ""
        navigationController?.navigationBar.tintColor = .black
        navigationController?.pushViewController(LoginPage(), animated: true)
    }
   
    @objc func passwordtBtnClick(click : UIButton!){
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userProfile.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Profile
        cell.configure(with: userProfile[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        // Seçilen hücreye animasyon ekle (arka plan rengi değişikliği)
        UIView.animate(withDuration: 0.3, animations: {
            cell?.backgroundColor = UIColor.lightGray // contentView yerine backgroundColor kullandık
        }) { _ in
            UIView.animate(withDuration: 0.3) {
                cell?.backgroundColor = UIColor.white
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
        case 5:
            loguth()
        default:
            break
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50 // Hücre yüksekliği
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Hücrelerin yüklenme animasyonu
        cell.alpha = 0
      
        UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row), animations: {
            cell.alpha = 1
        })
    }



    func loguth(){
        
        do {
            try Auth.auth().signOut()
            UserManager.shared.isLogouth()
            navigationController?.pushViewController(SplashScreen(), animated: true)
                   
               } catch let signOutError as NSError {
                   print("Çıkış yaparken hata oluştu: \(signOutError.localizedDescription)")
               }
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
    
    
    func fetchProfileImage() {
        progresBar.show(in: self.view)
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
                    self.profileImage.image = UIImage(data: data)
                    self.progresBar.dismiss(afterDelay: 1.0)
                }
            }
        }
    }
    
    
    
    }
