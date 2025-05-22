//
//  Chat.swift
//  Hizmet Burada
//
//  Created by turan on 13.01.2024.
//

import UIKit
import FirebaseDatabaseInternal

class ChatPage: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var chatmanager = ChatManager()
    var id: String?
    
    var userRecipient : User?
    var userSender  :User?
    
    var messageList: [MessageModel] = []
    
    var modelic : ChatWithUsersModel? {
        didSet {
            
            id = modelic?.chat.chatID
            
            userRecipient = modelic?.participantsInfo[0]
            userSender = UserManager.shared.getUser()
            
        }
    }

        let tableView: UITableView = {
            let tableView = UITableView()
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.separatorStyle = .none
            tableView.allowsSelection = false
            tableView.backgroundColor = .clear
            tableView.estimatedRowHeight = 44 // Öngörülen minimum yükseklik
            tableView.rowHeight = UITableView.automaticDimension

            return tableView
        }()
        
    lazy var rightButton: UIButton = {
        let rightButton = UIButton(type: .system)
        if let image = UIImage(systemName: "photo") {
            let largerImage = image.withConfiguration(UIImage.SymbolConfiguration(pointSize: 24, weight: .light))
            rightButton.tintColor = .lightGray
            rightButton.setImage(largerImage, for: .normal)
        }
    
        rightButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        return rightButton
    }()
    
    lazy var leftButton:UIButton = {
        
        let leftButton = UIButton(type: .system)
        if let image = UIImage(systemName: "plus") {
            let largerImage = image.withConfiguration(UIImage.SymbolConfiguration(pointSize: 28, weight: .light))
            leftButton.setImage(largerImage, for: .normal)
        }
        leftButton.tintColor = .lightGray

        leftButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        return leftButton
    }()
    
    let messageInputView: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Mesajınızı buraya yazın..."
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 4
        textField.clipsToBounds = true
        textField.backgroundColor = UIColor(hex: "E3F2FD")
        textField.font = UIFont.systemFont(ofSize: 12)
        return textField
    }()
    
    lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        
        // Gönder simgesini ekle
        if let sendIcon = UIImage(systemName: "paperplane.circle.fill") {
            let resizedIcon = sendIcon.withConfiguration(UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
            button.setImage(resizedIcon, for: .normal)
        }
        
  
        button.tintColor = UIColor(hex: "40A6F8")
        
       
        button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        return button
    }()

    

    // Input view genişlik ölçüleri
    let expandedWidth: CGFloat = UIScreen.main.bounds.width * 0.8
    let collapsedWidth: CGFloat = UIScreen.main.bounds.width * 0.65
    var messageInputWidthConstraint: NSLayoutConstraint?

    @objc func textFieldDidChange() {
        // `Send` butonunu metin dolu olduğunda göster, boş olduğunda gizle
        sendButton.isHidden = messageInputView.text!.isEmpty

        // Yeni genişliği ayarlamadan önce mevcut constraint'i kaldır
        messageInputWidthConstraint?.isActive = false

        // İçerik varsa küçült, yoksa genişliği eski haline getir
        let newWidth = messageInputView.text!.isEmpty ? expandedWidth : collapsedWidth
        messageInputWidthConstraint = messageInputView.widthAnchor.constraint(equalToConstant: newWidth)
        messageInputWidthConstraint?.isActive = true
        
        // Animasyon ile layout güncelle
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    @objc func sendMessage() {
        guard let text = messageInputView.text, !text.isEmpty else {
            print("Mesaj boş olamaz.")
            return
        }

        // Mesaj gönderildikten sonra input temizlenir ve genişliği eski haline döner
        messageInputView.text = ""
        sendButton.isHidden = true

        // Eski genişliğe döndürmek için mevcut constraint'i kaldır ve yenisini uygula
        messageInputWidthConstraint?.isActive = false
        messageInputWidthConstraint = messageInputView.widthAnchor.constraint(equalToConstant: expandedWidth)
        messageInputWidthConstraint?.isActive = true

        self.chatmanager.sendMessage(chatID: id ?? "0", senderID: userSender?.id ?? "0", recipientID: userRecipient?.id ?? "0", text: text) { result in
            switch result {
            case .success():
                print("Mesaj başarıyla gönderildi.")
            
                self.tableView.reloadData()
            case .failure(let error):
                print("Mesaj gönderme hatası: \(error.localizedDescription)")
            }
        }
        
        
        
      

        
        

        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }



  
  

    let containerView = UIView()

        override func viewDidLoad() {
            super.viewDidLoad()
            setDefaultBackgroundColor()
            getMessages(id: id ?? "0")
            setupCustomBackButtons(with: "")
            sendButton.isHidden = true

      
            // TableView konfigürasyonu
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(Chat.self, forCellReuseIdentifier: Chat.identifier)
            
            // Gönderme butonuna eylem ekleme
            
            // View'e elemanları ekleme
            view.addSubview(tableView)
            view.addSubview(messageInputView)
            view.addSubview(leftButton)
            view.addSubview(rightButton)
            view.addSubview(sendButton)
            messageInputWidthConstraint = messageInputView.widthAnchor.constraint(equalToConstant: expandedWidth)
               messageInputWidthConstraint?.isActive = true

            messageInputView.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
            
            
                  NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
                  NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)

    
            desing()
            
            // Ekrana dokunma algılayıcı ekleme
               let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
               view.addGestureRecognizer(tapGesture)
    

        }
    
    @objc func dismissKeyboard() {
        messageInputView.resignFirstResponder()
    }
    
    
    func getMessages(id: String) {
   


        chatmanager.observeMessages(chatID: id) { [weak self] newMessages in
            self?.messageList.removeAll()
            self?.messageList.append(contentsOf: newMessages)
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                
                // Mesaj sayısını kontrol et ve uygun bir işlem yap
                if self?.messageList.isEmpty == true {
                    // Eğer mesaj yoksa, kullanıcıya bilgi verebilirsiniz
                    print("Henüz mesaj yok.")
                }
            }
        }
    }

        
        
    
    
 
   @objc func handleKeyboardShow(notification: Notification) {
          guard let userInfo = notification.userInfo,
                let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
          
          // Klavye yüksekliği kadar alt alanı yukarı kaldır
          let keyboardHeight = keyboardFrame.height
          UIView.animate(withDuration: 0.3) {
              self.view.frame.origin.y = -keyboardHeight
          }
      }

      // Klavye kapandığında çağrılan metod
  @objc func handleKeyboardHide(notification: Notification) {
          UIView.animate(withDuration: 0.3) {
              self.view.frame.origin.y = 0
          }
      }
    
    
    
    
    func setupCustomBackButtons(with title: String) {
         // Geri düğmesi
         let backButton = UIBarButtonItem(
             image: UIImage(systemName: "chevron.backward"),
             style: .plain,
             target: self,
             action: #selector(backButtonTapped)
         )
         backButton.tintColor = .black
         navigationItem.leftBarButtonItem = backButton
       
        
         let profileImageView = UIImageView()
        profileImageView.image = UIImage(systemName: "person.crop.circle.dashed") // Profil resmi adı
         profileImageView.contentMode = .scaleAspectFill
         profileImageView.layer.cornerRadius = 18 // Yuvarlak yapmak için
         profileImageView.layer.masksToBounds = true
         
         
         let nameLabel = UILabel()
        nameLabel.text = userRecipient?.nameSurname // Kullanıcı adı
         nameLabel.font = UIFont(name: "Avenir-heavy", size: 14)
         nameLabel.textColor = .black
        let nameLabel2 = UILabel()
        nameLabel2.text = "Profili görmek için dokun" // Kullanıcı adı
        nameLabel2.font = UIFont(name: "Avenir", size: 10)
        nameLabel2.textColor = .black
       
         let phoneButton = UIButton(type: .system)
         phoneButton.setImage(UIImage(systemName: "phone.fill"), for: .normal) // Telefon ikonu
      
         phoneButton.addTarget(self, action: #selector(callButtonTapped), for: .touchUpInside)
         navigationItem.titleView = containerView
        
        containerView.anchor(top: nil, bottom: nil, leading: nil, trailing: nil,size: .init(width: UIScreen.main.bounds.width * 0.8, height: 44))
        
         containerView.addSubview(profileImageView)
         containerView.addSubview(nameLabel)
         containerView.addSubview(nameLabel2)
         containerView.addSubview(phoneButton)
         messageInputView.addSubview(rightButton)
        
        profileImageView.anchor(top: nil, bottom: nil, leading: containerView.leadingAnchor, trailing: nil,size: .init(width: 42, height: 42))
         profileImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        profileImageView.tintColor = UIColor(hex: "40A6F8")
        nameLabel.anchor(top: profileImageView.topAnchor, bottom: nil, leading: profileImageView.trailingAnchor, trailing: nil,padding: .init(top: 0, left: 12, bottom: 0, right: 0))
        nameLabel2.anchor(top: nameLabel.bottomAnchor, bottom: nil, leading: nameLabel.leadingAnchor, trailing: nil,padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        phoneButton.anchor(top: nameLabel.topAnchor, bottom: nameLabel2.bottomAnchor, leading: nil, trailing: containerView.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 0),size: .init(width: 0, height: 0))
        phoneButton.tintColor = .black
        
        rightButton.anchor(top: nil, bottom: nil, leading: nil, trailing: messageInputView.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 4),size: .init(width: 0, height: 24))
        
     }

     
     @objc func callButtonTapped() {
         print("Telefon butonuna tıklandı.")
         // Telefon butonuna basıldığında yapılacak işlemler
     }
    
    
    
    func desing(){
   
        tableView.anchor(top:view.safeAreaLayoutGuide.topAnchor, bottom: messageInputView.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        messageInputView.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: leftButton.trailingAnchor, trailing: nil,padding: .init(top: 0, left: 6, bottom: 8, right: 12), size: .init(width: UIScreen.main.bounds.width * 0.8, height: 36))
        
        leftButton.anchor(top: nil, bottom: nil, leading: view.leadingAnchor, trailing: nil,padding: .init(top: 0, left: 16, bottom: 0, right: 0),size: .init(width: 33, height: 33))
        leftButton.centerYAnchor.constraint(equalTo: messageInputView.centerYAnchor).isActive = true
        sendButton.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: messageInputView.trailingAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 4, bottom: 0, right: 8))
            sendButton.centerYAnchor.constraint(equalTo: messageInputView.centerYAnchor).isActive = true
        rightButton.anchor(top: nil, bottom: nil, leading: nil, trailing: messageInputView.trailingAnchor,
                           padding: .init(top: 0, left: 0, bottom: 0, right: 4),
                           size: .init(width: 30, height: 30)) // Boyutu biraz büyütün
        rightButton.centerYAnchor.constraint(equalTo: messageInputView.centerYAnchor).isActive = true

      
        
    }
    
    
    
    
        
        // Gönderme butonuna tıklandığında çağrılan metod
        @objc func sendButtonTapped() {
            
       
        }
        
        // TableViewDelegate ve TableViewDataSource metodları
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return messageList.count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Chat.identifier, for: indexPath) as! Chat
        cell.backgroundColor = .clear
        
        let message = messageList[indexPath.row]
        cell.modelic = message
        if message.senderID == userSender?.id{
            cell.configure(sentByCurrentUser: true)
        } else {
            cell.configure(sentByCurrentUser: false)
        }
        
        return cell
    }


    
    
    
    
    
    @objc func loginClick(click :UIButton!){
        
    
    
        }

        
    }
