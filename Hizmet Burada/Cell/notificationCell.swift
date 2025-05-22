import UIKit

// UITableViewCell taban sınıfını kullanarak notificationCell'i yeniden tanımlayalım
class notificationCell: UITableViewCell {
    
    var modelic:Notifications? {
        didSet {
            
        }
    }
    
    
    
    let cardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        view.layer.shadowOpacity = 0.1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 11)
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .left
        label.text = "Temizlik burdan geçer"
        label.backgroundColor = UIColor.clear
        return label
    }()
    
    lazy var date: UITextView = {
        let date = UITextView()
        date.isEditable = false
        date.isScrollEnabled = false
        date.backgroundColor = UIColor.clear
        date.textAlignment = .center
        date.text = "14/02/ 2024"
        date.font = UIFont(name: "Avenir", size: 8)
        return date
    }()
    
    lazy var commentText: UITextView = {
        let commentText = UITextView()
        commentText.isEditable = false
        commentText.isScrollEnabled = false
        commentText.textAlignment = .left
        commentText.textColor = .gray
        commentText.backgroundColor = UIColor.clear
        commentText.text = "Ev olsun ofis olsun araba olsun sen neyi temizlemek istiorsan aradığın yardım bu uygulamada."
        commentText.font = UIFont(name: "Avenir", size: 10)
        return commentText
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(cardView)
        contentView.backgroundColor = .clear
        cardView.backgroundColor = UIColor(hex: "E3F2FD")
        cardView.layer.borderWidth = 0.2
        cardView.layer.borderColor = UIColor.lightGray.cgColor
        cardView.layer.cornerRadius = 4
        cardView.addSubview(titleLabel)
        cardView.addSubview(date)
        cardView.addSubview(commentText)
        desing()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func desing() {
        
        cardView.anchor(top: contentView.topAnchor, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor,padding: .init(top: 9, left: 8, bottom: 0, right: 8))
        
        titleLabel.anchor(top: cardView.topAnchor,
                          bottom: nil,
                          leading: cardView.leadingAnchor,
                          trailing: cardView.trailingAnchor,
                          padding: .init(top: 4, left: 6, bottom: 0, right: 6),
                          size: .init(width: 0, height: 0))
        
        date.anchor(top: titleLabel.topAnchor,
                    bottom: titleLabel.bottomAnchor,
                    leading: nil,
                    trailing: cardView.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 6))
        
        commentText.anchor(top: titleLabel.bottomAnchor, bottom: nil, leading: titleLabel.leadingAnchor, trailing: cardView.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        

    }
}
