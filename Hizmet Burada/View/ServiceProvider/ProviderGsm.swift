//
//  ProviderGsm.swift
//  Hizmet Burada
//
//  Created by turan on 17.10.2024.
//


//  rgPhone.swift
//  Hizmet Burada
//
//  Created by turan on 30.12.2023.
//

import UIKit
import JGProgressHUD

class ProviderGsm: UIViewController, UITextFieldDelegate {
    
    let maxGsmCharacters = 10

    // Progress bar
    lazy var progresBar:JGProgressHUD = {
        let progresBar = JGProgressHUD(style: .light)
        progresBar.textLabel.text = "Kaydınız Gerçekleşiyor"
        return  progresBar
    }()
    
    // Telefon sorusu text view
    lazy var gsmText:UITextView = {
        let infoText = UITextView()
        infoText.text = "Cep telefonun nedir?"
        infoText.textColor = .black
        infoText.textAlignment = .center
        infoText.backgroundColor = UIColor(hex: "#F1FAFE")
        infoText.font = UIFont(name: "Helvetica-Bold", size: 16)
        infoText.isEditable = false
        return infoText
    }()
    
    // Ek açıklama text view
    lazy var nameSurnameText2:UITextView = {
        let infoText = UITextView()
        infoText.text =  "Hem HizmetBurada hem de müşteriler size bu numara üzerinden ulaşacak."
        infoText.textColor = .black
        infoText.textAlignment = .center
        infoText.backgroundColor = UIColor(hex: "#F1FAFE")
        infoText.font = UIFont(name: "Avenir", size: 11)
        infoText.isEditable = false
        return infoText
    }()
    
    // Stack view
    lazy var stackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 9
        return stackView
    }()
   

    // GSM TextField
    lazy var gsm: UITextField = {
        let gsm = UITextField()
        gsm.placeholder = "Telefon Numarası"
        gsm.borderStyle = .roundedRect
        gsm.keyboardType = .numberPad // Numara girişine izin ver
        gsm.returnKeyType = .done // Klavye butonunu "Done" yap
        gsm.setPadding(left: 8, right: 0, top: 0, bottom: 0)
        gsm.tintColor = UIColor(hex: "#40A6F8")
        gsm.font = UIFont(name: "Avenir", size: 15)
        
        gsm.layer.borderWidth = 0.6 // Sınır kalınlığı
        gsm.layer.borderColor = UIColor(hex: "40A6F8").cgColor // İstediğiniz renk
        gsm.layer.cornerRadius = 5//
        gsm.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        gsm.delegate = self // Delegate atandı
        return gsm
    }()

    // İzin kutucuğu
    lazy var permissionCheckbox: UIButton = {
        let permissionCheckbox = UIButton(type: .system)
        let buttonFrame = CGRect(x: 20, y: 100, width: 30, height: 30)
        permissionCheckbox.frame = buttonFrame
        permissionCheckbox.addTarget(self, action: #selector(checkboxToggled), for: .touchUpInside)
        permissionCheckbox.isSelected = false
        permissionCheckbox.tintColor =  UIColor(hex: "#40A6F8")
        permissionCheckbox.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        permissionCheckbox.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        return permissionCheckbox
    }()
    
    // İletişim izni label
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "İletişim İzni"
        label.textColor = .black
        label.font = UIFont(name: "Avenir", size: 12)
        let imageView = UIImageView(image: UIImage(named: "chevron.forward"))
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: label.frame.size.width + 5, y: 0, width: 20, height: 20)
        label.addSubview(imageView)
        return label
    }()

    // Kayıt butonu
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
        navigationItem.title = "Devam"
        navigationController?.isNavigationBarHidden = false
        setupCustomBackButton(with: "")
        view.backgroundColor = UIColor(hex: "#F1FAFE")
        navigationItem.title = ""
        stackView.addArrangedSubview(gsm)
        view.addSubview(permissionCheckbox)
        view.addSubview(stackView)
        view.addSubview(registerBtn)
        view.addSubview(gsmText)
        view.addSubview(nameSurnameText2)
        view.addSubview(label)
        design()
    }
    
   
    
    // UI yerleşimi
    func design() {
        gsmText.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 40))
        
        nameSurnameText2.anchor(top: gsmText.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 80))
        
        stackView.anchor(top: nameSurnameText2.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 36, bottom: 0, right: 36), size: .init(width: 0, height: 40))
        
        registerBtn.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: stackView.leadingAnchor, trailing: stackView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 22, right: 0))
        
        permissionCheckbox.anchor(top: stackView.bottomAnchor, bottom: nil, leading: stackView.leadingAnchor, trailing: nil, padding: .init(top: 12, left: 0, bottom: 0, right: 0), size: .init(width: 30, height: 30))
        
        label.anchor(top: permissionCheckbox.topAnchor, bottom: permissionCheckbox.bottomAnchor, leading: permissionCheckbox.trailingAnchor, trailing: stackView.trailingAnchor, padding: .init(top: 0, left: 6, bottom: 0, right: 0))
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        let phoneNumber = gsm.text ?? ""
        
        // Telefon numarası 5 ile başlamalı ve tam olarak 10 karakter uzunluğunda olmalı
        if phoneNumber.starts(with: "5") && phoneNumber.count == maxGsmCharacters {
            registerBtn.isEnabled = true
            registerBtn.alpha = 1 // Buton aktif
        } else {
            registerBtn.isEnabled = false
            registerBtn.alpha = 0.5 // Buton pasif
        }
    }


    
    @objc func nextButtonTapped(click: UIButton!) {
        let phoneNumber = gsm.text ?? ""
        
        // Telefon numarası geçerli değilse (boş veya yanlış), işlem yapılmasın
        if !phoneNumber.starts(with: "5") || phoneNumber.count != maxGsmCharacters {
            let alert = UIAlertController(title: "Geçersiz Telefon Numarası", message: "Lütfen geçerli bir telefon numarası girin. Telefon numarası 5 ile başlamalı ve tam olarak 10 karakter uzunluğunda olmalıdır.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        // İletişim izni verilmemişse, uyarı göster ve işlemi durdur
        if !permissionCheckbox.isSelected {
            let alert = UIAlertController(title: "İletişim İzni Gerekli", message: "Devam edebilmek için iletişim izni vermeniz gerekmektedir. Lütfen onaylayın.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        // Eğer telefon numarası geçerli ve izin verilmişse, diğer sayfaya geç
        ServiceProviderRegistration.rgİnformation.gsm = phoneNumber
        navigationController?.pushViewController(ProfileImage(), animated: true)
    }


    
    // Checkbox tıklama işlemi
    @objc func checkboxToggled() {
        permissionCheckbox.isSelected.toggle()
        if permissionCheckbox.isSelected {
            print("İzin verildi.")
        } else {
            print("İzin verilmedi.")
        }
    }
    
    // Delegate: Karakter sınırlaması
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        // Maksimum karakter sayısı 10 olmalı
        return updatedText.count <= maxGsmCharacters
    }
}
