//
//  Meeting.swift
//  Hizmet Burada
//
//  Created by turan on 25.12.2023.
//

import UIKit
import FirebaseDatabaseInternal

class MeetingPage: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Mesajlar
  
    var messageList: [MessageModel] = []

    var jobList: [JobModel] = []

       
    var modelic : JobModel? {
        didSet {
            
            
            
        }
    }
    var jobId : String?
    
    
    
    
    lazy var imageProfile:UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(systemName:"person.crop.circle.dashed")
        logo.contentMode = .scaleAspectFill
        logo.tintColor = .systemYellow
     
        return logo
    }()
    
    
    lazy var nameSurnameText:UILabel = {
        let infoText = UILabel()
        infoText.text = "Turan Ayhan"
        infoText.textColor = .black
        infoText.textAlignment = .left
        
        infoText.font = UIFont(name: "Helvetica-Bold", size: 16)
       
        
        return infoText
    }()
    
    
    
        let tableView: UITableView = {
            let tableView = UITableView()
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.separatorStyle = .none
            tableView.allowsSelection = false
            return tableView
        }()
        
        // Mesaj giriş alanı
    let messageInputView: UITextField = {
           let textField = UITextField()
           textField.translatesAutoresizingMaskIntoConstraints = false
           textField.placeholder = "Mesajınızı buraya yazın..."
           textField.borderStyle = .roundedRect
           textField.layer.cornerRadius = 16
           textField.clipsToBounds = true
           textField.backgroundColor = .systemYellow

           let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
           imageView.image = UIImage(systemName: "plus.message.fill") // İstediğiniz ikonu
           imageView.tintColor = .gray
            
        
           return textField
       }()
        
        // Gönderme butonu
    let sendButton: UIButton = {
           let button = UIButton()
           button.addTarget(self, action: #selector(loginClick), for: .touchUpInside)
           button.translatesAutoresizingMaskIntoConstraints = false
           let iconImageView = UIImageView(image: UIImage(systemName: "paperplane.circle.fill"))
           iconImageView.tintColor = .systemYellow
           button.addSubview(iconImageView)
           iconImageView.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               iconImageView.leadingAnchor.constraint(equalTo: button.leadingAnchor),
               iconImageView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
               iconImageView.widthAnchor.constraint(equalToConstant: 56),
               iconImageView.heightAnchor.constraint(equalToConstant: 56)
           ])
 
          
           
           return button
       }()
  



        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            
            // TableView konfigürasyonu
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(Chat.self, forCellReuseIdentifier: Chat.identifier)
            
            // Gönderme butonuna eylem ekleme
            sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
            
            // View'e elemanları ekleme
            view.addSubview(tableView)
            view.addSubview(messageInputView)
            view.addSubview(sendButton)
            view.addSubview(imageProfile)
            view.addSubview(nameSurnameText)
            fetchJobData()
            desing()
    

        }
    
    
    func desing(){
        
        
        imageProfile.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil,padding: .init(top: 6, left: 12, bottom: 0, right: 0),size: .init(width: 44, height: 44))
        
        nameSurnameText.anchor(top: imageProfile.topAnchor, bottom: imageProfile.bottomAnchor, leading: imageProfile.trailingAnchor, trailing: view.trailingAnchor,padding: .init(top: 0, left: 12, bottom: 0, right: 0))
        
        
        
        tableView.anchor(top: imageProfile.bottomAnchor, bottom: messageInputView.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        messageInputView.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: sendButton.leadingAnchor,padding: .init(top: 0, left: 16, bottom: 8, right: 12), size: .init(width: 0, height: 44))
        
        
        sendButton.anchor(top: messageInputView.topAnchor, bottom: messageInputView.bottomAnchor, leading: nil, trailing: view.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 12),
                          size: .init(width: 56, height: 56)
        )
        
    }
    
    
    
    
        
        // Gönderme butonuna tıklandığında çağrılan metod
        @objc func sendButtonTapped() {
            
       
        }
        
        // TableViewDelegate ve TableViewDataSource metodları
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return messageList.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: Chat.identifier, for: indexPath) as!Chat
            

            return cell
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 36  // Örnek: Hücre yüksekliği 80 piksel
        }
    
    
    
    
    
    @objc func loginClick(click :UIButton!){
        
    
    
        }

        
 


    
    
    
    func fetchJobData() {
        jobList.removeAll()
    
        fetchJobFromDatabase { fetchedJobs in
            guard let fetchedJobs = fetchedJobs else {
                print("Veri alınamadı")
                return
            }
            for (_, jobDetails) in fetchedJobs {
                if let jobDetailDict = jobDetails as? [String: Any] {
                    for (_, jobInfo) in jobDetailDict {
                        if let jobInfoDict = jobInfo as? [String: Any] {
                      
                            let nameSurname = jobInfoDict["nameSurname"] as? String ?? ""
                            let detail = jobInfoDict["detail"] as? String ?? ""
                            let address = jobInfoDict["adress"] as? String ?? ""
                            let reservationDate = jobInfoDict["reservationDate"] as? String ?? ""
                            let announcementDate = jobInfoDict["announcementDate"] as? String ?? ""
                            let jobId = jobInfoDict["jobId"] as? String ?? ""
                            var hasBid = false // Teklif durumu
                            
                            var bids: [BidModel] = []
                            if let bidsData = jobInfoDict["bids"] as? [String: [String: Any]] {
                                for (bidId, bidInfoDict) in bidsData {
                                    if bidId == UserManager.shared.getUser().id {
                                        hasBid = true
                                    }

                                    if let bidDate = bidInfoDict["bidDate"] as? String,
                                       let message = bidInfoDict["message"] as? String,
                                       let price = bidInfoDict["price"] as? Double,
                                       let providerId = bidInfoDict["providerId"] as? String,
                                       let providerName = bidInfoDict["providerName"] as? String {
                                        let bid = BidModel(id: bidId, providerId: providerId, providerName: providerName, price: price, message: message, bidDate: bidDate, messages: [])
                                        bids.append(bid)
                                    }
                                }
                            } else {
                                print("Teklifler boş veya yanlış formatta.")
                            }

                            let jobModel = JobModel(
                                nameSurname: nameSurname,
                                detail: detail,
                                id: jobInfoDict["id"] as? String ?? "",
                                information: jobInfoDict["information"] as? [String: String] ?? [:],
                                adress: address,
                                announcementDate: announcementDate,
                                reservationDate: reservationDate,
                                bids: bids,
                                jobId: jobId,
                                status: hasBid
                            )
                            
                            if jobModel.status == true {
                                
                                self.jobList.append(jobModel)
                                
                               
                                
                            }
                            

                          
                        }
                    }
                }
            }
           
        }
    }
    
    func fetchJobFromDatabase(completion: @escaping ([String: Any]?) -> Void) {
        let ref = Database.database().reference().child("Jobs")
        
        ref.observe(.value) { snapshot in
            guard let value = snapshot.value as? [String: Any] else {
                completion(nil)
                return
            }
            self.jobList.removeAll()
            completion(value)
        }
    }
    
    
    
    
    
    
        
        
        
        
    }
    
    
    
    
