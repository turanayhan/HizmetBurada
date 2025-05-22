//
//  Accountİnformation.swift
//  Hizmet Burada
//
//  Created by turan on 18.11.2023.
//

import UIKit
import MaterialOutlinedTextField
import Firebase

class UserPage: UIViewController , UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    
    var sehirler: [Sehir] = []
    var ilceler: [String] = []
    var selectedSehir: String?
    
    let t = MaterialOutlinedTextField()
   


    lazy var sehirDropdown: UITableView = {
        let tableView = UITableView()
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor.lightGray.cgColor
        tableView.layer.cornerRadius = 5
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true  // Başlangıçta gizli
        return tableView
    }()
    
    
    lazy var ilceDropdown: UITableView = {
        let tableView = UITableView()
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor.lightGray.cgColor
        tableView.layer.cornerRadius = 5
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true  // Başlangıçta gizli
        return tableView
    }()
  
    
    let userModel:User = {
        let model = UserManager.shared.getUser()
        return model
    }()
    
    lazy var container:UIView = {
        let container = UIView()
        container.backgroundColor = .white
        container.layer.cornerRadius = 16
        container.layer.borderWidth = 0.3
        container.layer.borderColor =  UIColor.lightGray.cgColor
        return container
    }()
    
  
    
    lazy var header:UILabel = {
        let info = UILabel()
        info.backgroundColor = UIColor.clear
        info.font = UIFont(name: "Avenir-Medium", size: 11)
        info.text = "Kişisel Bilgiler"
        return info
    }()
    
    lazy var header2:UILabel = {
        let info = UILabel()
        info.backgroundColor = UIColor.clear
        info.font = UIFont(name: "Avenir", size: 9)
        info.text = "Kişisel Bilgilerinizi Düzenleyin"
        return info
    }()
    
    lazy var nameSurname:MaterialOutlinedTextField = {
        let nameSurname = MaterialOutlinedTextField()
        nameSurname.text = userModel.nameSurname
        nameSurname.placeholder = "Ad Soyad"
        nameSurname.label.text = "Ad Soyad"
        nameSurname.containerRadius = 6
        nameSurname.setOutlineLineWidth(0.3, for: .normal)
        nameSurname.setOutlineLineWidth(0.5, for: .editing)
        nameSurname.clearButtonMode = .whileEditing
        nameSurname.setColorModel(ColorModel(textColor: .black, floatingLabelColor: .black, normalLabelColor: .black, outlineColor: .gray), for: .normal)
        
        nameSurname.setColorModel(ColorModel(textColor: .black, floatingLabelColor: .systemBlue, normalLabelColor: .black, outlineColor: .systemBlue), for: .editing)
        
        nameSurname.setColorModel(ColorModel(with: .disabled), for: .disabled)
        nameSurname.font = UIFont(name: "Avenir", size: 11)
        return nameSurname
    }()
    
 

    
    lazy var mail:UITextField = {
        let mail = MaterialOutlinedTextField()
        mail.text = userModel.email
        mail.placeholder = "E-Posta"
        mail.label.text = "E-Posta"
        mail.containerRadius = 6
        mail.setOutlineLineWidth(0.3, for: .normal)
        mail.setOutlineLineWidth(0.5, for: .editing)
        mail.clearButtonMode = .whileEditing
        mail.setColorModel(ColorModel(textColor: .black, floatingLabelColor: .black, normalLabelColor: .black, outlineColor: .gray), for: .normal)
        
        mail.setColorModel(ColorModel(textColor: .black, floatingLabelColor: .black, normalLabelColor: .systemBlue, outlineColor: .systemBlue), for: .editing)
        
        mail.setColorModel(ColorModel(with: .disabled), for: .disabled)
        mail.font = UIFont(name: "Avenir", size: 11)
        return mail
    }()
    
    
    lazy var gsm:UITextField = {
        let gsm = MaterialOutlinedTextField()
        gsm.text = userModel.gsm
        gsm.placeholder = "Telefon"
        gsm.label.text = "Telefon"
        gsm.containerRadius = 6
        gsm.setOutlineLineWidth(0.3, for: .normal)
        gsm.setOutlineLineWidth(0.5, for: .editing)
        gsm.clearButtonMode = .whileEditing
        gsm.setColorModel(ColorModel(textColor: .black, floatingLabelColor: .black, normalLabelColor: .black, outlineColor: .gray), for: .normal)
        
        gsm.setColorModel(ColorModel(textColor: .black, floatingLabelColor: .black, normalLabelColor: .systemBlue, outlineColor: .systemBlue), for: .editing)
        
        gsm.setColorModel(ColorModel(with: .disabled), for: .disabled)
        gsm.font = UIFont(name: "Avenir", size: 11)
        return gsm
    }()
    
    
    lazy var location1:UITextField = {
        let location = MaterialOutlinedTextField()
        location.text = userModel.nameSurname
        location.placeholder = "Şehir"
        location.label.text = "Şehir"
        location.containerRadius = 6
        location.setOutlineLineWidth(0.3, for: .normal)
        location.setOutlineLineWidth(0.5, for: .editing)
        location.clearButtonMode = .whileEditing
        location.setColorModel(ColorModel(textColor: .black, floatingLabelColor: .black, normalLabelColor: .black, outlineColor: .gray), for: .normal)
        
        location.setColorModel(ColorModel(textColor: .black, floatingLabelColor: .black, normalLabelColor: .systemBlue, outlineColor: .systemBlue), for: .editing)
        
        location.setColorModel(ColorModel(with: .disabled), for: .disabled)
        location.font = UIFont(name: "Avenir", size: 11)
        location.delegate = self
        return location
        
       

    }()
    lazy var location2:UITextField = {
        let location = MaterialOutlinedTextField()
        location.text = userModel.nameSurname
        location.placeholder = "İlçe"
        location.label.text = "İlçe"
        location.containerRadius = 6
        location.setOutlineLineWidth(0.3, for: .normal)
        location.setOutlineLineWidth(0.5, for: .editing)
        location.clearButtonMode = .whileEditing
        location.setColorModel(ColorModel(textColor: .black, floatingLabelColor: .black, normalLabelColor: .black, outlineColor: .gray), for: .normal)
        
        location.setColorModel(ColorModel(textColor: .black, floatingLabelColor: .black, normalLabelColor: .systemBlue, outlineColor: .systemBlue), for: .editing)
        
        location.setColorModel(ColorModel(with: .disabled), for: .disabled)
        location.font = UIFont(name: "Avenir", size: 11)
        location.delegate = self
        return location
        
    }()
    
    lazy var location3:UITextField = {
        let location = MaterialOutlinedTextField()
        location.text = userModel.nameSurname
        location.placeholder = "Mahalle"
        location.label.text = "Mahalle"
        location.containerRadius = 6
        location.setOutlineLineWidth(0.3, for: .normal)
        location.setOutlineLineWidth(0.5, for: .editing)
        location.clearButtonMode = .whileEditing
        location.setColorModel(ColorModel(textColor: .black, floatingLabelColor: .black, normalLabelColor: .black, outlineColor: .gray), for: .normal)
        
        location.setColorModel(ColorModel(textColor: .black, floatingLabelColor: .black, normalLabelColor: .systemBlue, outlineColor: .systemBlue), for: .editing)
        
        location.setColorModel(ColorModel(with: .disabled), for: .disabled)
        location.font = UIFont(name: "Avenir", size: 11)
        location.delegate = self
        return location
    }()

    
    lazy var SaveButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Kaydet", for: .normal)
        button.alpha = 0.5
        button.setTitleColor(UIColor(hex: "E3F2FD"), for: .normal)
        button.backgroundColor = UIColor(hex: "#40A6F8")
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 2
        button.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
        return button
    }()
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSehirler()
        adress()
        setupCustomBackButton(with:"")
        view.backgroundColor = UIColor(hex: "#F1FAFE")
        view.addSubview(header)
        view.addSubview(header2)
        navigationItem.title = "Kişisel Bilgiler"
        navigationController?.isNavigationBarHidden = false

        view.addSubview(container)
    
        container.addSubview(nameSurname)
        container.addSubview(mail)
        container.addSubview(gsm)
        container.addSubview(location1)
        container.addSubview(sehirDropdown)
        container.addSubview(ilceDropdown)
        container.addSubview(location2)
        container.addSubview(location3)
        container.addSubview(SaveButton)
        desing()
    }
    
    
    
    
    func adress (){
        
        let parcalar = userModel.adress?.components(separatedBy: "-")

        if parcalar?.count == 3 {
            let il = parcalar?[0]
            location1.text = il
            let ilce = parcalar?[1]
            location2.text = ilce
            let mahalle = parcalar?[2]
            location3.text = mahalle
            print("İl: \(il), İlçe: \(ilce), Mahalle: \(mahalle)")
        } else {
            print("Beklenen formatta bir adres değil.")
        }
        
        
        
    }
    
    


    func desing(){
        let screenHeight = UIScreen.main.bounds.height
        
        
        header.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: container.leadingAnchor, trailing:  nil,padding: .init(top: 6, left: 0, bottom: 0, right: 0))
        
        
        header2.anchor(top: header.bottomAnchor, bottom: nil, leading: header.leadingAnchor, trailing: header.trailingAnchor,padding: .init(top: 2, left: 0, bottom: 0, right: 0))
        container.anchor(top: nil,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         leading: view.leadingAnchor,
                         trailing: view.trailingAnchor,
                         padding: .init(top: 0, left: 24,
                                        bottom: 12, right: 24),size: .init(width: 0, height: screenHeight*0.75))

        
        nameSurname.anchor(top: container.topAnchor,
                    bottom: nil,
                    leading: container.leadingAnchor,
                    trailing: container.trailingAnchor,
                    padding: .init(top: 30, left: 12, bottom: 0, right: 12),
                    size: .init(width: 0, height: 36))
  
        
        mail.anchor(top: nameSurname.bottomAnchor,
                    bottom: nil,
                    leading: nameSurname.leadingAnchor,
                    trailing: nameSurname.trailingAnchor,
                    padding: .init(top: 30, left: 0, bottom: 0, right: 0),
                    size: .init(width: 0, height: 36))
        
        gsm.anchor(top: mail.bottomAnchor,
                    bottom: nil,
                    leading: nameSurname.leadingAnchor,
                    trailing: nameSurname.trailingAnchor,
                    padding: .init(top: 30, left: 0, bottom: 0, right: 0),
                    size: .init(width: 0, height: 36))
        
        location1.anchor(top: gsm.bottomAnchor,
                    bottom: nil,
                    leading: nameSurname.leadingAnchor,
                    trailing: nameSurname.trailingAnchor,
                    padding: .init(top: 30, left: 0, bottom: 0, right: 0),
                    size: .init(width: 0, height: 36))
        
        
        sehirDropdown.anchor(top: location1.bottomAnchor,
                             bottom: nil,
                               leading: location1.leadingAnchor,
                               trailing: location1.trailingAnchor,
                               size: .init(width: 0, height: 200))
        
        location2.anchor(top: location1.bottomAnchor,
                    bottom: nil,
                    leading: nameSurname.leadingAnchor,
                    trailing: nameSurname.trailingAnchor,
                    padding: .init(top: 30, left: 0, bottom: 0, right: 0),
                    size: .init(width: 0, height: 36))
        ilceDropdown.anchor(top: location2.bottomAnchor,
                            bottom: nil,
                                   leading: location2.leadingAnchor,
                                   trailing: location2.trailingAnchor,
                                   size: .init(width: 0, height: 200))
        location3.anchor(top: location2.bottomAnchor,
                    bottom: nil,
                    leading: nameSurname.leadingAnchor,
                    trailing: nameSurname.trailingAnchor,
                    padding: .init(top: 30, left: 0, bottom: 0, right: 0),
                    size: .init(width: 0, height: 36))
        
        SaveButton.anchor(top: nil,
                          bottom: container.bottomAnchor,
                    leading: nameSurname.leadingAnchor,
                    trailing: nameSurname.trailingAnchor,
                    padding: .init(top: 0, left: 0, bottom: 12, right: 0),
                    size: .init(width: 0, height: 30))
        
    }
    

    @objc func buttonClicked() {
         
        var user = UserManager.shared.getUser()
        user.nameSurname = self.nameSurname.text
        user.gsm = self.gsm.text
        user.email = self.mail.text
        user.adress = (self.location1.text ?? "") + "-" + (self.location2.text ?? "") + "-" + (self.location3.text ?? "")

        FirestoreManager().UserUpdatetPush(user: user) { result in
                switch result {
                case .success(let message):
                    print(message)
                    UserManager.shared.setUser(user: user)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        print(Date())
                        
                        print("Kullanıcı başarıyla kaydedildi")
                        self.navigationItem.title = ""
                        self.navigationController?.isNavigationBarHidden = true
                        self.navigationController?.popViewController(animated: true)
                    }

                case .failure(let error): break
                   
        
               
                    
                }
            }
      
      
        }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        SaveButton.alpha = 1
        if textField == location1 {
            container.bringSubviewToFront(sehirDropdown)
            sehirDropdown.isHidden = false  // Şehir listesi gösteriliyor
            textField.resignFirstResponder()  // Klavyeyi kapatıyoruz
        } else if textField == location2 {
            if let selectedSehir = selectedSehir {
                container.bringSubviewToFront(ilceDropdown)
                ilceDropdown.isHidden = false  // İlçe listesi gösteriliyor
            }
            textField.resignFirstResponder()  // Klavyeyi kapatıyoruz
        }
    }
    
 
    func fetchSehirler() {
        let ref = Database.database().reference()
        
        ref.child("sehirler").observeSingleEvent(of: .value, with: { snapshot in
            guard let value = snapshot.value as? [[String: Any]] else {
                print("Veri formatı hatalı.")
                return
            }
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: value)
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode([Sehir].self, from: jsonData)
                self.sehirler = decodedData
                
                self.sehirDropdown.reloadData()
            } catch let error {
                print("Veri çözümleme hatası: \(error.localizedDescription)")
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == sehirDropdown {
            return sehirler.count
        } else if tableView == ilceDropdown {
            return ilceler.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if tableView == sehirDropdown {
            cell.textLabel?.text = sehirler[indexPath.row].il
        } else if tableView == ilceDropdown {
            cell.textLabel?.text = ilceler[indexPath.row]
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == sehirDropdown {
            // Şehir seçildiğinde ilçe dropdown'u gösterilir
            selectedSehir = sehirler[indexPath.row].il
            location1.text = selectedSehir
            ilceler = sehirler[indexPath.row].ilceleri
            ilceDropdown.reloadData()
            sehirDropdown.isHidden = true  // Şehir dropdown'u gizlenir
        } else if tableView == ilceDropdown {
            // İlçe seçildiğinde ilçe dropdown'u gizlenir
            location2.text = ilceler[indexPath.row]
            ilceDropdown.isHidden = true
        }
    }



}
