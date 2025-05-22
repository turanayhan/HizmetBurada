//
//  ProviderMail.swift
//  Hizmet Burada
//
//  Created by turan on 17.10.2024.
//

//
//  rgMailPassword.swift
//  Hizmet Burada
//
//  Created by turan on 6.01.2024.
//

import UIKit
import FirebaseAuth
import JGProgressHUD

class ProviderMail: UIViewController, UITextFieldDelegate {
    lazy var nameSurnameText:UITextView = {
        let infoText = UITextView()
        infoText.text = "Hesap Oluştur"
        infoText.textColor = .black
        infoText.backgroundColor = UIColor(hex: "#F1FAFE")
        infoText.textAlignment = .center
        infoText.font = UIFont(name: "Helvetica-Bold", size: 16)
        infoText.isEditable = false
        return infoText
    }()
    
    lazy var nameSurnameText2:UITextView = {
        let infoText = UITextView()
        infoText.text = "Mail ve şifreni belirleyerek kaydını kolayca tamamla"
        infoText.textColor = .black
        infoText.backgroundColor = UIColor(hex: "#F1FAFE")
        infoText.textAlignment = .center
        infoText.font = UIFont(name: "Avenir", size: 12)
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
    
     lazy var progresBar: JGProgressHUD = {
         let progresBar = JGProgressHUD(style: .light)
         progresBar.textLabel.text = "Kaydınız Gerçekleşiyor"
         return progresBar
     }()
    
    lazy var mail: UITextField = {
        let mail = UITextField()
        mail.placeholder = "E-mail"
        mail.borderStyle = .roundedRect
        mail.keyboardType = .emailAddress // Use email keyboard
        mail.setPadding(left: 8, right: 0, top: 0, bottom: 0)
        mail.tintColor = UIColor(hex: "40A6F8")
        mail.font = UIFont(name: "Avenir", size: 15)
        mail.borderStyle = .none // Remove default border style
        mail.layer.borderWidth = 0.6 // Border thickness
        mail.layer.borderColor = UIColor(hex: "40A6F8").cgColor // Desired color
        mail.layer.cornerRadius = 5
        
        mail.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        return mail
    }()
    lazy var passwordToggleBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal) // Default to 'hide'
        button.tintColor = UIColor(hex: "40A6F8")
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        return button
    }()
    
    
    lazy var password: UITextField = {
        let password = UITextField()
        password.placeholder = "Şifreni gir"
        password.borderStyle = .roundedRect

        
        password.isSecureTextEntry = true
        password.addTarget(self, action: #selector(textFieldDidChanges), for: .editingChanged)
        password.setPadding(left: 8, right: 0, top: 0, bottom: 0)
        password.tintColor = UIColor(hex: "40A6F8")
        password.font = UIFont(name: "Avenir", size: 15)
        password.borderStyle = .none // Varsayılan sınır stilini kaldır
        password.layer.borderWidth = 0.6 // Sınır kalınlığı
        password.layer.borderColor = UIColor(hex: "40A6F8").cgColor // İstediğiniz renk
        password.layer.cornerRadius = 5//
        return password
    }()

    lazy var loginBtn:UIButton = {
        let loginBtn = UIButton()
        loginBtn.setTitle("Kayıt Ol", for: .normal)
        loginBtn.backgroundColor = UIColor(hex: "#40A6F8")
        loginBtn.setTitleShadowColor(.white, for: .focused)
        loginBtn.addTarget(self, action: #selector(rgClick), for: .touchUpInside)
        loginBtn.setTitleColor(UIColor(hex: "E3F2FD"), for: .normal)
        loginBtn.setTitleColor(.white, for: .highlighted)
        loginBtn.isEnabled = true
        loginBtn.titleLabel?.font = UIFont(name: "Avenir", size: 14)
        loginBtn.layer.cornerRadius = 4
        return loginBtn
    }()
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        view.backgroundColor = UIColor(hex: "#F1FAFE")

        setupCustomBackButton(with: "")
        stackView.addArrangedSubview(mail)
        stackView.addArrangedSubview(password)
        view.addSubview(stackView)
        view.addSubview(nameSurnameText)
        view.addSubview(nameSurnameText2)
        view.addSubview(loginBtn)
        mail.delegate = self
        
        desing()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
  
    
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let keyboardHeight = keyboardFrame.height
        let bottomSpace = view.frame.height - (loginBtn.frame.origin.y + loginBtn.frame.height)
        
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
        
        
        
        stackView.anchor(top: nil,
                         bottom: nil,
                         leading: view.leadingAnchor,
                         trailing: view.trailingAnchor,
                         padding: .init(top: 0, left: 36, bottom: 0, right: 36),
                         size: .init(width: 0, height: 90))
        
        stackView.centerAnchor()
        
        loginBtn.anchor(top: stackView.bottomAnchor,
                        bottom: nil,
                        leading: stackView.leadingAnchor,
                        trailing: stackView.trailingAnchor,
                        padding: .init(top: 12, left: 0, bottom: 0, right: 0))
        
        
        
        password.centerXAnchor.constraint(equalTo: loginBtn.centerXAnchor).isActive = true
        
        nameSurnameText.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 10, left: 0, bottom: 0, right: 0),size: .init(width: 0, height: 40))
        
        
        password.rightView = passwordToggleBtn
        password.rightViewMode = .always
        passwordToggleBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30) // Set button size
        passwordToggleBtn.translatesAutoresizingMaskIntoConstraints = false

        
    
        
        
        nameSurnameText2.anchor(top: nameSurnameText.bottomAnchor,
                                bottom: nil,
                                leading: view.leadingAnchor,
                                trailing: view.trailingAnchor,
                                padding: .init(top: 0, left: 0, bottom: 0,
                                               right: 0),size: .init(width: 0, height: 80))
        
        
        
    }
    @objc func textFieldDidChanges(textField: UITextField) {
        if  mail.text!.isEmpty || password.text!.isEmpty {
            loginBtn.isEnabled = false
            loginBtn.alpha = 0.5
        } else {
            loginBtn.isEnabled = true
            loginBtn.alpha = 1
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField == mail {
            // Validate email format
            if let email = textField.text, !isValidEmail(email) {
                print("Invalid email format")
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
    
    @objc func togglePasswordVisibility() {
        password.isSecureTextEntry.toggle() // Toggle visibility
        let buttonImage = password.isSecureTextEntry ? "eye.slash" : "eye" // Change icon based on state
        passwordToggleBtn.setImage(UIImage(systemName: buttonImage), for: .normal)
    }

    
    
    
    @objc func rgClick(click : UIButton!){
        
        progresBar.show(in: self.view)
        
        Auth.auth().createUser(withEmail: self.mail.text!, password: self.password.text!) { response, error in
                    if let error = error {
                        print("Hata: \(error.localizedDescription)")
                        self.progresBar.dismiss(afterDelay: 2.0)
                        return
                    }
                    
                    let id = UUID().uuidString
            ServiceProviderRegistration.rgİnformation.userİd = id
            ServiceProviderRegistration.rgİnformation.mail = self.mail.text
            
            
            
            let user = ServiceProviderRegistration.rgİnformation.createUser(status:"Provider")
                    

                    FirestoreManager().UserRecipientPush(user: user) { result in
                            switch result {
                            case .success(let message):
                                print(message)
                                UserManager.shared.setUser(user: user)
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                    print(Date())
                                    self.progresBar.dismiss(afterDelay: 2.0)
                                    print("Kullanıcı başarıyla kaydedildi")
                                    self.navigationItem.title = ""
                                    self.navigationController?.isNavigationBarHidden = true
                                    
                                    var view = LoginPage()
                                    view.status = "Provider"
                                    self.navigationController?.pushViewController(view, animated: true)
                                }

                            case .failure(let error):
                               
                                self.progresBar.dismiss(afterDelay: 1.0)
                           
                                
                            }
                        }
                    
                
                }
            }
        
   
        
        
        
    }
    

