import UIKit
import FirebaseDatabaseInternal
import SideMenu
import JGProgressHUD

class RecipientNotify: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let notifications = [
        Notifications(username: "Temizlik Burada", date: "14 Kasım 2023", commentText: "Ev olsun, ofis olsun, araba olsun... Neyi temizlemek istiyorsan, aradığın yardım bu uygulamada."),
        Notifications(username: "Tesisatçı Mehmet Usta", date: "19 Kasım 2023", commentText: "Sızdıran musluklardan, su tesisatı yenilemeye kadar tüm tesisat işleriniz için güvenilir hizmet."),
        Notifications(username: "Mobilya Montaj Hizmeti", date: "21 Kasım 2023", commentText: "Evinize gelen yeni mobilyaları hızlı ve güvenli şekilde monte ediyoruz. Zahmetsiz hizmet!")
    ]

    let tableView: UITableView = {
        let table = UITableView()
        table.tag = 1
        table.backgroundColor = .clear
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customnNavigation()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setDefaultBackgroundColor()

        // TableView setup
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(notificationCell.self, forCellReuseIdentifier: "notificationCell")
        tableView.backgroundColor = .backgroundColorWhite
        tableView.separatorStyle = .none

        // Constraints
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // MARK: - UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath) as? notificationCell else {
            return UITableViewCell()
        }

        let notification = notifications[indexPath.row]
        cell.backgroundColor = .backgroundColorWhite
        cell.titleLabel.text = notification.username
        cell.date.text = notification.date
        cell.commentText.text = notification.commentText

        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
}
