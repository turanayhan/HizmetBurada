//
//  TableItem2.swift
//  Hizmet Burada
//
//  Created by turan on 9.11.2023.
//
import UIKit
import JGProgressHUD

class JobHz: UICollectionViewCell {
    
    let firestoreManager = FirestoreManager()
    
    var modelic : Task? {
           didSet {
               
               workText.text = modelic?.task
               let imagePath = "hizmetImage/\(modelic?.imageUrl ?? "repair").jpg"
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
    
    lazy var workImage: UIImageView = {
       let workImage = UIImageView()
        workImage.contentMode = .scaleAspectFill
        workImage.clipsToBounds = true
        workImage.layer.cornerRadius = 12
        return workImage
    }()
    
    lazy var workText:UITextView = {
        
        let workText = UITextView()
        workText.text = "Baca temizliği"
        workText.textColor = .black
        workText.backgroundColor = .clear
        workText.isEditable = false
        workText.font = UIFont(name: "Avenir", size: 10)
        
        return workText
    }()
    
    override init(frame: CGRect) {
     
        super.init(frame: .zero)
        progresBar.show(in: self.contentView)
        contentView.addSubview(workImage)
        contentView.addSubview(workText)
        contentView.backgroundColor = .clear
        desing()
        setupCell()
  
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func desing(){
        
        workImage.anchor(top: contentView.topAnchor,
                         bottom: workText.topAnchor,
                         leading: contentView.leadingAnchor,
                         trailing: contentView.trailingAnchor)
        
        workText.anchor(top: nil, 
                        bottom: contentView.bottomAnchor,
                        leading: contentView.leadingAnchor,
                        trailing: contentView.trailingAnchor,
                        size: .init(width: 0, height: 40))
        
        
    }
    
    
    func setupCell() {
          // Hücre ayarlarını yap

          let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
          addGestureRecognizer(tapGesture)
      }
    
    @objc func handleTap() {
        

        
        
           // Tıklandığında başka bir sayfaya geçiş yap
           if let viewController = findViewController() {
              let sayfa = DetailWorkPage()
               sayfa.modelDetail = modelic
               viewController.navigationController?.setNavigationBarHidden(true, animated: false)
               viewController.navigationController?.pushViewController(sayfa, animated: true)
           }
       }
    
    
    private func findViewController() -> UIViewController? {
           var responder: UIResponder? = self
           while let currentResponder = responder {
               if let viewController = currentResponder as? UIViewController {
                   return viewController
               }
               responder = currentResponder.next
           }
           return nil
       }
    
    
}

