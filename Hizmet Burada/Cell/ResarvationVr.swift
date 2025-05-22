import UIKit

class ResarvationVr: UITableViewCell {
    
    // Örneğin, her hücrede gösterilecek metin
    var question: String? {
        didSet {
            questions = question ?? "bos"
            checkBox.isSelected = false
        }
    }
    var answer: String? {
        didSet {
            label.text = answer
            answers = answer ?? "bos"
        }
    }
    
    var questions = ""
    var answers = ""
 
    
    lazy var container: UIView = {
        let container = UIView()
        container.backgroundColor = UIColor(hex: "#F1FAFE") // Sarıya yakın pastel ton
        container.layer.cornerRadius = 12
        return container
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir", size: 12)
        return label
    }()
    
    let checkBox: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.tintColor = UIColor(hex: "#40A6F8")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        button.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .selected)
        button.addTarget(self, action: #selector(checkBoxTapped), for: .touchUpInside)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupTapGesture()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubview(container)

        container.addSubview(checkBox)
        container.addSubview(label)
        
        container.anchor(top: contentView.topAnchor,
                         bottom: contentView.bottomAnchor,
                         leading: contentView.leadingAnchor,
                         trailing: nil,
                         padding: .init(top: 6, left: 0, bottom: 0, right: 0))
        
        container.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        container.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        checkBox.anchor(top: nil,
                        bottom: nil,
                        leading: container.leadingAnchor,
                        trailing: nil,
                        padding: .init(top: 0, left: 4, bottom: 0, right: 0),
                        size: .init(width: 30, height: 30))
        
        checkBox.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        
        label.anchor(top: nil,
                     bottom: nil,
                     leading: checkBox.trailingAnchor,
                     trailing: container.trailingAnchor,
                     padding: .init(top: 0, left: 4, bottom: 0, right: 30))
        
        label.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
    }
     
    // Checkbox'a tıklama işlemi
    @objc func checkBoxTapped() {
        toggleCheckBox()
    }
    
    // Hücreye tıklama işlemi
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        container.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
        toggleCheckBox()
    }
    
    // Checkbox durumunu değiştiren fonksiyon
    private func toggleCheckBox() {
        checkBox.isSelected.toggle()
        
        let key = questions.replacingOccurrences(of: "?", with: "")
                           .replacingOccurrences(of: "+", with: "")
                           .replacingOccurrences(of: "/", with: "")
                           .replacingOccurrences(of: "-", with: "")
        Jobİnformation.shared.addInfo(key: key, value: answers)
    }
}
