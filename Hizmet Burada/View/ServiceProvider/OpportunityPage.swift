import UIKit
import Firebase
import JGProgressHUD
import SideMenu

class OpportunityPage: UIViewController, UITableViewDataSource, UITableViewDelegate, CustomCellDelegate {
    
    lazy var progressHUD: JGProgressHUD = {
        let progressHUD = JGProgressHUD(style: .light)
        progressHUD.indicatorView = JGProgressHUDIndeterminateIndicatorView()
        return progressHUD
    }()
    
    var jobList: [JobModel] = []
    var firestoreManager = FirestoreManager()
    let screenHeight = UIScreen.main.bounds.height
  
    let tableView: UITableView = {
        let table = UITableView()
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
        fetchJobData()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
  
        tableView.register(WorkOp.self, forCellReuseIdentifier: "customCell")
        
        
        
    }
    
    
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! WorkOp
        cell.delegate = self
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.modelDetail = jobList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let calculatedHeight = screenHeight * 0.22
        let minHeight: CGFloat = 170.0 // Belirlediğiniz minimum yükseklik
        return max(calculatedHeight, minHeight)
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
                            // JobModel oluşturma
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
                                        hasBid = true // Kullanıcı teklif vermiş
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
                                id: jobInfoDict["id"] as? String ?? "", // İş ID'sini buradan alıyoruz
                                information: jobInfoDict["information"] as? [String: String] ?? [:], // Bilgiler
                                adress: address,
                                announcementDate: announcementDate,
                                reservationDate: reservationDate,
                                bids: bids,
                                jobId: jobId,
                                status: hasBid
                            )

                            self.jobList.append(jobModel)
                        }
                    }
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.progressHUD.dismiss(afterDelay: 2.0)
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

    func didTapButton(in cell: WorkOp) {
        if let indexPath = tableView.indexPath(for: cell) {
            let detailViewController = JobsDetailPage()
            detailViewController.modelic = jobList[indexPath.row]
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}
