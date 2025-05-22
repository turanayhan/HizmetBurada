//
//  LoginBasic.swift
//  Hizmet Burada
//
//  Created by turan on 16.10.2024.
//

import UIKit

class BasicScreen: UIViewController {
    
    var status : String?
    lazy var infoText1: UITextView = {
        let infoText1 = UITextView()
        infoText1.textColor = .fontPrimary
        infoText1.backgroundColor = .clear
        infoText1.textAlignment = .center
        infoText1.text = ""
        infoText1.font = UIFont(name: "Avenir", size: 11)
        infoText1.isEditable = false
        return infoText1
    }()

    lazy var logo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "203893008_efe169af-3e07-454d-988a-3952ba919a26")
        logo.contentMode = .scaleAspectFit
        logo.clipsToBounds = true // Taşmayı engelle
        
        return logo
    }()


    lazy var Btn1: UIButton = {
        let loginBtn = UIButton()
        loginBtn.setTitle("Giriş Yap", for: .normal)
        loginBtn.setTitleShadowColor(.white, for: .focused)
        loginBtn.addTarget(self, action: #selector(getservice), for: .touchUpInside)
        loginBtn.setTitleColor(.btnFont, for: .normal)
        loginBtn.setTitleColor(.btnFontBlue, for: .highlighted)
        loginBtn.isEnabled = true
        loginBtn.backgroundColor = .btnBlue
        loginBtn.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 10)
        loginBtn.layer.cornerRadius = 8
        loginBtn.alpha = 0
        loginBtn.layer.shadowColor = UIColor.black.cgColor
        loginBtn.layer.shadowOpacity = 0.3 // Gölgenin opaklığı (0 ile 1 arası)
        loginBtn.layer.shadowOffset = CGSize(width: 3, height: 3) // X ve Y ekseninde kaydırma
        loginBtn.layer.shadowRadius = 5 // Gölgenin yayılma yarıçapı
        loginBtn.layer.masksToBounds = false
        return loginBtn
    }()
    
  

    lazy var registerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-medium", size: 10)
        let fullText = "Hesabın yok mu? KAYIT OL"
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: "KAYIT OL")
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        attributedString.addAttribute(.foregroundColor, value: UIColor(hex: "#01A9F5"), range: range) // Renk ekleyelim
        label.attributedText = attributedString
        label.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(registerTapped))
        label.addGestureRecognizer(tapGesture)
        return label
    }()

    lazy var containerTop: UIView = {
        let containerTop = UIView()
        view.backgroundColor = .backgroundColorWhite
        return containerTop
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        

        view.addSubview(containerTop)
        containerTop.addSubview(Btn1)
        containerTop.addSubview(registerLabel)
        containerTop.addSubview(infoText1)
        containerTop.addSubview(logo)
        setupCustomBackButton(with: "Hizmet Burada")
    
        desing()
        Btn1.transform = CGAffineTransform(translationX: -view.frame.width, y: 0)
        registerLabel.transform = CGAffineTransform(translationX: view.frame.width, y: 0)
       
      
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.backgroundColor = .backgroundColorWhite
        
        UIView.animate(withDuration: 0.6, delay: 0.3, options: .curveEaseInOut, animations: {
            self.Btn1.transform = .identity
            self.registerLabel.transform = .identity
            self.Btn1.alpha = 1
            self.registerLabel.alpha = 1
     
        }, completion: nil)

      
    }
    


    func desing() {
        let screenWidth = UIScreen.main.bounds.width
        logo.anchor(top: containerTop.topAnchor, bottom: infoText1.topAnchor, leading: containerTop.leadingAnchor, trailing: containerTop.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0))

        Btn1.anchor(top: nil, bottom: registerLabel.topAnchor, leading: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 12, right: 0), size: .init(width: screenWidth*0.80, height: 36))
        Btn1.centerXAnchor.constraint(equalTo: containerTop.centerXAnchor).isActive = true

        registerLabel.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: Btn1.leadingAnchor, trailing: Btn1.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 10, right: 0), size: .init(width: 0, height: 30))

        infoText1.anchor(top: nil, bottom: Btn1.topAnchor, leading: Btn1.leadingAnchor, trailing: Btn1.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 5, right: 0), size: .init(width: 0, height: 50))

        containerTop.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
    }
    
    @objc func registerTapped() {
     
        if status == "Recipient" {
            var view = RecipientName()
            self.navigationController?.pushViewController(view, animated: true)
            
        }
        else if status == "Provider" {
            var view = SelectionPage()
            self.navigationController?.pushViewController(view, animated: true)
        }
        
      
        }

    @objc func getservice(click: UIButton!) {
        var view = LoginPage()
        view.status = status
        self.navigationController?.pushViewController(view, animated: true)
    }
    }

