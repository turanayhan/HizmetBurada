import UIKit

class NotificationPage: UITableViewController {
    
    // Örnek veri kaynağı
 

    let notifications = [
        Notifications(username: "Temizlik Burada", date: "14 Kasım 2023", commentText: "Ev olsun, ofis olsun, araba olsun... Neyi temizlemek istiyorsan, aradığın yardım bu uygulamada."),

        Notifications(username: "Tesisatçı Mehmet Usta", date: "19 Kasım 2023", commentText: "Sızdıran musluklardan, su tesisatı yenilemeye kadar tüm tesisat işleriniz için güvenilir hizmet."),
       
        Notifications(username: "Mobilya Montaj Hizmeti", date: "21 Kasım 2023", commentText: "Evinize gelen yeni mobilyaları hızlı ve güvenli şekilde monte ediyoruz. Zahmetsiz hizmet!"),
      
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.register(notificationCell.self, forCellReuseIdentifier: "notificationCell")
        tableView.backgroundColor = .backgroundColorWhite
        tableView.separatorStyle = .none
    }
    


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath) as? notificationCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .backgroundColorWhite
        cell.titleLabel.text = notifications[indexPath.row].username
        cell.date.text = notifications[indexPath.row].date
        cell.commentText.text = notifications[indexPath.row].commentText
    
     
        
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
}



