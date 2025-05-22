import UIKit

class DatePage: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var jobid: Int = 0
    var selectedDay: String?
    var selectedHour: String?
    var days: [String] = []
    var hours: [String] = []
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(Day.self, forCellWithReuseIdentifier: "DayCell")
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    let hourCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(Hour.self, forCellWithReuseIdentifier: "HourCell")
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Devam", for: .normal)
        button.setTitleColor(UIColor(hex: "E3F2FD"), for: .normal)
        button.backgroundColor = .btnBlue
        button.layer.cornerRadius = 10
        button.layer.cornerRadius = 6
        button.titleLabel?.font = UIFont(name: "Avenir", size: 14)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
  

  
    
    lazy var infoText: UITextView = {
        let infoText = UITextView()
       
        infoText.font = UIFont(name: "Avenir", size: 14)
        infoText.isEditable = false
        infoText.textAlignment = .center
        infoText.backgroundColor = .clear
        infoText.text = "Ne zaman?"
        return infoText
    }()
    
    lazy var infoText2: UITextView = {
        let infoText2 = UITextView()
        
        infoText2.font = UIFont(name: "Avenir", size: 12)
        infoText2.isEditable = false
        infoText2.textAlignment = .center
        infoText2.backgroundColor = .clear
        infoText2.text = "Rezervasyonundan 24 saat öncesisine kadar değiştirebilirsiniz"
        return infoText2
    }()
    
    let leftArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.left") // Sol ok simgesi
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(hex: "40A6F8")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let rightArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")  // Sağ ok simgesi
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(hex: "40A6F8") 
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var separatorLine:UIView = {
        
        // Çizgi oluşturma
        let separatorLine = UIView()
        separatorLine.backgroundColor = .lightGray // Çizginin rengini ayarlayın
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        return separatorLine
    }()
    
  
    
    lazy var navigationTitle:UITextView = {
        let titleLabel = UITextView()
        titleLabel.text = "Rezervasyon"
        titleLabel.textColor = .black // Başlık rengi
        titleLabel.font = UIFont(name: "Avenier", size: 14)
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = UIColor(hex: "#F1FAFE")
        return titleLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupCustomBackButton(with:"Hizmet Burada")
        view.backgroundColor = .backgroundColorWhite
      
        collectionView.delegate = self
        collectionView.dataSource = self
        hourCollectionView.delegate = self
        hourCollectionView.dataSource = self
        generateDays()
        generateHours()
        design()
        
    }
    

    
    func generateDays() {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d EEEE"
        dateFormatter.locale = Locale(identifier: "tr_TR")
        
        let today = Date() // Bugünkü tarihi al
        let currentMonth = calendar.component(.month, from: today)
        let currentYear = calendar.component(.year, from: today)
        
        // Mevcut ayın ilk gününü belirle
        let startDate = calendar.date(from: DateComponents(year: currentYear, month: currentMonth, day: 1))!
        
        // Mevcut ayın son gününü belirle
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        days.removeAll() // Önceden eklenmiş günleri temizle

        for day in range {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: startDate) {
                let dayString = dateFormatter.string(from: date)
                days.append(dayString)
            }
        }

        // Seçim için tarihi güncelleyin
        let currentDayIndex = calendar.component(.day, from: today) - 1 // Bugünün gününü index olarak al
        if currentDayIndex < days.count {
            selectedDay = days[currentDayIndex] // Bugünü seçili gün olarak ayarla
        }
    }

    
    func generateHours() {
        for hour in 8...21 { // 08:00 - 21:00 aralığı
            hours.append(String(format: "%02d:00", hour))
        }
    }
    

    func design() {

        view.addSubview(infoText)
        view.addSubview(infoText2)
        view.addSubview(collectionView)
        view.addSubview(hourCollectionView)
        view.addSubview(nextButton)
        view.addSubview(leftArrowImageView) // Sol ok simgesi ekle
        view.addSubview(rightArrowImageView)
        infoText.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                        bottom: nil,
                        leading: view.leadingAnchor,
                        trailing: view.trailingAnchor,
                        padding: .init(top: 20, left: 20, bottom: 0, right: 20),
                        size: .init(width: 0, height: 30))
        
        
        infoText2.anchor(top: infoText.bottomAnchor,
                        bottom: nil,
                        leading: view.leadingAnchor,
                        trailing: view.trailingAnchor,
                        padding: .init(top: 15, left: 10, bottom: 0, right: 10),
                        size: .init(width: 0, height: 40))
        
        collectionView.anchor(top: infoText2.bottomAnchor,
                              bottom: hourCollectionView.topAnchor,
                              leading: infoText2.leadingAnchor,
                              trailing: infoText2.trailingAnchor,
                              padding: .init(top: 15, left: 20, bottom: 0, right: 20),
                              size: .init(width: 0, height: 80))
        

        
        hourCollectionView.anchor(top: collectionView.bottomAnchor,
                                  bottom: nil,
                                  leading: infoText2.leadingAnchor,
                                  trailing: infoText2.trailingAnchor,
                                  padding: .init(top: 20, left: 20, bottom: 0, right: 20),
                                  size: .init(width: 0, height: 80))
        
        nextButton.anchor(top: nil,
                          bottom: view.safeAreaLayoutGuide.bottomAnchor,
                          leading: view.leadingAnchor,
                          trailing: view.trailingAnchor,
                          padding: .init(top: 0, left: 20, bottom: 30, right: 20),
                          size: .init(width: 0, height: 36))
        
        NSLayoutConstraint.activate([
            leftArrowImageView.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor),
            leftArrowImageView.trailingAnchor.constraint(equalTo: collectionView.leadingAnchor, constant: -5),
            leftArrowImageView.widthAnchor.constraint(equalToConstant: 25), // Genişlik
            leftArrowImageView.heightAnchor.constraint(equalToConstant: 25), // Yükseklik

            rightArrowImageView.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor),
            rightArrowImageView.leadingAnchor.constraint(equalTo: collectionView.trailingAnchor, constant: 5),
            rightArrowImageView.widthAnchor.constraint(equalToConstant: 25), // Genişlik
            rightArrowImageView.heightAnchor.constraint(equalToConstant: 25) // Yükseklik
        ])
   
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return days.count
        } else {
            return hours.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath) as! Day
            cell.backgroundColor = .clear
            
            // Gün numarasını ve adını al
            let calendar = Calendar.current
            let date = calendar.date(byAdding: .day, value: indexPath.item, to: Date())!
            
            // Ay adını ve günü al
            let monthFormatter = DateFormatter()
            monthFormatter.locale = Locale(identifier: "en_US") // İngilizce ay adı
            monthFormatter.dateFormat = "MMMM"
            let monthNameEnglish = monthFormatter.string(from: date).capitalized
            
            monthFormatter.locale = Locale(identifier: "tr_TR") // Türkçe ay adı
            let monthNameTurkish = monthFormatter.string(from: date).capitalized
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "tr_TR")
            
            dateFormatter.dateFormat = "d"
            let dayNumber = dateFormatter.string(from: date)
            
            dateFormatter.dateFormat = "EEEE"
            let dayName = dateFormatter.string(from: date)
            
            cell.dayNumberLabel.text = dayNumber
            cell.dayNameLabel.text = dayName.capitalized
            cell.setMonth(month: monthNameTurkish) // Türkçe ve İngilizce ay adını ayarla

            // Seçili olup olmadığını kontrol et ve rengi ayarla
            cell.configure(isSelected: selectedDay == days[indexPath.item])

            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourCell", for: indexPath) as! Hour
            
            cell.hourLabel.text = hours[indexPath.item]
            cell.configure(isSelected: selectedHour == hours[indexPath.item])
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView {
            selectedDay = days[indexPath.item]
            
            // Seçim yapıldığında tüm hücrelerin arka plan rengini güncelle
            for i in 0..<days.count {
                let cell = collectionView.cellForItem(at: IndexPath(item: i, section: 0)) as? Day
                cell?.configure(isSelected: i == indexPath.item) // Seçilen gün için özel tasarım
            }
            
            collectionView.reloadData()
        } else {
            // Saat seçimi yapılırken tarih seçimini kontrol et
            if selectedDay == nil {
                let alert = UIAlertController(title: "Hata", message: "Lütfen önce bir gün seçin.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            } else {
                // Seçilen saati kaydet
                selectedHour = hours[indexPath.item]
                for i in 0..<hours.count {
                    let cell = collectionView.cellForItem(at: IndexPath(item: i, section: 1)) as? Hour
                    cell?.configure(isSelected: i == indexPath.item)
                }
                hourCollectionView.reloadData()
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 65, height: 55)
    }
    @objc private func nextButtonTapped() {
        guard let selectedDay = selectedDay, let selectedHour = selectedHour else {
            let alert = UIAlertController(title: "Hata", message: "Lütfen bir gün ve saat seçin.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        Jobİnformation.shared.addInfo(key: "reservationdate", value: "Seçilen Gün: \(selectedDay), Seçilen Saat: \(selectedHour)")
        let vc = DetailPage()
        let currentDate = getCurrentMonthAndYear()
        vc.jobid = jobid
        vc.reservationMonth = currentDate.month
        vc.reservationYear = currentDate.year
        vc.reservationDay = selectedDay
        vc.reservationHour = selectedHour
        navigationController?.pushViewController(vc, animated: true)
        print("Seçilen Gün: \(selectedDay), Seçilen Saat: \(selectedHour)")
    }
    
    func getCurrentMonthAndYear() -> (month: String, year: String) {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM" // Tam ay adı
        dateFormatter.locale = Locale(identifier: "tr_TR") // Türkçe ay isimleri için dil ayarı
        let currentMonth = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "yyyy" // Yıl
        let currentYear = dateFormatter.string(from: date)
        return (month: currentMonth, year: currentYear)
    }
}
