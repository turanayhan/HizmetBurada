
import UIKit




class jobVr:UITableViewCell, UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    

    var modelic : Category? {
            didSet {
                header.text = modelic?.category
            }
        }

 

    lazy var header:UITextView = {
        
        let header = UITextView()
        header.textColor = .black
        header.backgroundColor = UIColor(hex: "#F1FAFE")
        header.isEditable = false
        header.backgroundColor = .clear
        header.font = UIFont(name: "Avenir-Medium", size: 12)
    
        
        return header
    }()
    
    lazy var collectionView:UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
          
        
            let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
            cv.translatesAutoresizingMaskIntoConstraints = false
            cv.showsHorizontalScrollIndicator = false
            cv.register(JobHz.self, forCellWithReuseIdentifier: "cell")
            cv.backgroundColor = .clear
            return cv
        }()

    
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            collectionView.delegate = self
            collectionView.dataSource = self
      
            desing()
            
            
            
          
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width/2.3, height: collectionView.frame.width/2.7)
        }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          
           print("Tıklanan öğe indeksi: \(indexPath.item)")
        
        
       
       }
    
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return modelic?.tasks.count ?? 0
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! JobHz
            cell.backgroundColor = .clear
            cell.modelic = modelic?.tasks[indexPath.row]
            return cell
        }
        
        required init?(coder aDecoder: NSCoder) {
            
            super.init(coder: aDecoder)
        }
    
    func desing(){
        
        
        contentView.addSubview(header)
        contentView.addSubview(collectionView)

        collectionView.anchor(top:header.bottomAnchor,
                              bottom: self.contentView.bottomAnchor,
                              leading: self.contentView.leadingAnchor,
                              trailing: self.contentView.trailingAnchor,
                              padding: .init(top: 10, left: 10, bottom: 0, right: 10))
        
        
        header.anchor(top: contentView.topAnchor,
                        bottom: nil,
                        leading: contentView.leadingAnchor,
                        trailing: contentView.trailingAnchor,
                        size: .init(width: 0, height: 26))
        
        
        
    }
}



