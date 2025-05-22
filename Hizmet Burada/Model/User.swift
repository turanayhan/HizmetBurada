//
//  User.swift
//  Hizmet Burada
//
//  Created by turan on 15.11.2023.
//

import Foundation

struct User: Codable {
    var nameSurname: String?
    var gsm: String?
    var email: String?
    var id: String?
    var status : String?
    var adress : String?
    var profileImage : String?
    var answerSelection:[String]? = []
    var extraİnformation  :String?
    enum CodingKeys: String, CodingKey {
        case nameSurname
        case gsm
        case email
        case id
        case status
        case adress
        case profileImage
        case answerSelection
        case extraİnformation
    }
}
