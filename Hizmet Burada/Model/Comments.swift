//
//  comment.swift
//  Hizmet Burada
//
//  Created by turan on 25.09.2024.
//
struct Comments: Codable {
    var nameSurname: String?
    var date : String?
    var star : Int?
    var commentText: String?
    
    enum CodingKeys: String, CodingKey {
        case nameSurname
        case date
        case star
        case commentText
    }
}
