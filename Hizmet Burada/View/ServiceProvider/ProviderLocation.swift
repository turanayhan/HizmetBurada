//
//  Untitled.swift
//  Hizmet Burada
//
//  Created by turan on 17.10.2024.
//

//
//  Location.swift
//  Hizmet Burada
//
//  Created by turan on 6.01.2024.
//

import UIKit
import JGProgressHUD
import FirebaseDatabase
import MaterialOutlinedTextField


class ProviderLocation: UIViewController ,UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    
    
    var sehirler: [Sehir] = []
    var ilceler: [String] = []
    var selectedSehir: String?
    lazy var progresBar:JGProgressHUD = {
        let progresBar = JGProgressHUD(style: .light)
        progresBar.textLabel.text = "Kaydınız Gerçekleşiyor"
        return  progresBar
    }()
    
    
    
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
    
    lazy var nameSurnameText:UITextView = {
        let infoText = UITextView()
        infoText.text = "Nerede Hizmet Veriyorsun?"
        infoText.textColor = .black
        infoText.textAlignment = .center
        infoText.font = UIFont(name: "Helvetica-Bold", size: 16)
        infoText.isEditable = false
        return infoText
    }()
    
    lazy var nameSurnameText2:UITextView = {
        let infoText = UITextView()
        infoText.text = "Sana yakın bölgelerden iş fırsatlarını göndereceğiz "
        infoText.textColor = .black
        infoText.textAlignment = .center
        infoText.font = UIFont(name: "Avenir", size: 12)
        infoText.isEditable = false
        return infoText
    }()
    

    
    lazy var location1:UITextField = {
        let location = MaterialOutlinedTextField()
     
        
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

    lazy var registerBtn:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Devam", for: .normal)
        button.alpha = 0.5
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
    let userModel:User = {
        let model = UserManager.shared.getUser()
        return model
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        view.backgroundColor = UIColor(hex: "#F1FAFE")
        setupCustomBackButton(with: "")
        fetchSehirler()
        adress()
      
        navigationController?.isNavigationBarHidden = false
        view.backgroundColor = .white
        view.addSubview(nameSurnameText)
        view.addSubview(nameSurnameText2)
        view.addSubview(location1)
        view.addSubview(sehirDropdown)
        view.addSubview(ilceDropdown)
        view.addSubview(location2)
        view.addSubview(location3)
        view.addSubview(registerBtn)
        desing()
        
        // TextField değişikliklerini izliyoruz
         location1.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
         location2.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
         location3.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    
 
    
    
    
    
    func adress (){
        
        let parcalar = userModel.adress?.components(separatedBy: "/")

        // Sonuçları kontrol et
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
    
    
    @objc func textFieldDidChange(textField: UITextField) {
        // Tüm alanların boş veya sadece boşluk içerip içermediğini kontrol ediyoruz
        if location1.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
           location2.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
           location3.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            registerBtn.isEnabled = false
            registerBtn.alpha = 0.5
        } else {
            registerBtn.isEnabled = true
            registerBtn.alpha = 1
        }
    }

    
    
    func desing(){
        
        nameSurnameText.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 10, left: 40, bottom: 0, right: 40),size: .init(width: 0, height: 40))
        
        nameSurnameText2.anchor(top: nameSurnameText.bottomAnchor,
                                bottom: nil,
                                leading: view.leadingAnchor,
                                trailing: view.trailingAnchor,
                                padding: .init(top: 0, left: 0, bottom: 0,
                                               right: 0),size: .init(width: 0, height: 40))
      
        
        
        
        
        
        location1.anchor(top: nameSurnameText2.bottomAnchor,
                    bottom: nil,
                    leading: nameSurnameText.leadingAnchor,
                    trailing: nameSurnameText.trailingAnchor,
                    padding: .init(top: 20, left: 0, bottom: 0, right: 0),
                    size: .init(width: 0, height: 40))
        
        
        sehirDropdown.anchor(top: location1.bottomAnchor,
                             bottom: nil,
                               leading: location1.leadingAnchor,
                               trailing: location1.trailingAnchor,
                               size: .init(width: 0, height: 200))
        
        location2.anchor(top: location1.bottomAnchor,
                    bottom: nil,
                         leading: nameSurnameText.leadingAnchor,
                    trailing: nameSurnameText.trailingAnchor,
                    padding: .init(top: 20, left: 0, bottom: 0, right: 0),
                    size: .init(width: 0, height: 40))
        ilceDropdown.anchor(top: location2.bottomAnchor,
                            bottom: nil,
                                   leading: location2.leadingAnchor,
                                   trailing: location2.trailingAnchor,
                                   size: .init(width: 0, height: 200))
        location3.anchor(top: location2.bottomAnchor,
                    bottom: nil,
                    leading: nameSurnameText.leadingAnchor,
                    trailing: nameSurnameText.trailingAnchor,
                    padding: .init(top: 20, left: 0, bottom: 0, right: 0),
                    size: .init(width: 0, height: 40))
        
        
        
    
        registerBtn.anchor(top: nil,
                           bottom: view.safeAreaLayoutGuide.bottomAnchor,
                           leading: location3.leadingAnchor,
                           trailing: location3.trailingAnchor,
                           padding: .init(top: 0, left: 0, bottom:22, right: 0))

   
        
    }
    
    
    

    
    @objc func nextButtonTapped(click : UIButton!){
        
        
        
        let adress = (self.location1.text ?? "") + "-" + (self.location2.text ?? "") + "-" + (self.location3.text ?? "")
        
        
        
        ServiceProviderRegistration.rgİnformation.adrees = adress
        navigationController?.pushViewController(ServiceDetailPage(), animated: true)
        
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == location1 {
            view.bringSubviewToFront(sehirDropdown)
            sehirDropdown.isHidden = false  // Şehir listesi gösteriliyor
            textField.resignFirstResponder()  // Klavyeyi kapatıyoruz
        } else if textField == location2 {
            if let selectedSehir = selectedSehir {
                view.bringSubviewToFront(ilceDropdown)
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
