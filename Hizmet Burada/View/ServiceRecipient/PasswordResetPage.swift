//
//  PasswordReset.swift
//  Hizmet Burada
//
//  Created by turan on 1.10.2024.
//

import JGProgressHUD

import UIKit
import FirebaseFirestoreSwift
import Firebase

class PasswordResetPage: UIViewController ,UITextFieldDelegate  {
    
    
    lazy var infoText1: UITextView = {
        let infoText1 = UITextView()
        infoText1.textColor = .black
        infoText1.backgroundColor = .clear
        infoText1.textAlignment = .center
        infoText1.text = "Üyeliğinizde kayıtlı e - posta adresine \ngöndereceğimiz link ile yeni şifrenizi oluşturabilirsiniz. "
        infoText1.font = UIFont(name: "Avenir", size: 12)
        infoText1.isEditable = false
        return infoText1
    }()

    
    
    lazy var progresBar: JGProgressHUD = {
        let progresBar = JGProgressHUD(style: .light)
        progresBar.textLabel.text = "Giriş Yapılıyor"
        return progresBar
    }()
    
    lazy var logo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "12144997_Wavy_Cst-01_Single-09")
        logo.contentMode = .scaleAspectFit
        return logo
    }()
    
    lazy var stackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
       
        return stackView
    }()
    
    lazy var mail: UITextField = {
        let mail = UITextField()
        mail.placeholder = "E-mail"
        mail.borderStyle = .roundedRect
        mail.keyboardType = .emailAddress // Use email keyboard
        
        mail.setPadding(left: 8, right: 0, top: 0, bottom: 0)
        mail.tintColor = .systemYellow
        mail.font = UIFont(name: "Avenir", size: 15)
        mail.borderStyle = .none // Remove default border style
        mail.layer.borderWidth = 0.6 // Border thickness
        mail.layer.borderColor = UIColor.systemYellow.cgColor // Desired color
        mail.layer.cornerRadius = 5
        
        mail.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        return mail
    }()
    

    
    lazy var passwordReset:UIButton = {
        let loginBtn = UIButton()
        loginBtn.setTitle("Devam", for: .normal)
        loginBtn.backgroundColor = .systemYellow
        loginBtn.setTitleShadowColor(.white, for: .focused)
        loginBtn.addTarget(self, action: #selector(passwordtNext), for: .touchUpInside)
        loginBtn.setTitleColor(.white, for: .normal)
        loginBtn.setTitleColor(.red, for: .highlighted)
    
        loginBtn.layer.cornerRadius = 4
        loginBtn.isEnabled = false
        loginBtn.titleLabel?.font = UIFont(name: "Avenir", size: 14)
        loginBtn.alpha = 0.5
        return loginBtn
    }()


    override func viewWillAppear(_ animated: Bool) {
        navigationController?.customizeBackButton()
      
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        

     
        view.backgroundColor = .white
        stackView.addArrangedSubview(mail)
        view.addSubview(stackView)
        view.addSubview(passwordReset)
        view.addSubview(infoText1)
        view.addSubview(logo)
     

        mail.delegate = self

        

        desing()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        
    }
    @objc func keyboardWillShow(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let keyboardHeight = keyboardFrame.height
        let bottomSpace = view.frame.height - (passwordReset.frame.origin.y + passwordReset.frame.height)
        
        if bottomSpace < keyboardHeight {
            view.frame.origin.y = 0 - (keyboardHeight - bottomSpace + 40) // Ekranı klavye kadar yukarı kaydır
        }
    }

    @objc func keyboardWillHide(_ notification: NSNotification) {
        view.frame.origin.y = 0 // Görünümü eski konumuna getir
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    
    func desing(){
        
        let screenWidth = UIScreen.main.bounds.width
        
        logo.anchor(top: nil, bottom: infoText1.topAnchor, leading: infoText1.leadingAnchor, trailing: infoText1.trailingAnchor,size: .init(width: screenWidth*0.40, height: screenWidth*0.40))
        
        passwordReset.anchor(top: nil,
                        bottom: nil,
                        leading: stackView.leadingAnchor,
                        trailing: stackView.trailingAnchor,
                        padding: .init(top: 12, left: 0, bottom: 0, right: 0))
        passwordReset.centerAnchor()
       
        
        stackView.anchor(top: nil,
                         bottom: passwordReset.topAnchor,
                         leading: view.leadingAnchor,
                         trailing: view.trailingAnchor,
                         padding: .init(top: 0, left: 36, bottom: 12, right: 36),
                         size: .init(width: 0, height: 30))
        
        
      
      

   
        infoText1.anchor(top: nil, bottom: stackView.topAnchor, leading: stackView.leadingAnchor, trailing: stackView.trailingAnchor,size: .init(width: 0, height: 50))

        
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    
    

    @objc func passwordtNext(click : UIButton!){
        
        navigationController?.popViewController(animated: true)
        sendPasswordReset(email: self.mail.text!)

        
    }
    
    @objc func textFieldDidChanges(textField: UITextField) {
        if  mail.text!.isEmpty {
            passwordReset.isEnabled = false
            passwordReset.alpha = 0.5
        } else {
            passwordReset.isEnabled = true
            passwordReset.alpha = 1
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField == mail {
            // Validate email format
            self.passwordReset.isEnabled = true
            passwordReset.alpha = 1
            if let email = textField.text, !isValidEmail(email) {
                print("Invalid email format")
                self.passwordReset.isEnabled = false
                passwordReset.alpha = 0.5
            }
        }
    }
    // Function to validate email format
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Dismiss keyboard
        return true
    }
 

    
    func sendPasswordReset(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                // Hata durumunu işleme
                print("Şifre sıfırlama e-posta gönderilemedi: \(error.localizedDescription)")
            } else {
                // Şifre sıfırlama e-postası başarıyla gönderildi
                print("Şifre sıfırlama e-postası gönderildi!")
            }
        }
    }
    
    
}
