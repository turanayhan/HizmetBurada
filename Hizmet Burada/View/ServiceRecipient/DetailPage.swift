//
//  ReservationDetail.swift
//  Hizmet Burada
//


import UIKit
import Firebase
import MaterialOutlinedTextField

class DetailPage: UIViewController ,UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate,UITextViewDelegate {
    var sehirler: [Sehir] = []
    var ilceler: [String] = []
    var selectedSehir: String?
    var jobid : Int = 0
    var jobDetail : String?
    var reservationDay :String =  ""
    var reservationMonth :String =  ""
    var reservationYear :String =  ""
    var reservationHour :String =  ""
    
    
  
    
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
    
    
    lazy var location1:UITextField = {
        let location = MaterialOutlinedTextField()
        location.text = userModel.nameSurname
        location.backgroundColor = .white
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
        location.backgroundColor = .white
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
        location.backgroundColor = .white
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

    
    
    
    
    var instance:[String:String] = [:]
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Tamamla", for: .normal)
        button.setTitleColor(UIColor(hex: "E3F2FD"), for: .normal)
        button.backgroundColor = .btnBlue
        button.layer.cornerRadius = 10
        button.layer.cornerRadius = 6
        button.titleLabel?.font = UIFont(name: "Avenir", size: 14)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var infoText:UITextView = {
        let infoText = UITextView()
        infoText.textColor = .black
        infoText.font = UIFont(name: "Avenir", size: 14)
        infoText.isEditable = false
        infoText.textAlignment = .center
        infoText.delegate = self
        infoText.backgroundColor = .clear
        infoText.text = "Bilmemiz gereken başka hangi detaylar var?"
        return infoText
    }()
    
    
    lazy var textBox: UITextView = {
        let textBox = UITextView()
        textBox.translatesAutoresizingMaskIntoConstraints = false // Auto Layout kullanabilmek için
        textBox.text = "Ekstra bilgileri girin..."
        textBox.textColor = UIColor.lightGray // Placeholder rengi
        textBox.backgroundColor = .black
        textBox.layer.cornerRadius = 12
        textBox.layer.borderWidth = 0.3
        textBox.layer.borderColor =  UIColor.lightGray.cgColor
        textBox.font = UIFont(name: "Avenir", size: 12)
        textBox.textAlignment = .left // Yazı hizalaması
        textBox.returnKeyType = .done // Klavyede "Tamam" tuşu
        textBox.delegate = self
        textBox.layer.masksToBounds = false // Kenar yuvarlamasının gölgesini göstermek için
        return textBox
    }()

    var key : String = ""
    
    lazy var navigationTitle:UITextView = {
        let titleLabel = UITextView()
        titleLabel.text = "Rezervasyon"
        titleLabel.textColor = .black // Başlık rengi
        titleLabel.font = UIFont(name: "Avenier", size: 12)
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = UIColor(hex: "#F1FAFE")
        return titleLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupCustomBackButton(with: "Hizmet Burada")
        view.backgroundColor = .backgroundColorWhite
        fetchSehirler()
        adress()
       
        key = infoText.text.replacingOccurrences(of: "?", with: "")
        Jobİnformation.shared.addInfo(key: key, value: textBox.text)
        
        view.addSubview(location1)
        view.addSubview(sehirDropdown)
        view.addSubview(ilceDropdown)
        view.addSubview(location2)
        view.addSubview(location3)
        desing()
        
        
    }
    

    
    
    func adress (){
        
        let parcalar = userModel.adress?.components(separatedBy: "-")

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
    
    func desing(){
    
        view.addSubview(nextButton)
        view.addSubview(infoText)
        view.addSubview(textBox)
        
        
        
        
        location1.anchor(top: textBox.bottomAnchor,
                    bottom: nil,
                    leading: textBox.leadingAnchor,
                    trailing: textBox.trailingAnchor,
                    padding: .init(top: 40, left: 0, bottom: 0, right: 0),
                    size: .init(width: 0, height: 40))
        
        
        sehirDropdown.anchor(top: location1.bottomAnchor,
                             bottom: nil,
                               leading: location1.leadingAnchor,
                               trailing: location1.trailingAnchor,
                               size: .init(width: 0, height: 200))
        
        location2.anchor(top: location1.bottomAnchor,
                    bottom: nil,
                    leading: textBox.leadingAnchor,
                    trailing: textBox.trailingAnchor,
                    padding: .init(top: 12, left: 0, bottom: 0, right: 0),
                    size: .init(width: 0, height: 36))
        ilceDropdown.anchor(top: location2.bottomAnchor,
                            bottom: nil,
                                   leading: location2.leadingAnchor,
                                   trailing: location2.trailingAnchor,
                                   size: .init(width: 0, height: 200))
        location3.anchor(top: location2.bottomAnchor,
                    bottom: nil,
                    leading: textBox.leadingAnchor,
                    trailing: textBox.trailingAnchor,
                    padding: .init(top: 12, left: 0, bottom: 0, right: 0),
                    size: .init(width: 0, height: 36))
        
        
        
        
        
        nextButton.anchor(top: nil,
                          bottom: view.safeAreaLayoutGuide.bottomAnchor,
                          leading: view.leadingAnchor,
                          trailing: view.trailingAnchor,
                          padding: .init(top: 0, left: 30, bottom: 30, right: 30),
                          size: .init(width: 0, height: 36))
        
        infoText.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                        bottom: nil,
                        leading: textBox.leadingAnchor,
                        trailing: textBox.trailingAnchor,
                        padding: .init(top: 0, left: 0, bottom: 0, right: 20),
                        size: .init(width: 0, height: 50))
        
        
        textBox.anchor(top: infoText.bottomAnchor,
                       bottom: nil,
                       leading: view.leadingAnchor,
                       trailing: view.trailingAnchor,
                       padding: .init(top: 12, left: 20, bottom: 0, right: 20),
                       size: .init(width: 0, height: 120))
        
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
        // Text alanlarının boş olup olmadığını kontrol ediyoruz
        guard let location1Text = location1.text, !location1Text.isEmpty,
              let location2Text = location2.text, !location2Text.isEmpty,
              let location3Text = location3.text, !location3Text.isEmpty,
              let textBoxText = textBox.text, !textBoxText.isEmpty, textBoxText != "Ekstra bilgileri girin..." else {
            
            // Eğer herhangi bir alan boşsa uyarı mesajı gösteriyoruz
            let alert = UIAlertController(title: "Eksik Bilgi", message: "Lütfen tüm alanları doldurun.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        Jobİnformation.shared.addInfo(key: key, value: textBox.text)
             let user = UserManager.shared.getUser()
             let uniqueID = UUID().uuidString
             let ref = Database.database().reference().child("Jobs").child(user.id!).child(String(jobid))
             instance = Jobİnformation.shared.information
             
            
             let adress = (self.location1.text ?? "") + "-" + (self.location2.text ?? "") + "-" + (self.location3.text ?? "")
        let yeni = JobModel(nameSurname: user.nameSurname!,detail:Jobİnformation.shared.jobDetail ?? "bos" , id: user.id!, information: instance,adress: adress,reservationDate: "\(reservationDay) \(reservationMonth)-\(reservationHour)",jobId: String(jobid))
        jobDetail = yeni.detail
             let dictionary = yeni.toDictionary()
        
        
        
        ref.setValue(dictionary) { (error, _) in
            if let error = error {
                print("İşlem başarısız oldu: \(error.localizedDescription)")
            } else {
                print("İşlem başarıyla tamamlandı.")
                
                var page = BusinessSuccessful()
                page.headerText = self.jobDetail ?? ""

                self.navigationController?.pushViewController(page, animated: true)

                
                
            }
        }

    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.customizeBackButton()
      
    }
    
    
    
}
