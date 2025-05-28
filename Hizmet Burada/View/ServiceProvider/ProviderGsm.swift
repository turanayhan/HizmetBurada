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
    
    let maxGsmCharacters = 12
    
    let checkbox = CheckboxButton()

    // Progress bar
    lazy var progresBar:JGProgressHUD = {
        let progresBar = JGProgressHUD(style: .light)
        progresBar.backgroundColor = .clear
        return  progresBar
    }()
    
    // Telefon sorusu text view
    lazy var gsmText:UITextView = {
        let infoText = UITextView()
        infoText.text = "Cep telefonun nedir?"
        infoText.textColor = .black
        infoText.textAlignment = .center
        infoText.backgroundColor = .clear
        
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
        infoText.backgroundColor = .clear
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
        gsm.placeholder = "5xx-xxx-xxxx"
        gsm.borderStyle = .roundedRect
        gsm.keyboardType = .numberPad // Numara girişine izin ver
        gsm.returnKeyType = .done // Klavye butonunu "Done" yap
        gsm.setPadding(left: 10, right: 0, top: 0, bottom: 0)
        gsm.font = UIFont(name: "Avenir", size: 15)
    
        
        gsm.layer.borderWidth = 0.6 // Sınır kalınlığı
        gsm.layer.borderColor = UIColor.borderColor.cgColor// İstediğiniz renk
        gsm.layer.cornerRadius = 5//
        gsm.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        gsm.delegate = self // Delegate atandı
        return gsm
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
        btn.isEnabled = true

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
        stackView.addArrangedSubview(gsm)

        view.addSubview(stackView)
        view.addSubview(nextBtn)
        view.addSubview(gsmText)
        view.addSubview(nameSurnameText2)
        view.addSubview(label)
        view.addSubview(checkbox)

        design()
    }
    
   
    
    func design() {
        gsmText.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 40))
        
        nameSurnameText2.anchor(top: gsmText.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 80))
        
        stackView.anchor(top: nameSurnameText2.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 36, bottom: 0, right: 36), size: .init(width: 0, height: 40))
        
        
        nextBtn.anchor(top: nil,
                           bottom: view.safeAreaLayoutGuide.bottomAnchor,
                           leading: stackView.leadingAnchor,
                           trailing: stackView.trailingAnchor,
                           padding: .init(top: 0, left: 0, bottom:22, right: 0),
                       size: .init(width: 0, height: 36))
        
        checkbox.anchor(top: stackView.bottomAnchor, bottom: nil, leading: stackView.leadingAnchor, trailing: nil, padding: .init(top: 8, left: 0, bottom: 0, right: 0), size: .init(width: 36, height: 36))
        
        
        
        
        label.anchor(top: checkbox.topAnchor, bottom: checkbox.bottomAnchor, leading: checkbox.trailingAnchor, trailing: stackView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    }
    
    

    @objc func textFieldDidChange(textField: UITextField) {
       
        let formattedText = formatPhoneNumber(textField.text ?? "")
        textField.attributedText = formattedText
        
        // Eğer 10 rakam girildiyse butonu aktif yap
        let digits = textField.text?.filter { $0.isNumber } ?? ""
        nextBtn.isEnabled = digits.count == 10
        
        
        if digits.count == 10 {
            nextBtn.isEnabled = true
            nextBtn.alpha = 1
        
        }
        else {
            nextBtn.isEnabled = false
            nextBtn.alpha = 0.5
        }
    }

    func formatPhoneNumber(_ number: String) -> NSAttributedString {
        let digits = number.filter { $0.isNumber } // Sadece sayıları al
        let maxLength = 10 // Maksimum 10 rakam girilebilir
        let limitedDigits = String(digits.prefix(maxLength)) // Fazla girileni kes
        
      
        
        var formatted = ""
        
        for (index, char) in limitedDigits.enumerated() {
            if index == 3 || index == 6 {
                formatted.append("-") // 4. ve 7. karakterden sonra "-" ekle
            }
            formatted.append(char)
        }

        // **Harfler arası boşluk ayarı**
        let attributes: [NSAttributedString.Key: Any] = [
            .kern: 1.0 // Harfler arası boşluk
        ]
        
        return NSAttributedString(string: formatted, attributes: attributes)
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
        
 
        
        // Eğer telefon numarası geçerli ve izin verilmişse, diğer sayfaya geç
        ServiceProviderRegistration.rgİnformation.gsm = phoneNumber
        navigationController?.pushViewController(ProfileImage(), animated: true)
    }


    
    // Checkbox tıklama işlemi
    @objc func checkboxToggled() {
        checkbox.isSelected.toggle()
        if checkbox.isSelected {
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
