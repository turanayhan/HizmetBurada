//
//  FirestoreManager.swift
//  Hizmet Burada
//
//  Created by turan on 12.11.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import Firebase
class FirestoreManager {
    let db = Firestore.firestore()
    func signIn(withEmail email: String, password: String, completion: @escaping (Result<AuthDataResult?, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(authResult))
            }
        }
    }
    
    func UserRecipientPush(user: User, completion: @escaping (Result<String, Error>) -> Void) {
        let ref = Database.database().reference()
        var userData: [String: Any] = [:]  // Dışarıda bir kez tanımlandı.

        if user.status == "Recipient" {
            userData = [
                "nameSurname": user.nameSurname ?? "",
                "gsm": user.gsm ?? "",
                "email": user.email ?? "",
                "id" : user.id ?? "",
                "status" : user.status ?? "",
                "adress" : user.adress ?? ""
            ]
        } else if user.status == "Provider" {
            userData = [
                "nameSurname": user.nameSurname ?? "",
                "gsm": user.gsm ?? "",
                "email": user.email ?? "",
                "id" : user.id ?? "",
                "status" : user.status ?? "",
                "adress" : user.adress ?? "",
                "imageUrl":user.profileImage,
                "answerSelection": user.answerSelection ?? "",  // Nil check gerekli
                "extraInformation": user.extraİnformation ?? "" // Nil check gerekli
            ]
        }
        // Realtime Database'de 'User' koleksiyonuna customID ile veri ekleme
        ref.child("User").child(user.id ?? "").setValue(userData) { error, _ in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success("Başarılı"))
            }
        }
    }

    func UserUpdatetPush(user: User, completion: @escaping (Result<String, Error>) -> Void) {
        let ref = Database.database().reference()
        var userData: [String: Any] = [:]  // Dışarıda bir kez tanımlandı.

            userData = [
                "nameSurname": user.nameSurname ?? "",
                "gsm": user.gsm ?? "",
                "email": user.email ?? "",
                "id" : user.id ?? "",
                "status" : user.status ?? "",
                "adress" : user.adress ?? ""
            ]
        
     
        ref.child("User").child(user.id ?? "").updateChildValues(userData) { error, _ in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success("Başarılı"))
            }
        }
    }

    
    
    
    
    func fetchJobModel(completion: @escaping ([String: Any]) -> Void) {
        let databaseRef = Database.database().reference()
        var gelenddeger: [String: Any] = [:]

        databaseRef.child("İs Bilgileri").observeSingleEvent(of: .value) { (snapshot) in
            if let value = snapshot.value as? [String: Any] {
                gelenddeger = value
                completion(gelenddeger)
            } else {
                completion([:])
            }
        }
    }



    
    
    

    func downloadImage(from path: String, completion: @escaping (UIImage?) -> Void) {
        let storageRef = Storage.storage().reference(withPath: path)

        storageRef.getData(maxSize: 1 * 512 * 512) { data, error in
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
                completion(nil)
            } else {
                if let data = data, let image = UIImage(data: data) {
                    completion(image)
                } else {
                    completion(nil)
                }
            }
        }
    }
    
    
    
    
    
  
    

    
   
}
