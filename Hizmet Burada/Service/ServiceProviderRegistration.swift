//
//  RegistrationInformation.swift
//  Hizmet Burada
//
//  Created by turan on 6.01.2024.
//

import UIKit

class ServiceProviderRegistration {
 
    static let rgİnformation = ServiceProviderRegistration()
    
 
    var nameSurname : String?
    var gsm : String?
    var adrees : String?
    var answerSelection:[String] = []
    var extraİnformation  :String?
    var mail : String?
    var userİd : String?
    var profileImage : String?
    
    
    func addInfo(value:String) {
        answerSelection.append(value)
    
    }
    
    func createUser(status:String)->User{
        
        let user = User(nameSurname: nameSurname,
                        gsm: gsm,
                        email: mail,
                        id: userİd,
                        status: status,
                        adress: adrees,
                        profileImage: profileImage,
                        answerSelection:answerSelection,
                        extraİnformation: extraİnformation
        )
        
        return user
    }
    
 
}
