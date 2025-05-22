import UIKit
import JGProgressHUD
import FLAnimatedImage
class BusinessSuccessful: UIViewController,UITableViewDataSource, UITableViewDelegate  {
    
    
    var firebaseService = ServiceManager()
    var categories: [Category] = []
    
    var headerText : String = ""
   
    let firestoreManager = FirestoreManager()
    
   

    let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    lazy var gifImage:FLAnimatedImageView = {
        let gifImageView = FLAnimatedImageView()
        gifImageView.translatesAutoresizingMaskIntoConstraints = false
        if let path = Bundle.main.path(forResource: "congratulations-13773_256", ofType: "gif"),
           let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            let animatedImage = FLAnimatedImage(animatedGIFData: data)
            gifImageView.animatedImage = animatedImage
        }
        return gifImageView
    }()

    lazy var header:UITextView = {
        let infoText = UITextView()
        infoText.textColor = .black
        infoText.font = UIFont(name: "Avenir-heavy", size: 14)
        infoText.isEditable = false
        infoText.textAlignment = .left
        infoText.backgroundColor = .clear
        infoText.text = "\(headerText) talebini aldık!"
        return infoText
    }()
    
    
    
    lazy var desc:UITextView = {
        let description = UITextView()
        description.textColor = .lightGray
        description.font = UIFont(name: "Avenir", size: 11)
        description.isEditable = false
        description.textAlignment = .left
        description.backgroundColor = .clear
        description.text = "Hizmet verenler teklif verdiğinde email,SMS ile\nbilgilendirme yapacağız."
        return description
    }()
    
    
    
    lazy var worksTableView: UITableView = {
        let worksTableView = UITableView()
        worksTableView.backgroundColor = .clear
        
        worksTableView.separatorStyle = .none
        
        return worksTableView
    }()
    
    lazy var progresBar:JGProgressHUD = {
        let progresBar = JGProgressHUD(style: .light)
        return  progresBar
        
    }()
    
    lazy var separatorLine:UIView = {
        
        // Çizgi oluşturma
        let separatorLine = UIView()
        separatorLine.backgroundColor = .lightGray // Çizginin rengini ayarlayın
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        return separatorLine
    }()
    
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("İŞLERİME GİT", for: .normal)
        button.setTitleColor(UIColor(hex: "E3F2FD"), for: .normal)
        button.backgroundColor = UIColor(hex: "#40A6F8")
        button.layer.cornerRadius = 4
        button.titleLabel?.font = UIFont(name: "Avenir", size: 12)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
           return button
       }()
    
    
    @objc private func nextButtonTapped() {
        navigationController?.pushViewController(MyworksPage(), animated: true)
       
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        customnNavigation()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(worksTableView)
        view.addSubview(cardView)
        cardView.addSubview(header)
        cardView.addSubview(gifImage)
        cardView.addSubview(desc)
        cardView.addSubview(nextButton)
        view.backgroundColor = .backgroundColorWhite
        worksTableView.translatesAutoresizingMaskIntoConstraints = false
        worksTableView.dataSource = self
        worksTableView.delegate = self
        worksTableView.register(jobVr.self, forCellReuseIdentifier: "re")
        desing()
        firebase()

        self.navigationController?.navigationBar.addSubview(separatorLine)
        NSLayoutConstraint.activate([
            separatorLine.leadingAnchor.constraint(equalTo: self.navigationController!.navigationBar.leadingAnchor),
            separatorLine.trailingAnchor.constraint(equalTo: self.navigationController!.navigationBar.trailingAnchor),
            separatorLine.bottomAnchor.constraint(equalTo: self.navigationController!.navigationBar.bottomAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: 0.3) // Çizgi yüksekliği
        ])
        
    }
    
    func desing (){
    
        gifImage.anchor(top: cardView.topAnchor, bottom: nil, leading: cardView.leadingAnchor, trailing: nil,padding: .init(top: 0, left: 0, bottom: 0, right: 0),size: .init(width: 120, height: 120))
  
        
        header.anchor(top: nil, bottom: nil, leading: gifImage.trailingAnchor, trailing: cardView.trailingAnchor,padding: .init(top: 0, left: -10, bottom: 0, right: 0),size: .init(width: 0, height: 30))
        header.centerYAnchor.constraint(equalTo: gifImage.centerYAnchor).isActive = true
       
        desc.anchor(top: header.bottomAnchor, bottom: nil, leading: header.leadingAnchor, trailing: cardView.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 0),size: .init(width: 0, height: 40))
        
        nextButton.anchor(top: nil, bottom: cardView.bottomAnchor, leading: cardView.leadingAnchor, trailing: cardView.trailingAnchor,padding: .init(top: 0, left: 12, bottom: 12, right: 12),size: .init(width: 0, height: 30))
        
        cardView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,size: .init(width: 0, height: 200))
        
        worksTableView.anchor(top: cardView.bottomAnchor,
                              bottom: view.bottomAnchor,
                              leading: view.leadingAnchor,
                              trailing: view.trailingAnchor)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "re", for: indexPath) as! jobVr
        cell.backgroundColor = .clear
        cell.modelic = categories[(indexPath.row)]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
        return 180
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
       }
    
    
    func firebase(){
        progresBar.show(in: self.view)
        
        // Firebase'den veriyi çekiyoruz
             firebaseService.fetchCategoryData { [weak self] categories in
                 guard let self = self else { return }
                 if let categories = categories {
                     self.categories = categories
                     // Veriyi işleyip ekranda göster
                     self.categories = categories
                     self.worksTableView.reloadData()
                     self.progresBar.dismiss()
                 } else {
                     print("Veri alınamadı.")
                 }
             }
        
        
       
        
       
        
            
            
        }
    
    
    
    
    
    












    
    
}
