//
//  JobsDetailPage.swift
//  Hizmet Burada
//
//  Created by turan on 7.01.2024.
//

import UIKit
import FirebaseDatabaseInternal
import JGProgressHUD

class WorkDetail: UIViewController ,UITextViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource , OfferCellDelegate{

    

    var modelic : JobModel? {
           didSet {
               
               jobDetail.text = modelic?.detail
               let bids = modelic?.bids
               
               if let bids = bids, bids.isEmpty {
                   logo.isHidden = false
                   offerText.isHidden = false
                   collectionView.isHidden = true
                   
                 
                
               } else {
                   logo.isHidden = true
                   offerText.isHidden = true
                   collectionView.isHidden = false
            
               }
              
                         
               
               
               if let information = modelic?.information {
                   var index = 0
                   for (key, value) in information {
                       // Döngü içindeki her çifti ayrı etiketlere ata
                       switch index {
                       case 0:
                           answer1.text = key + " ?"
                           // Eğer değeri de kullanmak istiyorsanız, aynı şekilde answer2.text = value şeklinde ata
                           question1.text = value
                       case 1:
                           answer2.text = key + " ?"
                           // Eğer değeri de kullanmak istiyorsanız, aynı şekilde answer4.text = value şeklinde ata
                           question2.text = value
                           
                       case 2:
                           answer3.text = key + " ?"
                           // Eğer değeri de kullanmak istiyorsanız, aynı şekilde answer4.text = value şeklinde ata
                           question3.text = value
                           
                           
                       case 3:
                           answer4.text = key + " ?"
                           // Eğer değeri de kullanmak istiyorsanız, aynı şekilde answer4.text = value şeklinde ata
                           question4.text = value
                       default:
                           break
                       }
                       index += 1
                   }
               }
              
               }
        
           }
       
    
    
    lazy var container: UIView = {
           let container = UIView()
           return container
       }()
    
    lazy var progresBar: JGProgressHUD = {
        let progresBar = JGProgressHUD(style: .light)
        return progresBar
    }()
    
    
    lazy var jobDetail:UILabel = {
        let infoText = UILabel()
        infoText.text = "Boş Ev Temizliği"
        infoText.textColor = .black
        infoText.textAlignment = .left
        infoText.backgroundColor = .clear
        infoText.font = UIFont(name: "Avenir-Heavy", size: 10)
       
        
        return infoText
    }()
    
    
    lazy var textCalender : UITextView = {
        let text = UITextView()
        let imageView = UIImageView(frame: CGRect(x: 0, y: 7, width: 16, height: 16))
        imageView.image = UIImage(systemName:  "calendar")
        imageView.tintColor = UIColor(hex: "#40A6F8")
        text.textColor = .black
        text.font = UIFont(name: "Avenir", size: 10)
        text.isScrollEnabled = false
        text.backgroundColor = .clear
        text.isEditable = false
        text.text = "     Pazartesi , 15 Ocak - 09:00"
        text.textAlignment = .justified
        text.addSubview(imageView)
        return text
    }()
    lazy var textLocation : UITextView = {
        let text = UITextView()
        let imageView = UIImageView(frame: CGRect(x: 0, y: 7, width: 16, height: 16))

        imageView.image = UIImage(systemName:  "location.fill")
        imageView.tintColor = UIColor(hex: "#40A6F8")
        text.textColor = .black
        text.font = UIFont(name: "Avenir", size: 10)
        text.isScrollEnabled = false
        text.isEditable = false
        text.backgroundColor = .clear
        text.text = "     Şifa Mah, Battalgazi, Malatya"
        text.textAlignment = .justified
        text.addSubview(imageView)
        return text
    }()
    lazy var textPhone : UITextView = {
        let text = UITextView()
        let imageView = UIImageView(frame: CGRect(x: 0, y: 7, width: 16, height: 16))
        imageView.image = UIImage(systemName:  "phone.fill")
        imageView.tintColor = UIColor(hex: "#40A6F8")
        text.textColor = .black
        text.backgroundColor = .clear
        text.font = UIFont(name: "Avenir", size: 10)
        text.isScrollEnabled = false
        text.isEditable = false
        text.text = "     Müşteriyi Arayabilirsin"
        text.textAlignment = .justified
        text.addSubview(imageView)
        return text
    }()
    
