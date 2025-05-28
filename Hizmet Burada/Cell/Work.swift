//
//  JobsCell.swift
//  Hizmet Burada
//
//  Created by turan on 6.01.2024.
//

import UIKit

protocol WorkDelegate: AnyObject {
    func didTapButton(in cell: Work)
}


class Work: UITableViewCell , UITableViewDelegate, UITableViewDataSource {
    
    
    weak var delegate: WorkDelegate?
    
    lazy var separatorLine:UIView = {
        
        // Çizgi oluşturma
        let separatorLine = UIView()
        separatorLine.backgroundColor = .lightGray // Çizginin rengini ayarlayın
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        return separatorLine
    }()


    
    let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#F2F4F7")
        view.layer.cornerRadius = 4
        view.layer.borderWidth = 0.2
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        view.layer.shadowOpacity = 0.1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
  
    let date: UILabel = {
        let date = UILabel()
        date.textColor = .darkGray
        date.textAlignment = .center
        date.font = UIFont(name: "Avenir", size: 11)
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()
    
    let jobName: UILabel = {
        let jobName = UILabel()
        jobName.textAlignment = .center
        jobName.font =  UIFont(name: "Avenir", size: 14)
        jobName.translatesAutoresizingMaskIntoConstraints = false
        return jobName
    }()
    
    lazy var profileImage: UIImageView = {
       let profileImage = UIImageView()
        profileImage.image = UIImage(named: "job_offer")
        profileImage.contentMode = .scaleAspectFill
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = 12
        return profileImage
    }()
    
  
   
    
    let jobStatus: UILabel = {
        let jobStatus = UILabel()
        
        jobStatus.font = UIFont(name: "Avenir", size: 11)
        jobStatus.numberOfLines = 0
        jobStatus.textAlignment = .center
        jobStatus.textColor = .darkGray
        jobStatus.text = "Talebin için teklifler toplanıyor. Teklifler gelmeye başladığında \nhemen bildireceğiz."

        return jobStatus
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Detaylara Bak", for: .normal)
        button.setTitleColor(UIColor(hex: "E3F2FD"), for: .normal)
        button.backgroundColor = .btnBlue
        button.layer.cornerRadius = 4
        button.titleLabel?.font = UIFont(name: "Avenir", size: 12)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
           return button
       }()
    

    
    
    lazy var dropdownButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName:"ellipsis") // Resmin ismini gir
        button.setImage(image, for: .normal)
        button.tintColor = .black  // Resmin rengini ayarlayabilirsin
        button.layer.borderColor = UIColor.lightGray.cgColor
   
        button.addTarget(self, action: #selector(toggleDropdown), for: .touchUpInside)
        return button
    }()
    
    
    lazy var ilceDropdown: UITableView = {
        let tableView = UITableView()
        tableView.layer.borderWidth = 0.5
        tableView.layer.borderColor = UIColor.lightGray.cgColor
        tableView.layer.cornerRadius = 5
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none  // Alt çizgiyi kaldır
        tableView.isHidden = true  // Başlangıçta gizli
        return tableView
    }()
    let ilceList = ["Tekliflere bak", "Detaylara bak", "Talebi iptal et"]  // İlçeler
    var selectedIlce: String?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
   
        contentView.addSubview(cardView)
        cardView.addSubview(date)
        cardView.addSubview(jobName)
        cardView.addSubview(jobStatus)
        cardView.addSubview(separatorLine)
        cardView.addSubview(profileImage)
        cardView.addSubview(nextButton)
        cardView.addSubview(dropdownButton)
        cardView.addSubview(ilceDropdown)
       
        desing()
     
        
       
    }
    
    
    
    
    // TableView için kaç satır olacağını belirtiyoruz
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ilceList.count
    }

    // Her bir hücre için veriyi sağlıyoruz
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = ilceList[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Avenir", size: 10)
        cell.selectionStyle = .none


        return cell
    }
    // UITableViewDelegate metodunu ekliyoruz
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 36 // Burada istediğin sabit yüksekliği belirleyebilirsin
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIlce = ilceList[indexPath.row]
        
        // Dropdown butonunun başlığını güncelle
        dropdownButton.setTitle(selectedIlce, for: .normal)
        ilceDropdown.isHidden = true  // Dropdown'u gizle
        
  
    }

    
    
    @objc func toggleDropdown() {
        ilceDropdown.isHidden.toggle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func nextButtonTapped2() {
        delegate?.didTapButton(in: self)
    }
    
    
    func desing(){
        
        cardView.anchor(top: contentView.topAnchor, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor,padding: .init(top: 16, left: 16, bottom: 0, right: 16))
        
    
        
        
        date.anchor(top: cardView.topAnchor, bottom: nil, leading: cardView.leadingAnchor, trailing: cardView.trailingAnchor,padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        jobName.anchor(top: date.bottomAnchor, bottom: nil, leading: cardView.leadingAnchor, trailing: cardView.trailingAnchor,padding: .init(top: 6, left: 0, bottom: 0, right: 0))
        
        
        separatorLine.anchor(top: jobName.bottomAnchor, bottom: nil, leading: cardView.leadingAnchor, trailing: cardView.trailingAnchor,padding: .init(top: 8, left: 0, bottom: 0, right: 0),size: .init(width: 0, height: 0.5))
        
        jobStatus.anchor(top: separatorLine.bottomAnchor, bottom: nil, leading: cardView.leadingAnchor, trailing: cardView.trailingAnchor,padding: .init(top: 8, left: 12, bottom: 0, right: 12),size: .init(width: 0, height: 0))
        
        profileImage.anchor(top: jobStatus.bottomAnchor, bottom: nextButton.topAnchor, leading: nil, trailing: nil,padding: .init(top: 0, left: 0, bottom: 0, right: 0),size: .init(width: 50, height: 50))
        profileImage.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
        
        nextButton.anchor(top: nil, bottom: cardView.bottomAnchor, leading: cardView.leadingAnchor, trailing: cardView.trailingAnchor,padding: .init(top: 0, left: 12, bottom: 8, right: 12),size: .init(width: 0, height: 26))
        
        
        dropdownButton.anchor(top: cardView.topAnchor, bottom: nil, leading: nil, trailing: cardView.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 12), size: .init(width: 20, height: 20))
        
        ilceDropdown.anchor(top: dropdownButton.bottomAnchor,
                            bottom: nextButton.topAnchor,
                                   leading: nil,
                                   trailing: cardView.trailingAnchor,
                            padding: .init(top: 0, left: 0, bottom: 0, right: 6),
                            
                                   size: .init(width: 100, height: 0))

    
    }
    @objc private func nextButtonTapped() {
     
        nextButtonTapped2()
        }
    
    
    @objc private func deleteButtonTapped() {
        // Uyarı mesajı oluşturma
        let alertController = UIAlertController(
            title: "Silmek istediğinizden emin misiniz?",
            message: "Bu işlem geri alınamaz. İlgili hizmeti kalıcı olarak silmek üzeresiniz.",
            preferredStyle: .alert
        )

        // "Sil" butonu
        let deleteAction = UIAlertAction(title: "Sil", style: .destructive) { _ in
            // Silme işlemi burada yapılabilir
            print("İşlem silindi")
        }

        // "İptal" butonu
        let cancelAction = UIAlertAction(title: "İptal", style: .cancel) { _ in
            print("Silme işlemi iptal edildi")
        }

        // Butonları ekleme
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)

        // Uyarıyı sunma
        if let topController = UIApplication.shared.keyWindow?.rootViewController {
            topController.present(alertController, animated: true, completion: nil)
        }
    }

    
    
    
}
