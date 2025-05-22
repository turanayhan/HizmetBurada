//
//  BidModel.swift
//  Hizmet Burada
//
//  Created by turan on 22.10.2024.
//

struct BidModel {
    let id: String // Teklifin benzersiz kimliği
    let providerId: String // Hizmet sağlayıcının ID'si
    let providerName: String // Hizmet sağlayıcının adı
    let price: Double // Verilen teklif fiyatı
    let message: String // Teklifle ilgili açıklama
    let bidDate: String // Teklifin verildiği tarih
    var messages: [MessageModel]?
}


