//
//  Reservation.swift
//  Hizmet Burada
//
//  Created by turan on 25.11.2023.
//

import UIKit
import Firebase


class ResarvationPage: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {

    private var currentIndex = 0
    var modelDetail: Task? {
        didSet {
            collectionView.reloadData()
        }
    }




  
    
    
    lazy var collectionView: UICollectionView = {
           let layout = UICollectionViewFlowLayout()
           layout.scrollDirection = .horizontal
           let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
           collectionView.translatesAutoresizingMaskIntoConstraints = false
           collectionView.delegate = self
           collectionView.dataSource = self
        collectionView.backgroundColor = .backgroundColorWhite
           collectionView.isPagingEnabled = false
           collectionView.isScrollEnabled = false
        collectionView.register(ResarvationHz.self, forCellWithReuseIdentifier: "CustomCell")
           return collectionView
       }()
    lazy var separatorLine:UIView = {
        
        // Çizgi oluşturma
        let separatorLine = UIView()
        separatorLine.backgroundColor = .lightGray // Çizginin rengini ayarlayın
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        return separatorLine
    }()
    
    lazy var princeText:UILabel = {
        
        // Çizgi oluşturma
        let princeText = UILabel()
        princeText.text = "Rezervasyon"
        princeText.textColor = .black
        princeText.textAlignment = .center

        return princeText
    }()
    
    let nextButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .btnBlue
        btn.layer.cornerRadius = 8
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.3
        btn.layer.shadowOffset = CGSize(width: 3, height: 3)
        btn.layer.shadowRadius = 5
        btn.layer.masksToBounds = false
      
        btn.isEnabled = true

        btn.setTitle("Devam", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 12)
        btn.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)

        // Ok ikonu
        let arrowImageView = UIImageView(image: UIImage(systemName: "arrow.right"))
        arrowImageView.tintColor = .white
        arrowImageView.contentMode = .scaleAspectFit
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false

        // Butona ekle
        btn.addSubview(arrowImageView)

        // Auto Layout ile hizalama
        NSLayoutConstraint.activate([
            arrowImageView.centerYAnchor.constraint(equalTo: btn.centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: btn.trailingAnchor, constant: -16), // Sağdan 16 birim içerde
            arrowImageView.widthAnchor.constraint(equalToConstant: 18),
            arrowImageView.heightAnchor.constraint(equalToConstant: 18)
        ])

        return btn
    }()
    
 
 
       override func viewDidLoad() {
           super.viewDidLoad()
           setupCustomBackButton(with: "Hizmet Burada")
           view.backgroundColor = .backgroundColorWhite
       
           desing()

          
    
                       
            }
    
    

    func desing(){
       
        view.backgroundColor = .white
        view.addSubview(collectionView)
        view.addSubview(nextButton)
        
        
       
     
        
        collectionView.anchor(top: view.topAnchor,
                              bottom: nextButton.topAnchor,
                              leading: view.leadingAnchor,
                              trailing: view.trailingAnchor,
                              padding: .init(top: 0, left: 0, bottom: 0, right: 0))
       
        nextButton.anchor(top: nil,
                          bottom: view.safeAreaLayoutGuide.bottomAnchor,
                          leading: view.leadingAnchor,
                          trailing: view.trailingAnchor,
                          padding: .init(top: 0, left: 30, bottom: 30, right: 30),
                          size: .init(width: 0, height: 36))
        
        
    }
    
    
    func deneme(){
        
        let soru1 : [String: Any] = [
            "soru": "Ev kaç metrekare ?",
            "cevap": ["120","130","200"],
           
        ]
        let soru2 : [String: Any] = [
            "soru": "Kaç oda var ?",
            "cevap": ["1","2","3"],
           
        ]
        let soru3 : [String: Any] = [
            "soru": "Ev kaç metrekare ?",
            "cevap": ["120","130","200"],
           
        ]
        
        let evtemizliği : [String: Any] = [
            "sorular": [soru1,soru2,soru3],
            "id": 0,
           
        ]
        
        let isler : [String: Any] = [
            "is adları": [evtemizliği],
           
        ]
        
        
        
        
    
        let ref = Database.database().reference()
        let yeniKullaniciRef = ref.child("isler")

        yeniKullaniciRef.setValue(isler)
        // Eklenen kullanıcının ID'sini almak
        
        
    }
    
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return modelDetail?.questions.count ?? 0 // 4 sayfa
       }

       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! ResarvationHz
           cell.model = modelDetail?.questions[indexPath.row]
          
           
           return cell
       }
    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           // Hücre boyutlarını belirleyin
         return CGSize(width: collectionView.frame.width, height: collectionView.frame.height-50)
       }
   
    @objc private func nextButtonTapped() {
        guard let questionCount = modelDetail?.questions.count, questionCount > 0 else {
            print("No questions available")
            return
        }

        // Şu anki hücreyi alın
        let currentCellIndexPath = IndexPath(item: currentIndex, section: 0)
        if let currentCell = collectionView.cellForItem(at: currentCellIndexPath) as? ResarvationHz {
            // Seçili checkbox'ların sayısını kontrol et
            if !currentCell.item.visibleCells.contains(where: { ($0 as? ResarvationVr)?.checkBox.isSelected == true }) {
                // Hiçbir checkbox seçilmediyse, kullanıcıya uyarı göster
                showAlert(message: "Lütfen en az bir seçeneği işaretleyin.")
                return
            }
        }
        currentIndex += 1

        // Eğer currentIndex son sorudan büyükse, geçiş yap
        if currentIndex >= questionCount {
            let vc = DatePage()
            vc.jobid = modelDetail!.id
            self.navigationController?.pushViewController(vc, animated: true)
            return
        }

        let indexPath = IndexPath(item: currentIndex, section: 0)

        print("Current Index: \(indexPath.row)")
        print("Total Questions: \(questionCount)")

        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

    private func showAlert(message: String) {
        let alertController = UIAlertController(title: "Uyarı", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))

        // Uyarıyı ekrana göster
        present(alertController, animated: true, completion: nil)
    }

   }



