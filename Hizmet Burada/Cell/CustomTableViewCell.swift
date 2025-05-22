import UIKit

class CustomTableViewCell: UITableViewCell {
    
    var modelDetail: ProfilItem? {
        didSet {
            updateUI()
        }
    }
    
    // Logo eklemek için UIImageView
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .black
        return imageView
    }()
    
    // Üstteki etiket
    lazy var topLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Alttaki etiket
    lazy var bottomLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 9)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // Stack view oluşturma
    lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topLabel, bottomLabel])
        stackView.axis = .vertical
        stackView.spacing = 4 // İki label arasındaki boşluk
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // UI elemanlarını hücreye ekleme
        contentView.addSubview(logoImageView)
        contentView.addSubview(topLabel)
        contentView.addSubview(bottomLabel)
        contentView.addSubview(labelStackView)
        desing()
  
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func desing(){
        
        logoImageView.anchor(top: nil, bottom: nil, leading: contentView.leadingAnchor, trailing: nil,padding: .init(top: 0, left: 12, bottom: 0, right: 0),size: .init(width: 24, height: 24))
        logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        labelStackView.anchor(top: nil, bottom: nil, leading: logoImageView.trailingAnchor, trailing: contentView.trailingAnchor,padding: .init(top: 0, left: 12, bottom: 0, right: 0))
        labelStackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        
    }
    
    // UI elemanlarını güncellemek için fonksiyon
    private func updateUI() {
        topLabel.text = modelDetail?.header
        bottomLabel.text = modelDetail?.description
        if let logoName = modelDetail?.logo {
            logoImageView.image = UIImage(systemName: logoName)
        }
    }
}
