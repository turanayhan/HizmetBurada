//
//  UserDefaultsManager.swift
//  Hizmet Burada
//
//  Created by turan on 18.11.2023.
//

import Foundation

class UserManager {
    
    static let shared = UserManager()
    
    // Kullanıcı adını UserDefaults'a kaydetme
    func setUser(user : User) {
        UserDefaults.standard.set(user.nameSurname, forKey: "nameSurname")
        UserDefaults.standard.set(user.gsm, forKey: "gsm")
        UserDefaults.standard.set(user.email, forKey: "mail")
        UserDefaults.standard.set(user.id, forKey: "id")
        UserDefaults.standard.set(user.adress, forKey: "adress")
        UserDefaults.standard.set(user.status, forKey: "status")
        
    }
    
    
    func setId(id: String){
        UserDefaults.standard.set(id, forKey: "id")
    }
    
    // Kullanıcı adını UserDefaults'dan alma
    func getUserName() -> String? {
        return UserDefaults.standard.string(forKey: "name")
    }
    
    func getUser()->User{
        var nameSurname = UserDefaults.standard.string(forKey: "nameSurname")
        var gsm = UserDefaults.standard.string(forKey: "gsm")
        var mail = UserDefaults.standard.string(forKey: "mail")
        var id = UserDefaults.standard.string(forKey: "id")
        var adress = UserDefaults.standard.string(forKey: "adress")
        var status = UserDefaults.standard.string(forKey: "status")
        return User(nameSurname:nameSurname,gsm: gsm,email: mail,id: id,status: status,adress: adress)
    }
    // Kullanıcı adını UserDefaults'tan silme
    func removeUserName() {
        UserDefaults.standard.removeObject(forKey: "nameSurname")
    }
    
  
    
    func isLogin(){
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
    }
    func isLoginControl()->Bool{
    
        var login = UserDefaults.standard.bool(forKey: "isLoggedIn")
        return login
    }
    
    func isLogouth() {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        
    }
    
    
    func checkUserLoginStatus()->Bool {
        // UserDefaults'tan giriş durumunu kontrol et
        let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        
        return isLoggedIn
        
    }

    
    
    
}
