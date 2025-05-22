//
//  BusinessOpportunity.swift
//  Hizmet Burada
//
//  Created by turan on 14.10.2024.
//

import UIKit

protocol CustomCellDelegate: AnyObject {
    func didTapButton(in cell: WorkOp)
}



class WorkOp: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    weak var delegate: CustomCellDelegate?
    
    var modelDetail: JobModel? {
        didSet {
            jobName.text = modelDetail?.nameSurname
            jobDetail.text = modelDetail?.detail
            date.text = modelDetail?.announcementDate
            numberOffer.text =  "\(modelDetail?.bids?.count ?? 0) teklif aldı"
            items = modelDetail?.information.map { "\($0.value)" } ?? []
            if modelDetail?.status == true {
                nextButton.setTitle("Teklif verdin detaylara bak", for: .normal)
                nextButton.backgroundColor = UIColor(hex: "E3F2FD")
                nextButton.setTitleColor(UIColor(hex: "40A6F8"), for: .normal)
            }
            else {
                nextButton.backgroundColor = UIColor(hex: "#40A6F8")
                nextButton.setTitleColor(UIColor(hex: "E3F2FD"), for: .normal)
                if let bids = modelDetail?.bids, !bids.isEmpty {
                    nextButton.setTitle("Teklif Ver", for: .normal)
                    
                  
                } else {
                    nextButton.setTitle("İlk teklif veren sen ol", for: .normal)
                }
                
              
                
            }
            
            
            collectionView.reloadData()
        }
    }
    
    
    
    
    
    
    
    

    lazy var separatorLine: UIView = {
        let separatorLine = UIView()
        separatorLine.backgroundColor = .lightGray
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        return separatorLine
    }()
    var items = ["50", "hava", "Boyama", "Montaj", "Bakım", "Tamir"]

    
    let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 4
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        view.layer.shadowOpacity = 0.1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let date: UILabel = {
        let date = UILabel()
        date.textColor = .darkGray
        date.textAlignment = .right

        date.font = UIFont(name: "Avenir", size: 9)
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()
    
    var jobName: UILabel = {
        let jobName = UILabel()
        jobName.textAlignment = .left
        jobName.text = "Turan Ayhan"
        jobName.font = UIFont(name: "Avenir", size: 10)
        jobName.translatesAutoresizingMaskIntoConstraints = false
        return jobName
    }()
    
    lazy var numberImage: UIImageView = {
        let profileImage = UIImageView()
        profileImage.image = UIImage(systemName: "envelope.open")
        profileImage.tintColor = UIColor.lightGray.withAlphaComponent(0.2)
        profileImage.contentMode = .scaleAspectFill
        profileImage.clipsToBounds = true
        return profileImage
    }()
    
    let jobDetail: UILabel = {
        let jobStatus = UILabel()
        jobStatus.font = UIFont(name: "Avenir", size: 10)
        jobStatus.numberOfLines = 0
        jobStatus.textAlignment = .left
        jobStatus.textColor = .black
        jobStatus.text = "İnşaat Sonrası Temizlik - Yeşilyurt - 15 Ekim"
        return jobStatus
    }()
    
    let userInfo: UILabel = {
        let jobStatus = UILabel()
        jobStatus.font = UIFont(name: "Avenir", size: 9)
        jobStatus.numberOfLines = 0
        jobStatus.textAlignment = .left
        jobStatus.textColor = .darkGray
        jobStatus.text = "Doğru fiyat vermek için evi gösterebilirim veya fotoğraf atabilirim"
        return jobStatus
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Teklif Ver", for: .normal)
        button.layer.cornerRadius = 4
        button.titleLabel?.font = UIFont(name: "Avenir", size: 12)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
           return button
       }()
    
    // Horizontal collection view ekleme
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: 100, height: 100)  // Hücre boyutu

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    let numberOffer: UILabel = {
        let jobStatus = UILabel()
        jobStatus.font = UIFont(name: "Avenir", size: 9)
        jobStatus.numberOfLines = 0
        jobStatus.textAlignment = .left
        jobStatus.textColor = .darkGray
       
        return jobStatus
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(cardView)
        cardView.addSubview(date)
        cardView.addSubview(jobName)
        cardView.addSubview(jobDetail)
        cardView.addSubview(separatorLine)
        cardView.addSubview(numberImage)
        cardView.addSubview(nextButton)
        cardView.addSubview(numberOffer)
        cardView.addSubview(collectionView)
        cardView.addSubview(userInfo)// Collection view ekleme
        
        desing()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func desing() {
        cardView.anchor(top: contentView.topAnchor, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16))
        
        jobName.anchor(top: cardView.topAnchor, bottom: nil, leading: cardView.leadingAnchor, trailing: nil, padding: .init(top: 12, left: 12, bottom: 0, right: 0))
        
        date.anchor(top: cardView.topAnchor, bottom: nil, leading: cardView.leadingAnchor, trailing: cardView.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 12))
        
        jobDetail.anchor(top: jobName.bottomAnchor, bottom: nil, leading: cardView.leadingAnchor, trailing: cardView.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12))
        
        
        userInfo.anchor(top: jobDetail.bottomAnchor, bottom: nil, leading: cardView.leadingAnchor, trailing: cardView.trailingAnchor,padding: .init(top: 10, left: 12, bottom: 0, right: 0))
        
        // CollectionView constraint'leri
        collectionView.anchor(top: userInfo.bottomAnchor, bottom: nil, leading: cardView.leadingAnchor, trailing: cardView.trailingAnchor, padding: .init(top: 10, left: 12, bottom: 10, right: 12), size: .init(width: 0, height: 30))
        
        numberImage.anchor(top: numberOffer.topAnchor, bottom: numberOffer.bottomAnchor, leading: nil, trailing: numberOffer.leadingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 3),size: .init(width: 12, height: 12))
        
        numberOffer.anchor(top: date.bottomAnchor, bottom: nil, leading: nil, trailing: date.trailingAnchor,padding: .init(top: 4, left: 0, bottom: 0, right: 0))
        
        nextButton.anchor(top: nil,
                          bottom: cardView.bottomAnchor,
                          leading: cardView.leadingAnchor,
                          trailing: cardView.trailingAnchor,
                          padding: .init(top: 0,
                                         left: 12,
                                         bottom: 8,
                                         right: 12),
                          size: .init(width: 0, height: 26)
        )
        
  
    
    }
    
    @objc private func nextButtonTapped() {
        delegate?.didTapButton(in: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count // Dizi boyutu kadar hücre gösterilecek
    }


  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)

 // Hücre rengi

      
        cell.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.2).cgColor
        cell.layer.borderWidth = 1.0
        cell.layer.cornerRadius = 4.0
        let label = UILabel(frame: cell.bounds)
        label.text = items[indexPath.item]  // Dizeden metin al
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir", size: 9)
        label.textColor = .black
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        cell.contentView.addSubview(label)

        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel()
        label.text = items[indexPath.item]
        label.font = UIFont.systemFont(ofSize: 12)
        
        // Metin genişliğini hesaplama
        let size = label.intrinsicContentSize
        let padding: CGFloat = 20 // Sağ ve sol boşluklar için padding
        let cellWidth = size.width + padding
        
        return CGSize(width: cellWidth, height: 20)
    }
    
}
