//
//  Login.swift
//  Hizmet Burada
//
//  Created by turan on 5.11.2023.
//

import UIKit
import Firebase
import JGProgressHUD

class LoginPage: UIViewController, UITextFieldDelegate {
    
    var status : String?
    
    
    
    lazy var progresBar: JGProgressHUD = {
        let progresBar = JGProgressHUD(style: .light)
        progresBar.backgroundColor = .clear
        return progresBar
    }()
    
    lazy var logo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "21743663_6485983")
        logo.contentMode = .scaleAspectFit
        logo.backgroundColor = .backgroundColor
        return logo
    }()
    
    lazy var stackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 9
        return stackView
    }()
    
    lazy var mail: UITextField = {
        let mail = UITextField()
        mail.placeholder = "E-mail"
        mail.borderStyle = .roundedRect
        mail.keyboardType = .emailAddress
        mail.setPadding(left: 10, right: 0, top: 0, bottom: 0)
        mail.font = UIFont(name: "Avenir", size: 12)
        mail.borderStyle = .none
        mail.layer.borderWidth = 0.6
        mail.layer.borderColor = UIColor.borderColor.cgColor
        mail.layer.cornerRadius = 5
        mail.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        mail.tintColor = .btnBlue
        mail.setRightIcon(UIImage(systemName: "envelope.fill"), margin: 10)

        
        return mail
    }()
    
    
    lazy var password: UITextField = {
        let password = UITextField()
        password.placeholder = "Şifreni gir"
        password.borderStyle = .none
        password.isSecureTextEntry = true
        password.font = UIFont(name: "Avenir", size: 12)
        password.layer.borderWidth = 0.6
        password.layer.borderColor = UIColor.borderColor.cgColor
        password.layer.cornerRadius = 5
        password.setPadding(left: 10, right: 0, top: 0, bottom: 0)
        password.addTarget(self, action: #selector(textFieldDidChanges), for: .editingChanged)
        password.tintColor = .btnBlue

        let toggleButton = UIButton(type: .custom)
        toggleButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        toggleButton.tintColor = .btnBlue
        toggleButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        toggleButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        
        // Sağdan 10 birim boşluk bırakmak için paddingView genişliği artırıldı
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20)) // 20 (buton) + 10 (boşluk)
        toggleButton.frame.origin.x = 11 // Butonu içe kaydırmak yerine dışarıdan boşluk verdik
        paddingView.addSubview(toggleButton)
        
        password.rightView = paddingView
        password.rightViewMode = .always
        
        return password
    }()

   

    
    lazy var loginBtn:UIButton = {
        let loginBtn = UIButton()
        loginBtn.setTitle("Giriş Yap", for: .normal)
        loginBtn.setTitleShadowColor(.white, for: .focused)
        loginBtn.addTarget(self, action: #selector(loginClick), for: .touchUpInside)
        loginBtn.setTitleColor(.btnFont, for: .normal)
        loginBtn.setTitleColor(.btnFontBlue, for: .highlighted)
        loginBtn.isEnabled = true
        loginBtn.backgroundColor = .btnBlue
        loginBtn.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 10)
        loginBtn.layer.cornerRadius = 8
        loginBtn.layer.shadowColor = UIColor.black.cgColor
        loginBtn.layer.shadowOpacity = 0.3 // Gölgenin opaklığı (0 ile 1 arası)
        loginBtn.layer.shadowOffset = CGSize(width: 3, height: 3) // X ve Y ekseninde kaydırma
        loginBtn.layer.shadowRadius = 5 // Gölgenin yayılma yarıçapı
        loginBtn.layer.masksToBounds = false // Gölgenin görünmesi için gerekli
        return loginBtn
    }()
 
    
    lazy var passwordBtn:UIButton = {
        let registerBtn = UIButton()
        registerBtn.setTitle("Şifremi Unuttum", for: .normal)
        registerBtn.setTitleShadowColor(.white, for: .focused)
        registerBtn.addTarget(self, action: #selector(passwordtBtnClick), for: .touchUpInside)
        registerBtn.setTitleColor(.btnPrimary, for: .normal)
        registerBtn.setTitleColor(.btnFontPressedblue, for: .highlighted)
        registerBtn.titleLabel?.font = UIFont(name: "Avenir", size: 12)
        registerBtn.isEnabled = true
        return registerBtn
    }()
    
    override func viewWillAppear(_ animated: Bool) {

        view.backgroundColor = .backgroundColorWhite
      
    }
    

    override func viewDidLoad() {
        setupCustomBackButton(with: "Hizmet Burada")
        super.viewDidLoad()
        stackView.addArrangedSubview(mail)
        stackView.addArrangedSubview(password)
        view.addSubview(stackView)
        view.addSubview(loginBtn)
        view.addSubview(logo)
        view.addSubview(passwordBtn)
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
        
        let screenWidth = UIScreen.main.bounds.width
        
        logo.anchor(top: nil,
                    bottom: stackView.topAnchor,
                    leading: nil,
                    trailing: nil,
                    padding: .init(top: 12, left: 12, bottom: 16, right: 12), size: .init(width: screenWidth*0.60, height: screenWidth*0.60))
        
        
        logo.centerXAnchor.constraint(equalTo: stackView.centerXAnchor).isActive = true
        
        stackView.anchor(top: nil,
                         bottom: nil,
                         leading: view.leadingAnchor,
                         trailing: view.trailingAnchor,
                         padding: .init(top: 0, left: 36, bottom: 0, right: 36),
                         size: .init(width: 0, height: 80))
        
        stackView.centerAnchor()
        
        loginBtn.anchor(top: stackView.bottomAnchor,
                        bottom: nil,
                        leading: stackView.leadingAnchor,
                        trailing: stackView.trailingAnchor,
                        padding: .init(top: 12, left: 0, bottom: 0, right: 0),
                        size: .init(width: screenWidth*0.80, height: 36))


  

        
        passwordBtn.anchor(top: loginBtn.bottomAnchor,
                           bottom: nil, leading: loginBtn.leadingAnchor,
                           trailing: loginBtn.trailingAnchor,
                           padding: .init(top: 12, left: 12, bottom: 0, right: 12)
                           )
        
        password.centerXAnchor.constraint(equalTo: loginBtn.centerXAnchor).isActive = true
        
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    

    @objc func loginClick(click : UIButton!){
        progresBar.show(in: self.view)
        
        print("firebase işlemleri")
        
        
        FirestoreManager().signIn(withEmail: self.mail.text ?? "", password: self.password.text ?? "") { [weak self] result in
               guard let self = self else { return }

               switch result {
               case .success(let authResult):
                   print("Giriş başarılı")
                   self.progresBar.dismiss(afterDelay: 2.0)
                   UserManager.shared.isLogin()
                   
                   
                   if status == "Recipient" {
                       self.navigationController?.pushViewController(ServiceRecipient(), animated: true)
                       
                   }
                   
                   else if status == "Provider" {
                       self.navigationController?.pushViewController(ServiceProvider(), animated: true)
                       
                   }
                   
           
                   self.navigationController?.isNavigationBarHidden = true
               case .failure(let error):
                   self.progresBar.dismiss(afterDelay: 2.0)
                   showAlert(title: "Hata", message: error.localizedDescription)

                   print("Giriş hatası: \(error.localizedDescription)")
               }
           }
    }
    

    @objc func passwordtBtnClick(click : UIButton!){
        navigationController?.pushViewController(PasswordResetPage(), animated: true)

        print("şifremi unuttum")
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
    
    @objc func togglePasswordVisibility(_ sender: UIButton) {
        password.isSecureTextEntry.toggle()
        let imageName = password.isSecureTextEntry ? "eye.slash.fill" : "eye.fill"
        sender.setImage(UIImage(systemName: imageName), for: .normal)
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
