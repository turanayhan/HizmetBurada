//
//  ProviderName.swift
//  Hizmet Burada
//
//  Created by turan on 17.10.2024.
//

import UIKit
import FirebaseAuth
import Firebase
import JGProgressHUD

class ProviderName: UIViewController {
    
    
    
    lazy var progresBar:JGProgressHUD = {
        let progresBar = JGProgressHUD(style: .light)
        progresBar.textLabel.text = "Kaydınız Gerçekleşiyor"
        return  progresBar
    }()
    
    lazy var profileImage:UIImageView = {
        let profileImage = UIImageView()
        profileImage.image = UIImage(named: "logo2")
        profileImage.contentMode = .scaleAspectFill
        profileImage.contentMode = .scaleAspectFill
        profileImage.layer.cornerRadius = 75
        profileImage.clipsToBounds = true
        profileImage.image = UIImage(named: "profile_placeholder")
        return profileImage
    }()
    
    
    lazy var nameSurnameText:UITextView = {
        let infoText = UITextView()
        infoText.text = "Adın ve soyadın nedir?"
        infoText.textColor = .black
        infoText.textAlignment = .center
        infoText.backgroundColor = UIColor(hex: "#F1FAFE")
        infoText.font = UIFont(name: "Helvetica-Bold", size: 16)
        infoText.isEditable = false
        return infoText
    }()
    
    lazy var nameSurnameText2:UITextView = {
        let infoText = UITextView()
        infoText.text = "Müşteriler, profilinizde ve teklif mesajlarınızda adınızı görecekler. İsminizin ve soyisminizin baş harflerini büyük yazmanız, daha profesyonel \nbir izlenim bırakacaktır."
        infoText.textColor = .black
        infoText.textAlignment = .center
        infoText.backgroundColor = UIColor(hex: "#F1FAFE")
        infoText.font = UIFont(name: "Avenir", size: 11)
        infoText.isEditable = false
        return infoText
    }()
    
    lazy var stackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 9
        return stackView
    }()
    
    lazy var name:UITextField = {
        let nameSurname = UITextField()
        nameSurname.placeholder = "Ad"
        nameSurname.borderStyle = .roundedRect
        nameSurname.font = UIFont(name: "Avenir", size: 14)
        nameSurname.layer.borderWidth = 0.6 // Sınır kalınlığı
        nameSurname.layer.borderColor = UIColor(hex: "40A6F8").cgColor // İstediğiniz renk
        nameSurname.layer.cornerRadius = 5//
        nameSurname.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return nameSurname
    }()
    
    lazy var surname:UITextField = {
        let surname = UITextField()
        surname.placeholder = "Soyad"
        surname.font = UIFont(name: "Avenir", size: 14)
        surname.borderStyle = .roundedRect
        surname.layer.borderWidth = 0.6 // Sınır kalınlığı
        surname.layer.borderColor = UIColor(hex: "40A6F8").cgColor // İstediğiniz renk
        surname.layer.cornerRadius = 5//
        surname.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return surname
    }()
    
    
    
    
    lazy var registerBtn:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Devam", for: .normal)
        button.alpha = 0.5
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
  
        setupCustomBackButton(with: "")
        view.backgroundColor = UIColor(hex: "#F1FAFE")
        view.addSubview(profileImage)
        stackView.addArrangedSubview(name)
        stackView.addArrangedSubview(surname)
        view.addSubview(stackView)
        view.addSubview(registerBtn)
        view.addSubview(nameSurnameText)
        view.addSubview(nameSurnameText2)
        
        desing()
    }
    
    func desing(){
        
        nameSurnameText.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 10, left: 0, bottom: 0, right: 0),size: .init(width: 0, height: 40))
        
        nameSurnameText2.anchor(top: nameSurnameText.bottomAnchor,
                                bottom: nil,
                                leading: view.leadingAnchor,
                                trailing: view.trailingAnchor,
                                padding: .init(top: 0, left: 0, bottom: 0,
                                               right: 0),size: .init(width: 0, height: 80))
        
        stackView.anchor(top: nameSurnameText2.bottomAnchor,
                         bottom: nil,
                         leading: view.leadingAnchor,
                         trailing: view.trailingAnchor,
                         padding: .init(top: 0, left: 36, bottom: 0, right: 36),
                         size: .init(width: 0, height: 80))
        
        
        
        registerBtn.anchor(top: nil,
                           bottom: view.safeAreaLayoutGuide.bottomAnchor,
                           leading: stackView.leadingAnchor,
                           trailing: stackView.trailingAnchor,
                           padding: .init(top: 0, left: 0, bottom:22, right: 0))
        
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        if name.text!.isEmpty  {
            registerBtn.isEnabled = false
        
            
            registerBtn.alpha = 0.5
            
        } else {
            registerBtn.isEnabled = true
          
            registerBtn.alpha = 1
        }
    }
    
    @objc func nextButtonTapped(click : UIButton!) {
        guard let ad = name.text, !ad.isEmpty, let soyad = surname.text, !soyad.isEmpty else {
            // Uyarı mesajı göster
            let alert = UIAlertController(title: "Eksik Bilgi", message: "Lütfen hem adınızı hem de soyadınızı girin.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        // Eğer text alanları boş değilse, kaydı tamamla ve bir sonraki sayfaya git
        ServiceProviderRegistration.rgİnformation.nameSurname = "\(ad) \(soyad)"
        navigationController?.pushViewController(ProviderGsm(), animated: true)
    }
    


    
}
