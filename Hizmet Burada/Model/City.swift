import Foundation

// İl ve ilçe verilerini temsil eden model
struct Sehir: Codable {
    let il: String
    let plaka: Int
    let ilceleri: [String]
    
    // CodingKeys enumu ile JSON anahtarlarını Swift property'leri ile eşleştiriyoruz.
    enum CodingKeys: String, CodingKey {
        case il
        case plaka
        case ilceleri
    }
}

// Tüm şehirleri içeren ana yapı
struct Sehirler: Codable {
    let sehirler: [Sehir]
    
    // Sehirler ana yapısı için de aynı mantıkta CodingKeys tanımı yapıyoruz
    enum CodingKeys: String, CodingKey {
        case sehirler
    }
}
