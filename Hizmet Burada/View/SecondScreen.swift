import UIKit

class SecondScreen: UIViewController {

    lazy var infoText1: UITextView = {
        let infoText1 = UITextView()
        infoText1.textColor = .fontPrimary
        infoText1.backgroundColor = .clear
        infoText1.textAlignment = .center
        infoText1.text = "Kolayca Hizmet Bul, Hemen Hizmet Ver: Mobil Uygulamamız ile İhtiyaçlarınızı Anında Karşılayın!"
        infoText1.font = UIFont(name: "Avenir", size: 11)
        infoText1.isEditable = false
        return infoText1
    }()


    lazy var logo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "rb_2040")
        logo.contentMode = .scaleAspectFit
        logo.clipsToBounds = true // Taşmayı engelle
        return logo
    }()


    lazy var Btn1: UIButton = {
        let loginBtn = UIButton()
        loginBtn.setTitle("Hizmet Al", for: .normal)
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
        loginBtn.layer.masksToBounds = false // Gölgenin görünmesi için gerekli
        return loginBtn
    }()
    
  

    lazy var Btn2: UIButton = {
        let loginBtn = UIButton()
        loginBtn.layer.borderWidth = 1
        loginBtn.setTitle("Hizmet Ver", for: .normal)
        loginBtn.addTarget(self, action: #selector(serve), for: .touchUpInside)
        loginBtn.setTitleColor(.btnFontBlue, for: .normal)
        loginBtn.setTitleColor(.btnFontPressedWhite, for: .highlighted)
        loginBtn.isEnabled = true
        loginBtn.layer.borderColor = UIColor.init(hex: "#01A9F5").cgColor
        loginBtn.layer.cornerRadius = 8
        loginBtn.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 10)
        loginBtn.alpha = 0
        loginBtn.layer.shadowColor = UIColor.black.cgColor
        loginBtn.layer.shadowOpacity = 0.3 // Gölgenin opaklığı (0 ile 1 arası)
        loginBtn.layer.shadowOffset = CGSize(width: 3, height: 3) // X ve Y ekseninde kaydırma
        loginBtn.layer.shadowRadius = 5 // Gölgenin yayılma yarıçapı
        loginBtn.layer.masksToBounds = false // Gölgenin görünmesi için gerekli
        return loginBtn
    }()

    lazy var containerTop: UIView = {
        let containerTop = UIView()
        view.backgroundColor = .backgroundColorWhite
        return containerTop
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(containerTop)
        containerTop.addSubview(Btn1)
        containerTop.addSubview(Btn2)
        containerTop.addSubview(infoText1)
        containerTop.addSubview(logo)
        
        desing()
        
    
        Btn1.transform = CGAffineTransform(translationX: -view.frame.width, y: 0)
        Btn2.transform = CGAffineTransform(translationX: view.frame.width, y: 0)
    }
    
    
    
    



    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.backgroundColor = .backgroundColorWhite
        UIView.animate(withDuration: 0.6, delay: 0.3, options: .curveEaseInOut, animations: {
            self.Btn1.transform = .identity
            self.Btn2.transform = .identity
            self.Btn1.alpha = 1
            self.Btn2.alpha = 1
        }, completion: nil)

      
    }

    func desing() {
        let screenWidth = UIScreen.main.bounds.width
        logo.anchor(top: containerTop.topAnchor, bottom: infoText1.topAnchor, leading: containerTop.leadingAnchor, trailing: containerTop.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0))

        Btn1.anchor(top: nil, bottom: Btn2.topAnchor, leading: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 12, right: 0), size: .init(width: screenWidth*0.80, height: 36))
        Btn1.centerXAnchor.constraint(equalTo: containerTop.centerXAnchor).isActive = true

        Btn2.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: Btn1.leadingAnchor, trailing: Btn1.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 10, right: 0), size: .init(width: 0, height: 36))

        infoText1.anchor(top: nil, bottom: Btn1.topAnchor, leading: Btn1.leadingAnchor, trailing: Btn1.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 5, right: 0), size: .init(width: 0, height: 50))

        containerTop.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
    }

    @objc func getservice(click: UIButton!) {
        
        var view = BasicScreen()
        view.status = "Recipient"
     
        self.navigationController?.pushViewController(view, animated: true)
    }

    @objc func serve(click: UIButton!) {
        var view = BasicScreen()
        view.status = "Provider"
        
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         if navigationController != nil {
             self.navigationController?.setNavigationBarHidden(true, animated: true)
             self.navigationController?.isNavigationBarHidden = true
             self.navigationController?.navigationBar.tintColor = .black
         }
     }

}