    lazy var stackView1:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 6
        return stackView
    }()
    
    lazy var answer1:UILabel = {
        let answer1 = UILabel()
        answer1.text = "Evin Büyüklüğü nedir?"
        answer1.textColor = .black
        answer1.textAlignment = .left
        answer1.font = UIFont(name: "Avenir-Heavy", size: 10)
        return answer1
    }()
    
    lazy var logo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "job-6956074")
        logo.contentMode = .scaleAspectFit
        logo.backgroundColor = .clear
        return logo
    }()
    
    lazy var question1:UILabel = {
        let question1 = UILabel()
        question1.text = "  3+1"
        question1.textColor = .black
        question1.textAlignment = .left
        question1.font = UIFont(name: "Avenir", size: 10)
        return question1
    }()
    
    lazy var answer2:UILabel = {
        let answer2 = UILabel()
        answer2.text = "Ev Kaç Metrekare?"
        answer2.textColor = .black
        answer2.textAlignment = .left
        answer2.font = UIFont(name: "Avenir-Heavy", size: 10)
        return answer2
    }()
    
    lazy var question2:UILabel = {
        let question2 = UILabel()
        question2.text = "  120"
        question2.textColor = .black
        question2.textAlignment = .left
        question2.font = UIFont(name: "Avenir", size: 10)
        return question2
    }()
    
    lazy var answer3:UILabel = {
        let answer3 = UILabel()
        answer3.text = "Kaç Banyo?"
        answer3.textColor = .black
        answer3.textAlignment = .left
        answer3.font = UIFont(name: "Avenir-Heavy", size: 10)
        return answer3
    }()
    
    lazy var question3:UILabel = {
        let question3 = UILabel()
        question3.text = "  1"
        question3.textColor = .black
        question3.textAlignment = .left
        question3.font = UIFont(name: "Avenir", size: 10)
        return question3
    }()
    
    
    lazy var answer4:UILabel = {
        let answer3 = UILabel()
        answer3.text = "İhtiyacın detayları neler?"
        answer3.textColor = .black
        answer3.textAlignment = .left
        answer3.font = UIFont(name: "Avenir-Heavy", size: 10)
        return answer3
    }()
    
    lazy var question4:UILabel = {
        let question3 = UILabel()
        question3.text = "  3+1 Ev temizlenecek eşya yok boş"
        question3.textColor = .black
        question3.textAlignment = .left
        question3.font = UIFont(name: "Avenir", size: 10)
        return question3
    }()
    
    
    lazy var opportunityText:UILabel = {
        let infoText = UILabel()
        infoText.text = "Teklif Bilgileri"
        infoText.textColor = .black
        infoText.textAlignment = .left
        infoText.backgroundColor = .clear
        infoText.font = UIFont(name: "Avenir-Heavy", size: 12)
        return infoText
    }()
    
    lazy var container3 : UIView = {
        let container = UIView()
        container.backgroundColor = .clear
      return container
    }()
    
    lazy var container2 : UIView = {
        let container = UIView()
        container.backgroundColor = .clear
      return container
    }()
    
    lazy var collectionView:UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
            cv.translatesAutoresizingMaskIntoConstraints = false
            cv.showsHorizontalScrollIndicator = false
        cv.register(OfferCell.self, forCellWithReuseIdentifier: "cell")
        cv.backgroundColor = .clear
            return cv
        }()
    
    lazy var offerText:UILabel = {
        let offerText = UILabel()
        offerText.text = "Talebin için teklifler toplanıyor."
        offerText.textColor = .black
        offerText.textAlignment = .left
        offerText.font = UIFont(name: "Avenir", size: 10)
        return offerText
    }()

    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomBackButton(with: "Detaylar")
      
        collectionView.delegate = self
        collectionView.dataSource = self
        view.backgroundColor = UIColor(hex: "#F1FAFE")
        view.addSubview(container3)
      
  
        container3.addSubview(jobDetail)
        container3.addSubview(stackView1)
        container3.addSubview(container)
        stackView1.addArrangedSubview(textCalender)
        stackView1.addArrangedSubview(textLocation)
        stackView1.addArrangedSubview(textPhone)
        stackView1.addArrangedSubview(answer1)
        stackView1.addArrangedSubview(question1)
        stackView1.addArrangedSubview(answer2)
        stackView1.addArrangedSubview(question2)
        stackView1.addArrangedSubview(answer3)
        stackView1.addArrangedSubview(question3)
        stackView1.addArrangedSubview(answer4)
        stackView1.addArrangedSubview(question4)
        container.addSubview(container2)
        container2.addSubview(opportunityText)
        container2.addSubview(collectionView)
        container2.addSubview(logo)
        container2.addSubview(offerText)
       
        desing()
        
        
        
    }
    
 
    

    func desing(){
        
       
        container3.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 6, left: 20, bottom: 8, right: 12)
        )

    
        
        jobDetail.anchor(top: container3.topAnchor, bottom: nil, leading: container3.leadingAnchor, trailing: container3.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 0),size: .init(width: 0, height: 30))
        
        stackView1.anchor(top: jobDetail.bottomAnchor, bottom: nil, leading: jobDetail.leadingAnchor, trailing: jobDetail.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right:0))
      
        container.anchor(top: stackView1.bottomAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 6, left: 0, bottom: 0, right: 0))
     
        container2.anchor(top: container.topAnchor, bottom: container.bottomAnchor, leading: stackView1.leadingAnchor, trailing: view.trailingAnchor)
        
        opportunityText.anchor(top: stackView1.bottomAnchor, bottom: nil, leading: stackView1.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 16, left: 0, bottom: 0, right: 0),size: .init(width: 0, height: 30))
        
        collectionView.anchor(top:opportunityText.bottomAnchor,
                              bottom: view.safeAreaLayoutGuide.bottomAnchor,
                              leading: container3.leadingAnchor,
                              trailing: container3.trailingAnchor,
                              padding: .init(top: 0, left: 0, bottom: 10, right: 0),
                              size: .init(width: 0, height: 0 ))
        
        offerText.anchor(top: opportunityText.bottomAnchor, bottom: nil, leading: container3.leadingAnchor, trailing: container3.trailingAnchor)
        
        let logoSize = UIScreen.main.bounds.width*0.8

        logo.anchor(top:nil,
                    bottom: container3.bottomAnchor,
                              leading: nil,
                              trailing: nil,
                              padding: .init(top: 0, left: 10, bottom: 0, right: 0),
                    size: .init(width: logoSize, height: logoSize ))
        
        logo.centerXAnchor.constraint(equalTo: container3.centerXAnchor).isActive = true
    }
    
    
    @objc func loginClick(click :UIButton!){
        
      

        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width/2, height: collectionView.frame.height*0.9)
        }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          
           print("Tıklanan öğe indeksiiii: \(indexPath.item)")
        
       }
    
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return  modelic?.bids?.count ?? 0
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OfferCell
            cell.modelic = modelic?.bids?[indexPath.row]
            cell.delegate = self
       
            return cell
        }
    
    
    
    
    
    
    
    
    
    
    func addBid(to jobId: String, bid: BidModel) {
        let ref = Database.database().reference().child("Jobs").child(jobId).child(modelic?.jobId ?? "3122").child("bids").child(bid.id)
        let bidData: [String: Any] = [
            "providerId": bid.providerId,
            "providerName": bid.providerName,
            "price": bid.price,
            "message": bid.message,
            "bidDate": bid.bidDate,
        ]
        
        ref.setValue(bidData) { error, _ in
            if let error = error {
                print("Teklif eklenirken hata oluştu: \(error.localizedDescription)")
                self.progresBar.dismiss(afterDelay: 2.0)
            } else {
                print("Teklif başarıyla eklendi.")
                self.progresBar.dismiss(afterDelay: 2.0)
                self.navigationController?.popViewController(animated: true)
               
            }
        }
    }

    
  


    
    func didTapButton(in cell: OfferCell) {
        
        if let indexPath = collectionView.indexPath(for: cell) {
            let view = ChatPage()
    
            navigationController?.pushViewController(view, animated: true)
        }
        
    }
 
   

}
