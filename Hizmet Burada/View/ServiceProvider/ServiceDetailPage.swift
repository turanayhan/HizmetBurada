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
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Devam", for: .normal)
        button.isEnabled = true
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
        infoText.font = UIFont(name: "Avenir", size: 14)
        infoText.isEditable = false
        return infoText
    }()
    
    
    
    lazy var textBox: UITextView = {
        let textBox = UITextView()
        textBox.translatesAutoresizingMaskIntoConstraints = false // Auto Layout kullanabilmek için
        textBox.text = "Ekstra bilgileri girin..."
        textBox.textColor = UIColor.lightGray // Placeholder rengi
        textBox.backgroundColor = UIColor(hex: "#E3F2FD") // Arka plan rengi
        textBox.layer.borderWidth = 0.6
        textBox.layer.borderColor = UIColor(hex:"40A6F8").cgColor
        textBox.layer.cornerRadius = 5.0 // Kenar yuvarlama
        textBox.layer.shadowColor = UIColor.black.cgColor
        textBox.layer.shadowOpacity = 0.2 // Gölgede daha belirgin bir etki
        textBox.layer.shadowOffset = CGSize(width: 0, height: 2) // Dikey gölge
        textBox.layer.shadowRadius = 4.0
        textBox.font = UIFont(name: "Avenir", size: 16)
        textBox.textAlignment = .left // Yazı hizalaması
        textBox.returnKeyType = .done // Klavyede "Tamam" tuşu
        textBox.delegate = self
        textBox.layer.masksToBounds = false // Kenar yuvarlamasının gölgesini göstermek için
        return textBox
    }()

    var key : String = ""
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomBackButton(with: "")
 
        desing()
        
        
    }
    

    
    func desing(){
        
        view.backgroundColor = UIColor(hex: "#F1FAFE")
        navigationItem.title = ""
        view.addSubview(nextButton)
        view.addSubview(nameSurnameText)
        view.addSubview(nameSurnameText2)
        view.addSubview(textBox)
        nextButton.anchor(top: nil,
                          bottom: view.safeAreaLayoutGuide.bottomAnchor,
                          leading: view.leadingAnchor,
                          trailing: view.trailingAnchor,
                          padding: .init(top: 10, left: 10, bottom: 30, right: 10),
                          size: .init(width: 0, height: 36))
        
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
                       padding: .init(top: 10, left: 20, bottom: 0, right: 20),
                       size: .init(width: 0, height: 150))
        
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
    
    @objc private func nextButtonTapped() {
        ServiceProviderRegistration.rgİnformation.extraİnformation = textBox.text
        
        var view = RecipientMail()
        navigationController?.pushViewController(ProviderMail(), animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
      
    }
    
}
