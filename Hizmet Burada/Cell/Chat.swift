import Foundation
import UIKit

class Chat: UITableViewCell {
    static let identifier = "ChatCell"
    
    var modelic: MessageModel? {
        didSet {
            messageLabel.text = modelic?.text
            timestampLabel.text = "12:30"
        }
    }

    private let bubbleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont(name: "Avenir", size: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var timestampLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 8)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var bubbleLeadingConstraint: NSLayoutConstraint!
    private var bubbleTrailingConstraint: NSLayoutConstraint!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(bubbleView)
        bubbleView.addSubview(messageLabel)
        bubbleView.addSubview(timestampLabel)
        
        bubbleLeadingConstraint = bubbleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        bubbleTrailingConstraint = bubbleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        
        NSLayoutConstraint.activate([
            bubbleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            bubbleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            bubbleView.widthAnchor.constraint(lessThanOrEqualToConstant: UIScreen.main.bounds.width * 0.75),
            bubbleView.widthAnchor.constraint(greaterThanOrEqualToConstant: UIScreen.main.bounds.width / 5),
            messageLabel.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: 6),
            messageLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 6),
            messageLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -6),
            timestampLabel.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 4),
            timestampLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -6),
            timestampLabel.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -6)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        messageLabel.text = nil
        timestampLabel.text = nil
    }
    
    func configure(sentByCurrentUser: Bool) {
        if sentByCurrentUser {
            bubbleView.backgroundColor = UIColor.systemBlue
            messageLabel.textColor = .white
            timestampLabel.textColor = UIColor(white: 0.8, alpha: 1)
            bubbleLeadingConstraint.isActive = false
            bubbleTrailingConstraint.isActive = true
        } else {
            bubbleView.backgroundColor = UIColor(white: 0.9, alpha: 1)
            messageLabel.textColor = .black
            timestampLabel.textColor = .gray
            bubbleLeadingConstraint.isActive = true
            bubbleTrailingConstraint.isActive = false
        }
    }
}
