
//

import UIKit
import FirebaseDatabaseInternal
import SideMenu
import JGProgressHUD

class Message: UIViewController ,UITableViewDataSource, UITableViewDelegate  {
   
    

    var JobModelList: [JobModel] = []
    var firebaseManager = FirestoreManager()
    let screenHeight = UIScreen.main.bounds.height
    let chatmanager = ChatManager()
    var chatList : [ChatWithUsersModel] = []
  
    
    lazy var separatorLine:UIView = {
        
        // Çizgi oluşturma
        let separatorLine = UIView()
        separatorLine.backgroundColor = .lightGray // Çizginin rengini ayarlayın
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        return separatorLine
    }()
    
    lazy var header:UITextView = {
        let header = UITextView()
        header.text = "Mesajlarım"
        header.font = UIFont(name: "Avenier", size: 12)
        header.textColor = .black
        header.backgroundColor = .clear
        header.textAlignment = .center
        
        return header
    }()
    
    lazy var descripiton:UITextView = {
        let descripiton = UITextView()
        descripiton.text = "Hizmet sağlayıcılarla iletişime geçebilir, teklifleri ve detayları bu ekrandan \nkolayca konuşabilirsin."
        descripiton.textColor = .darkGray
        descripiton.font = UIFont(name: "Avenir", size: 10)
        descripiton.backgroundColor = .clear
        descripiton.textAlignment = .center
        
        return descripiton
    }()
    
    lazy var progresBar: JGProgressHUD = {
        let progresBar = JGProgressHUD(style: .light)
        return progresBar
    }()
    
    lazy var logo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "7118857_3394898")
        logo.contentMode = .scaleAspectFit
        logo.backgroundColor = .clear
        return logo
    }()
    
    lazy var container : UIView = {
        
        let container = UIView()
        container.isHidden = false
        container.backgroundColor = .clear
        return container
    }()
    
    
    let tableView: UITableView = {
        let table = UITableView()
        table.tag = 1
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.allowsMultipleSelection = false
        return table
    }()
 
    
    override func viewWillAppear(_ animated: Bool) {
        customnNavigation()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.backgroundColor = .backgroundColorWhite
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        desin()
        tableView.register(messageCell.self, forCellReuseIdentifier: "customCell")
        
        
        getMessages()
        
       
        
        
        
    }
    
    func desin(){
        
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height

        view.addSubview(container)
        container.addSubview(logo)
        container.addSubview(header)
        container.addSubview(descripiton)
        
        tableView.anchor(top: view.topAnchor,
                         bottom: view.bottomAnchor,
                         leading: view.leadingAnchor,
                         trailing: view.trailingAnchor
        )
        container.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         leading: view.leadingAnchor,
                         trailing: view.trailingAnchor,
                         size: .init(width: 0,
                                     height: 0)
        )
        
        logo.anchor(top: nil,
                    bottom: header.topAnchor,
                    leading: nil,
                    trailing: nil,
                    size: .init(width: width*0.7, height: 0.8*width)
        )
        logo.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true

        
        
        header.anchor(top: nil,
                      bottom: descripiton.topAnchor,
                      leading: container.leadingAnchor,
                      trailing: container.trailingAnchor,
                      size: .init(width: 0,
                                  height: 30)
        )
       
        
        descripiton.anchor(top: nil,
                           bottom: container.bottomAnchor,
                           leading: container.leadingAnchor,
                           trailing: container.trailingAnchor,
                           padding: .init(top: 0,
                                          left: 0,
                                          bottom: 24,
                                          right: 0),
                           size: .init(width: 0,
                                       height: 50)
        )
        
    }
    
    
    
    // UITableViewDataSource fonksiyonları
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! messageCell
        cell.backgroundColor = .clear // Varsayılan arka plan rengi
        cell.selectionStyle = .none
        cell.model = chatList[indexPath.row].participantsInfo[0]
        cell.question = chatList[indexPath.row].chat
        cell.lastMessage = chatList[indexPath.row].chat.lastMessage
        
        
        
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Animate the selection
        UIView.animate(withDuration: 0.3) {
            if let selectedCell = tableView.cellForRow(at: indexPath) as? messageCell {
   
            }
            let detailViewController = ChatPage()
            detailViewController.modelic = self.chatList[indexPath.row]
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        // Animate the deselection
        UIView.animate(withDuration: 0.3) {
            if let deselectedCell = tableView.cellForRow(at: indexPath) as? messageCell {
                deselectedCell.backgroundColor = .clear // veya varsayılan arka plan rengi
            }
        }
    }





    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70 // İstediğiniz yükseklik değerini buraya girin
    }
  
    



    func getMessages() {
        self.chatmanager.fetchUserChats(userID: UserManager.shared.getUser().id!) { chats in
            if chats.isEmpty {
                print("Kullanıcının hiç sohbeti yok.")
            } else {
                for chatID in chats {
                    self.chatmanager.observeChat(chatID: chatID) { chat in
                        self.chatList.removeAll()
                        guard let chat = chat else {
                            print("Sohbet bilgileri alınamadı.")
                            return
                        }
                        
                        let model = ChatModel(chatID: chatID, participants: chat.participants, timestamp: chat.timestamp,lastMessage: chat.lastMessage)
                        
                        self.getUserİnfo(userIds: model.participants) { users in
                            let chatWithUsersModel = ChatWithUsersModel(chat: model, participantsInfo: users)
                            self.chatList.append(chatWithUsersModel)
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }

    
    
    func getUserİnfo(userIds: [String], completion: @escaping ([User]) -> Void) {
        self.chatmanager.fetchUsers(userIDs: userIds) { users in
            var userModels: [User] = []
            for user in users {
                
                if user.id != UserManager.shared.getUser().id {
                    
                    let userModel = User(nameSurname: user.nameSurname,gsm: user.gsm,email: user.email,id: user.id,status: user.status,adress: user.adress,profileImage: user.profileImage )
                    
                    userModels.append(userModel)
        
                    
                }
                
                
            }
            completion(userModels)
        }
    }


    
}
