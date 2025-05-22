import UIKit

class CheckboxButton: UIButton {
    
    // Varsayılan kapalı (false) başlasın
    var isChecked: Bool = false {
        didSet {
            updateAppearance()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }

    private func setupButton() {
        // Varsayılan görüntüyü ayarla
        setImage(UIImage(systemName: "square"), for: .normal)
        setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        tintColor = .systemBlue
        
        // Butona tıklanınca toggle fonksiyonunu çağır
        addTarget(self, action: #selector(toggleCheckbox), for: .touchUpInside)
    }

    @objc private func toggleCheckbox() {
        isChecked.toggle()
        isSelected = isChecked
    }

    private func updateAppearance() {
        isSelected = isChecked
    }
}
