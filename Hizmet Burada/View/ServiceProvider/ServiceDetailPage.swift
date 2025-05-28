//
//  RgExtrainformation.swift
//  Hizmet Burada
//
//  Created by turan on 6.01.2024.
//

import UIKit
import FirebaseDatabaseInternal

class ServiceDetailPage: UIViewController,UITextViewDelegate {

    var instance:[String:String] = [:]
    var status : String?
    
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
        btn.isEnabled = false

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
    
    
    lazy var nameSurnameText:UITextView = {
        let infoText = UITextView()
        infoText.text = "Kendinden Bahset"
        infoText.backgroundColor = .clear
        infoText.textColor = .black
        infoText.textAlignment = .center
        infoText.font = UIFont(name: "Helvetica-Bold", size: 16)
        infoText.isEditable = false
        return infoText
    }()
    
    lazy var nameSurnameText2:UITextView = {
        let infoText = UITextView()
        infoText.backgroundColor = .clear
        infoText.text = "Eklemem istediğin ekstra bilgileri, iş deneyimlerini yazabilirsin"
        infoText.textColor = .black
        infoText.textAlignment = .center
        infoText.font = UIFont(name: "Avenir", size: 12)
        infoText.isEditable = false
        return infoText
    }()
    
    
    
    lazy var textBox: UITextView = {
        let textBox = UITextView()
        textBox.translatesAutoresizingMaskIntoConstraints = false // Auto Layout kullanabilmek için
        textBox.text = "Ekstra bilgileri girin..."
        textBox.backgroundColor = .clear
        
     
        textBox.layer.borderWidth = 0.6
        textBox.layer.borderColor = UIColor(hex:"40A6F8").cgColor
        textBox.layer.cornerRadius = 5.0 // Kenar yuvarlama
        textBox.layer.shadowColor = UIColor.black.cgColor
        textBox.layer.shadowOpacity = 0.2 // Gölgede daha belirgin bir etki
        textBox.layer.shadowOffset = CGSize(width: 0, height: 2) // Dikey gölge
        textBox.layer.shadowRadius = 4.0
        textBox.font = UIFont(name: "Avenir", size: 14)
        textBox.textAlignment = .left // Yazı hizalaması
        textBox.returnKeyType = .done // Klavyede "Tamam" tuşu
        textBox.delegate = self
        textBox.layer.masksToBounds = false // Kenar yuvarlamasının gölgesini göstermek için
        return textBox
    }()

    var key : String = ""
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColorWhite
        setupCustomBackButton(with: "Hizmet Burada")
        desing()
        
        
    }
    

    
    func desing(){
   
        view.addSubview(nextBtn)
        view.addSubview(nameSurnameText)
        view.addSubview(nameSurnameText2)
        view.addSubview(textBox)
  
      
        
        nameSurnameText.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 10, left: 0, bottom: 0, right: 0),size: .init(width: 0, height: 40))
        
        
        
        
        
        nameSurnameText2.anchor(top: nameSurnameText.bottomAnchor,
                                bottom: nil,
                                leading: view.leadingAnchor,
                                trailing: view.trailingAnchor,
                                padding: .init(top: 0, left: 0, bottom: 0,
                                               right: 0),size: .init(width: 0, height: 80))
        
        textBox.anchor(top: nameSurnameText2.bottomAnchor,
                       bottom: nil,
                       leading: view.leadingAnchor,
                       trailing: view.trailingAnchor,
                       padding: .init(top: 10, left: 30, bottom: 0, right: 30),
                       size: .init(width: 0, height: 150))
        nextBtn.anchor(top: nil,
                          bottom: view.safeAreaLayoutGuide.bottomAnchor,
                       leading: textBox.leadingAnchor,
                       trailing: textBox.trailingAnchor,
                          padding: .init(top: 20, left: 0, bottom: 30, right: 0),
                          size: .init(width: 0, height: 36))
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textBox.text == "Ekstra bilgileri girin..." {
            textBox.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textBox.text.isEmpty {
            textBox.text = "Ekstra bilgileri girin..."
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let trimmedText = textBox.text.trimmingCharacters(in: .whitespacesAndNewlines)
        let isPlaceholder = trimmedText == "Ekstra bilgileri girin..."
        
        if trimmedText.isEmpty || isPlaceholder {
            nextBtn.alpha = 0.5
            nextBtn.isEnabled = false
        } else {
            nextBtn.alpha = 1.0
            nextBtn.isEnabled = true
        }
    }

    
    @objc private func nextButtonTapped() {
        let trimmedText = textBox.text.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedText.isEmpty || trimmedText == "Ekstra bilgileri girin..." {
            // Uyarı göster veya geçişi engelle
            let alert = UIAlertController(title: "Uyarı", message: "Lütfen ekstra bilgi giriniz.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default))
            present(alert, animated: true)
            return
        }

        ServiceProviderRegistration.rgİnformation.extraİnformation = trimmedText
        navigationController?.pushViewController(ProviderMail(), animated: true)
    }


    override func viewWillAppear(_ animated: Bool) {
      
    }
    
}
