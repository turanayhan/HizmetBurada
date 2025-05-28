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
        infoText.backgroundColor = .clear
        infoText.font = UIFont(name: "Helvetica-Bold", size: 14)
        infoText.isEditable = false
        return infoText
    }()
    
    lazy var nameSurnameText2:UITextView = {
        let infoText = UITextView()
        infoText.text = "Müşteriler, profilinizde ve teklif mesajlarınızda adınızı görecekler. İsminizin ve soyisminizin baş harflerini büyük yazmanız, daha profesyonel \nbir izlenim bırakacaktır."
        infoText.textColor = .black
        infoText.textAlignment = .center
        infoText.backgroundColor = .clear
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
        nameSurname.tintColor = .btnBlue
        nameSurname.font = UIFont(name: "Avenir", size: 12)
        nameSurname.layer.borderWidth = 0.6 // Sınır kalınlığı
        nameSurname.layer.borderColor = UIColor.borderColor.cgColor // İstediğiniz renk
        nameSurname.layer.cornerRadius = 5//
        nameSurname.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        nameSurname.setPadding(left: 10, right: 0, top: 0, bottom: 0)
        return nameSurname
    }()
    
    lazy var surname:UITextField = {
        let surname = UITextField()
        surname.placeholder = "Soyad"
        surname.font = UIFont(name: "Avenir", size: 12)
        surname.borderStyle = .roundedRect
        surname.tintColor = .btnBlue
        surname.setPadding(left: 10, right: 0, top: 0, bottom: 0)
        surname.layer.borderWidth = 0.6 // Sınır kalınlığı
        surname.layer.borderColor = UIColor.borderColor.cgColor // İstediğiniz renk
        surname.layer.cornerRadius = 5//
        surname.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return surname
    }()
    
    
    
    
    
    lazy var nextBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .btnBlue
        btn.layer.cornerRadius = 8
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.3
        btn.layer.shadowOffset = CGSize(width: 3, height: 3)
        btn.layer.shadowRadius = 5
        btn.layer.masksToBounds = false
        btn.alpha = 0.5
        btn.setTitle("Devam", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 12)
        btn.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)

        // Ok ikonu
        let arrowImageView = UIImageView(image: UIImage(systemName: "arrow.right"))
        arrowImageView.tintColor = .white
        arrowImageView.contentMode = .scaleAspectFit
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false

        // Butona ekle
        btn.addSubview(arrowImageView)

        // Auto Layout ile hizalama
        NSLayoutConstraint.activate([
            arrowImageView.centerYAnchor.constraint(equalTo: btn.centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: btn.trailingAnchor, constant: -16), // Sağdan 16 birim içerde
            arrowImageView.widthAnchor.constraint(equalToConstant: 18),
            arrowImageView.heightAnchor.constraint(equalToConstant: 18)
        ])

        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        setupCustomBackButton(with: "Hizmet Burada")
        view.backgroundColor = .backgroundColorWhite
        view.addSubview(profileImage)
        stackView.addArrangedSubview(name)
        stackView.addArrangedSubview(surname)
        view.addSubview(stackView)
        view.addSubview(nextBtn)
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
        
        
        
        nextBtn.anchor(top: nil,
                           bottom: view.safeAreaLayoutGuide.bottomAnchor,
                           leading: stackView.leadingAnchor,
                           trailing: stackView.trailingAnchor,
                           padding: .init(top: 0, left: 0, bottom:22, right: 0),
                       size: .init(width: 0, height: 36))
        
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        if name.text!.isEmpty  {
            nextBtn.isEnabled = false
        
            
            nextBtn.alpha = 0.5
            
        } else {
            nextBtn.isEnabled = true
          
            nextBtn.alpha = 1
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
