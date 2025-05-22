
import UIKit
import JGProgressHUD
import SideMenu



class DetailWorkPage: UIViewController , UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
   
    let firestoreManager = FirestoreManager()
    var modelDetail : Task? {
            didSet {
                infoText.text = modelDetail?.task
                let imagePath = "hizmetImage/\(modelDetail?.imageUrl ?? "repair").jpg"
                firestoreManager.downloadImage(from: imagePath) { image in
                    if let image = image {
                        self.workImage.image = image
                        self.progresBar.dismiss()
                    } else {
                        // Görsel indirme başarısız oldu
                    }
                }
            }
        }
    
    lazy var progresBar:JGProgressHUD = {
        let progresBar = JGProgressHUD(style: .light)
        return  progresBar
        
    }()
    
    lazy var stackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .clear
        stackView.spacing = 8
        return stackView
    }()
    
    
    lazy var workImage: UIImageView = {
       let workImage = UIImageView()
        workImage.contentMode = .scaleAspectFill
        workImage.clipsToBounds = true
        workImage.backgroundColor = .clear
        return workImage
    }()
    
    lazy var infoText:UITextView = {
        let infoText = UITextView()
        infoText.textColor = .white
        infoText.backgroundColor = UIColor.clear
        infoText.font = UIFont(name: "Avenir", size: 18)
        infoText.isEditable = false
        return infoText
    }()
    
    lazy var text : UITextView = {
        let text = UITextView()
        let imageView = UIImageView(frame: CGRect(x: 0, y: 5, width: 20, height: 20))
        imageView.image = UIImage(systemName:  "person.fill")
        imageView.tintColor = UIColor(hex: "40A6F8")
        text.textColor = .black
        text.backgroundColor = .clear
        text.font = UIFont(name: "Avenir", size: 11)
        text.isScrollEnabled = false
        text.isEditable = false
        text.text = "        \(String(modelDetail!.personnelCount)) Profesyonel"
        text.textAlignment = .justified
        text.addSubview(imageView)
        return text
    }()
    
    lazy var text2 : UITextView = {
        let text2 = UITextView()
        let icon2 = UIImageView(frame: CGRect(x: 0, y: 5, width: 20, height: 20))
        icon2.image = UIImage(systemName:  "star.fill")
        icon2.tintColor = UIColor(hex: "40A6F8")
        text2.textColor = .black
        text2.backgroundColor = .clear
        text2.isScrollEnabled = false
        text2.font = UIFont(name: "Avenir", size: 11)
        text2.isEditable = false
        let text = "        \(star()) ortalama puan (\(Int(modelDetail?.comments.count ?? 0)) onaylı yorum)"
        text2.text = text
        text2.textAlignment = .justified
        text2.addSubview(icon2)
      
        return text2
    }()
    lazy var separatorLine:UIView = {
        
        // Çizgi oluşturma
        let separatorLine = UIView()
        separatorLine.backgroundColor = .lightGray // Çizginin rengini ayarlayın
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        return separatorLine
    }()
    
    lazy var text3 : UITextView = {
        let text3 = UITextView()
        let icon3 = UIImageView(frame: CGRect(x: 0, y:5, width: 20, height: 20))
        icon3.image = UIImage(systemName:  "checkmark")
        icon3.tintColor = UIColor(hex: "40A6F8")
        
        text3.textColor = .black
        text3.backgroundColor = .clear
        text3.isScrollEnabled = false
        text3.font =  UIFont(name: "Avenir", size: 11)
        text3.isEditable = false
        text3.text = "       Yılda 3.100 kişi Hizmet Burada 'ya güveniyor"
        text3.textAlignment = .justified
        text3.addSubview(icon3)
        return text3
    }()
    
    lazy var text4 : UITextView = {
        let text4 = UITextView()
        let icon4 = UIImageView(frame: CGRect(x: 0, y: 5, width: 20, height: 20))
        icon4.image = UIImage(systemName:  "checkerboard.shield")
        icon4.tintColor = UIColor(hex: "40A6F8")
        text4.textColor = .black
        text4.font =  UIFont(name: "Avenir", size: 11)
        text4.isEditable = false
        text4.backgroundColor = .clear
        text4.text = "       Hizmet Burada Garantisi kapsamındadır"
        text4.textAlignment = .justified
        text4.addSubview(icon4)
        return text4
    }()
    
    lazy var commentText : UITextView = {
        let commentText = UITextView()
        commentText.textColor = .black
        commentText.font =  UIFont(name: "Avenir", size: 13)
        commentText.isEditable = false
        commentText.backgroundColor = .clear
        commentText.text = "Müşteri Yorumları"
        commentText.textAlignment = .justified
        return commentText
    }()
    
    lazy var collectionView:UICollectionView = {
            let layout = UICollectionViewFlowLayout()

            layout.scrollDirection = .horizontal
            let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
            cv.translatesAutoresizingMaskIntoConstraints = false
            cv.showsHorizontalScrollIndicator = false
            cv.register(Comment.self, forCellWithReuseIdentifier: "cell")
        cv.backgroundColor = .clear
            return cv
        }()
    
  
    

    
    lazy var createButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitleShadowColor(.white, for: .focused)
        button.setTitle("Rezervasyon Yap", for: .normal)
        button.setTitleColor(UIColor(hex: "E3F2FD"), for: .normal)
        button.backgroundColor = UIColor(hex: "#40A6F8")
        button.titleLabel?.font = UIFont(name: "Avenir", size: 14)
        button.setTitleColor(.white, for: .highlighted)
  
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
        return button
    }()
    

    
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
        collectionView.delegate = self
        collectionView.dataSource = self
        navigationController?.isNavigationBarHidden = false
        view.backgroundColor = .backgroundColorWhite
        progresBar.show(in: self.view)
        view.addSubview(workImage)
        workImage.addSubview(infoText)
        view.addSubview(stackView)
        view.addSubview(commentText)
        stackView.addArrangedSubview(text)
        stackView.addArrangedSubview(text2)
        stackView.addArrangedSubview(text3)
        stackView.addArrangedSubview(text4)
        view.addSubview(collectionView)
        view.addSubview(createButton)
        desing()
        
      
        
    }
    

    
    func star() -> Double {
        // Eğer yorumlar mevcutsa
        if let comments = modelDetail?.comments {
            var starRatings: [Int] = []
            
            // Yorumları döngüye al
            for comment in comments {
                starRatings.append(comment.star)
            }

            // Yıldız puanlarını topla
            let totalStars = starRatings.reduce(0, +)
            
            // Ortalama hesapla
            let averageStars = starRatings.isEmpty ? 0 : Double(totalStars) / Double(starRatings.count)
            
            return averageStars
        } else {
            // Yorumlar mevcut değilse
            print("Yorumlar mevcut değil.")
            return 0 // Yorum yoksa 0 döndür
        }
    }

    
    func desing (){
        
      
  
        
        workImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, 
                         bottom: nil,
                         leading: view.leadingAnchor,
                         trailing: view.trailingAnchor,
                         size: .init(width: 0, height: view.frame.height/4))
        
        infoText.anchor(top: nil, 
                        bottom: workImage.bottomAnchor,
                        leading: workImage.leadingAnchor,
                        trailing: workImage.trailingAnchor,
                        padding: .init(top: 0, left: 10, bottom:10, right: 0),
                        size: .init(width: 0, height: 35))
        
        stackView.anchor(top: workImage.bottomAnchor, 
                         bottom: nil, leading: view.leadingAnchor,
                         trailing: view.trailingAnchor,
                         padding: .init(top: 10, left: 10, bottom: 0, right: 10),
                         size: .init(width: 0, height: view.frame.height/6)
        )
        
        commentText.anchor(top: stackView.bottomAnchor,
                           bottom: nil,
                           leading: stackView.leadingAnchor,
                           trailing: stackView.trailingAnchor,
                           padding: .init(top: 6, left: 0, bottom: 0, right: 0),
                           size: .init(width: 0, height: 30))
        
        
        collectionView.anchor(top:commentText.bottomAnchor,
                              bottom: createButton.topAnchor,
                              leading: stackView.leadingAnchor,
                              trailing: stackView.trailingAnchor,
                              padding: .init(top: 10, left: 10, bottom:10, right: 10))
        
        
        createButton.anchor(top:nil,
                            bottom: view.safeAreaLayoutGuide.bottomAnchor,
                            leading: view.leadingAnchor,
                            trailing: view.trailingAnchor,
                            padding: .init(top: 0, left: 20, bottom: 30, right: 20),
                            size: .init(width: 0, height: 36))
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width/2, height: collectionView.frame.width/2)
        }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          
           print("Tıklanan öğe indeksiiii: \(indexPath.item)")
        
       }
    
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return  8
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Comment
            cell.modelic = modelDetail?.comments.first
            return cell
        }
    
    @objc func buttonClicked() {
            print("Button Clicked!")
        Jobİnformation.shared.jobDetail = infoText.text
        var vc = ResarvationPage()
        vc.modelDetail = modelDetail
        navigationController?.pushViewController(vc, animated: true)
    }
}
