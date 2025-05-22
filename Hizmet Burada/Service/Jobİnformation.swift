//
//  Jobİnformation.swift
//  Hizmet Burada
//
//  Created by turan on 30.11.2023.
//

import Foundation


class Jobİnformation {
 
    static let shared = Jobİnformation()
    
    var information:[String:String] = [:]
    var jobDetail : String?
    
    func addInfo(key : String,value:String) {
        information[key] = value
    
    }
    
    
  
    
    
}
