import UIKit

class SelectionPage: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let answers = ["Ev Temizliği", "Boyacı (Boya Badana ustası)", "Halı Yıkama Temizleme", "Ev Tadilat", "Fayans Döşeme", "Parke Laminat Döşeme", "Kombi Tamiri ", "Nakliye"]
    var selectedAnswers: [Bool] = Array(repeating: false, count: 10)
    var status : String?
    
    lazy var nameSurnameText:UITextView = {
        let infoText = UITextView()
        infoText.text = "Hangi Hizmeti Veriyorsun?"
        infoText.backgroundColor = .clear
        infoText.textColor = .black
        infoText.textAlignment = .center
        infoText.font = UIFont(name: "Helvetica-Bold", size: 16)
        infoText.isEditable = false
        return infoText
    }()
    
    lazy var nameSurnameText2:UITextView = {
        let infoText = UITextView()
        infoText.text = "Müşterilere uygun fırsatları görmek için sunduğun hizmetleri\nseçebilirsin."
        infoText.textColor = .black
        infoText.backgroundColor = .clear
        infoText.textAlignment = .center
        infoText.font = UIFont(name: "Avenir", size: 12)
        infoText.isEditable = false
        return infoText
    }()
    
    

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AnswerTableViewCell.self, forCellReuseIdentifier: "AnswerCell")
        tableView.tableFooterView = UIView() // Boş hücrelerin gösterilmemesi için
        return tableView
    }()
    
    lazy var registerBtn:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Devam", for: .normal)
        button.alpha = 0.5
        button.isEnabled = false
        button.setTitleColor(UIColor(hex: "E3F2FD"), for: .normal)
        button.backgroundColor = UIColor(hex: "#40A6F8")
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 2
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#F1FAFE")
       
        setupCustomBackButton(with: "")
        view.addSubview(tableView)
        view.addSubview(nameSurnameText)
        view.addSubview(nameSurnameText2)
        view.addSubview(registerBtn)
        setupConstraints()
    }
    
    
    


    func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        nameSurnameText.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 10, left: 0, bottom: 0, right: 0),size: .init(width: 0, height: 40))
        
        
        registerBtn.anchor(top: nil,
                           bottom: view.safeAreaLayoutGuide.bottomAnchor,
                           leading: view.leadingAnchor,
                           trailing: view.trailingAnchor,
                           padding: .init(top: 2, left: 20, bottom:30, right: 20))
        
        
        nameSurnameText2.anchor(top: nameSurnameText.bottomAnchor,
                                bottom: nil,
                                leading: view.leadingAnchor,
                                trailing: view.trailingAnchor,
                                padding: .init(top: 0, left: 0, bottom: 0,
                                               right: 0),size: .init(width: 0, height: 80))
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: nameSurnameText2.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: registerBtn.topAnchor,constant: 40)
        ])
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell", for: indexPath) as! AnswerTableViewCell
        cell.answerLabel.text = answers[indexPath.row]
        cell.answerSwitch.isOn = selectedAnswers[indexPath.row]
        cell.backgroundColor = .clear
        cell.delegate = self
        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

protocol AnswerTableViewCellDelegate: AnyObject {
    func switchValueChanged(forCell cell: AnswerTableViewCell)
}

class AnswerTableViewCell: UITableViewCell {

    weak var delegate: AnswerTableViewCellDelegate?

    lazy var answerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Avenir", size: 14)
        return label
    }()

    lazy var answerSwitch: UISwitch = {
        let answerSwitch = UISwitch()
        answerSwitch.onTintColor = UIColor(hex: "40A6F8")
        answerSwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        return answerSwitch
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(answerLabel)
        contentView.addSubview(answerSwitch)
        
        
        
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupConstraints() {
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        answerSwitch.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            answerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            answerLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            answerSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            answerSwitch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    @objc func switchValueChanged() {
        delegate?.switchValueChanged(forCell: self)
     
        ServiceProviderRegistration.rgİnformation.addInfo(value: answerLabel.text ?? "nul")
    }
}







extension SelectionPage: AnswerTableViewCellDelegate {
    func switchValueChanged(forCell cell: AnswerTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        selectedAnswers[indexPath.row].toggle()
        tableView.reloadRows(at: [indexPath], with: .none)
        
        // Butonun aktif olup olmayacağını kontrol et
        updateRegisterButtonState()
    }
    
    func updateRegisterButtonState() {
        // Eğer selectedAnswers dizisinde en az bir tane true varsa
        if selectedAnswers.contains(true) {
            registerBtn.isEnabled = true
            registerBtn.alpha = 1.0  // Butonu tam opak yap
        } else {
            registerBtn.isEnabled = false
            registerBtn.alpha = 0.5  // Butonu yarı saydam yap (pasif görünüm)
        }
    }

    @objc func nextButtonTapped(click : UIButton!) {
        let selectionn = ServiceProviderRegistration.rgİnformation.answerSelection
        if selectionn.isEmpty {
            print("Dizi boş")
        } else {
            print("Dizide veriler var")
            
            var view = ProviderName()
            
            navigationController?.pushViewController(view, animated: true)
        }
    }
}

    


    

