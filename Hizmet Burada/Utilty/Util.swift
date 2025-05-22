import Foundation
import UIKit
import SideMenu

extension UIView {
    func centerAnchor(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let centerX = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        if let centerY = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
    }
    

    
    func anchor(top: NSLayoutYAxisAnchor?,
                bottom: NSLayoutYAxisAnchor?,
                leading: NSLayoutXAxisAnchor?,
                trailing: NSLayoutXAxisAnchor?,
                padding: UIEdgeInsets = .zero,
                size: CGSize = .zero,
                minHeight: CGFloat? = nil,    // Min yükseklik
                maxHeight: CGFloat? = nil,    // Max yükseklik
                minWidth: CGFloat? = nil,     // Min genişlik
                maxWidth: CGFloat? = nil      // Max genişlik
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        // Sabit genişlik ve yükseklik
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        
        // Min ve max yükseklik constraint'leri
        if let minHeight = minHeight {
            heightAnchor.constraint(greaterThanOrEqualToConstant: minHeight).isActive = true
        }
        
        if let maxHeight = maxHeight {
            heightAnchor.constraint(lessThanOrEqualToConstant: maxHeight).isActive = true
        }
        
        // Min ve max genişlik constraint'leri
        if let minWidth = minWidth {
            widthAnchor.constraint(greaterThanOrEqualToConstant: minWidth).isActive = true
        }
        
        if let maxWidth = maxWidth {
            widthAnchor.constraint(lessThanOrEqualToConstant: maxWidth).isActive = true
        }
    }
}




extension UITextField {

    func setPadding(left: CGFloat, right: CGFloat, top: CGFloat, bottom: CGFloat) {
        let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: left, height: self.frame.height))
        let rightPadding = UIView(frame: CGRect(x: 0, y: 0, width: right, height: self.frame.height))
        
        self.leftView = leftPadding
        self.leftViewMode = .always
        
        self.rightView = rightPadding
        self.rightViewMode = .always
        
        let topPadding = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: top))
        let bottomPadding = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: bottom))
        
        self.addSubview(topPadding)
        self.addSubview(bottomPadding)
    }
    
    

        func setRightIcon(_ image: UIImage?, margin: CGFloat = 10) {
            let iconView = UIImageView(image: image)
            iconView.tintColor = .btnBlue
            iconView.contentMode = .scaleAspectFit
            iconView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)

            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: iconView.frame.width + margin, height: 20))
            paddingView.addSubview(iconView)

            self.rightView = paddingView
            self.rightViewMode = .always
        }
    


    


    
}

extension UINavigationController {
    func customizeBackButton(title: String = "", tintColor: UIColor = .black) {
        let backButton = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil)
        self.navigationBar.topItem?.backBarButtonItem = backButton
        self.navigationBar.tintColor = tintColor
    }
}

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

extension UIViewController {
    
    
      func setStatusBarColor(hex: String) {
          let color = UIColor(hex: hex) ?? .clear
          
          // Üst düzey bir görünüm oluştur ve arka plana ekle
          let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
          let statusBarView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: statusBarHeight))
          statusBarView.backgroundColor = color
          
   
          
          view.addSubview(statusBarView)
      }
    


    @objc func openMenu() {
        if let menu = SideMenuManager.default.leftMenuNavigationController {
            present(menu, animated: true, completion: nil)
        }
        
    }
    
    
    func setupCustomBackButton(with title: String) {
        setStatusBarColor(hex: "#FFFFFF")
        
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.backward"),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        backButton.tintColor = .black
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "Chalkduster", size: 18)
        titleLabel.textAlignment = .center
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.isNavigationBarHidden = false

        // 🔽 Çizgiyi ekle
        if let navigationBar = navigationController?.navigationBar {
            let bottomLine = UIView()
            bottomLine.translatesAutoresizingMaskIntoConstraints = false
            bottomLine.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
            navigationBar.addSubview(bottomLine)

            NSLayoutConstraint.activate([
                bottomLine.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor),
                bottomLine.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor),
                bottomLine.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor),
                bottomLine.heightAnchor.constraint(equalToConstant: 0.5)
            ])
        }
    }
    
    func customnNavigation() {
        setStatusBarColor(hex: "#FFFFFF")
        let menuButton = UIBarButtonItem(
            image: UIImage(systemName: "line.horizontal.3"), // Menü ikonu
            style: .plain,
            target: self,
            action: #selector(openMenu)
        )
        
        let titleLabel = UILabel()
        titleLabel.text = "Hizmet Burada"
        titleLabel.textColor = .black // Başlık rengi
        titleLabel.font = UIFont(name: "Chalkduster", size: 18)
        titleLabel.textAlignment = .center
        
        menuButton.tintColor = .black // Simge rengi (isteğe bağlı)
        navigationItem.leftBarButtonItem = menuButton
        navigationItem.titleView = titleLabel
    
        navigationController?.navigationBar.backgroundColor = .backgroundColorWhite
      
        
        // Menü ayarları
        let menu = SideMenuNavigationController(rootViewController: Menu())
        menu.leftSide = true // Sol taraftan açılacak
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        
        if let navigationBar = navigationController?.navigationBar {
            let bottomLine = UIView()
            bottomLine.translatesAutoresizingMaskIntoConstraints = false
            bottomLine.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
            navigationBar.addSubview(bottomLine)

            NSLayoutConstraint.activate([
                bottomLine.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor),
                bottomLine.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor),
                bottomLine.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor),
                bottomLine.heightAnchor.constraint(equalToConstant: 0.5)
            ])
        }
    }



    @objc func backButtonTapped() {
         navigationController?.popViewController(animated: true)
     }
    
    func setDefaultBackgroundColor() {
          view.backgroundColor = UIColor(hex: "#F1FAFE")
      }

    
}




extension UIColor {
    
    static let btnBlue = UIColor(hex: "#01A9F5")
    static let btnFontBlue = UIColor(hex: "#01A9F5")
    static let btnPrimary = UIColor(hex: "#5e69ee")
    static let btnSecondary = UIColor(hex: "#39AFEA")
    static let fontPrimary = UIColor(hex: "#6D6D6D")
    static let fontSecondary = UIColor(hex: "#F4F6FB")
    static let borderColor = UIColor(.gray)
    static let btnFont = UIColor(hex: "#F4F6FB")
    static let btnFontPressedWhite = UIColor(hex: "#F0F0F0")
    static let btnFontPressedblue = UIColor(hex: "#4B0082")
    static let mainColor = UIColor(hex: "#E3F2FD")
    static let backgroundColor = UIColor(hex: "#E3F2FD")
    static let backgroundColorWhite = UIColor(hex: "#FFFFFF")
    
    
}



