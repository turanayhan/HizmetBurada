import Foundation
import UIKit

class Day: UICollectionViewCell {
    
    let dayNumberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold) // Gün numarası için daha büyük bir yazı tipi
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dayNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 10) // Gün adı için daha küçük bir yazı tipi
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let monthLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium) // Ay adı için daha küçük bir yazı tipi
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            configure(isSelected: isSelected) // Seçim durumuna göre güncelle
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.frame = contentView.bounds
  
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.addSubview(dayNumberLabel)
        contentView.addSubview(dayNameLabel)
        contentView.addSubview(monthLabel)
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.white.cgColor
        
        

        dayNumberLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        dayNumberLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4).isActive = true
        
        monthLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        monthLabel.topAnchor.constraint(equalTo: dayNumberLabel.bottomAnchor, constant: 2).isActive = true
        
        dayNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        dayNameLabel.topAnchor.constraint(equalTo: monthLabel.bottomAnchor, constant: 2).isActive = true
        dayNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6).isActive = true
    }
    
    
    
    func configure(isSelected: Bool) {
        contentView.backgroundColor = isSelected ? UIColor(hex: "40A6F8") : .white
    }
    
    // Ay adını ayarla
    func setMonth(month: String) {
        monthLabel.text = month
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
