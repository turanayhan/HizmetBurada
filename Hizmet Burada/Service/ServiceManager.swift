//
//  ServiceManager.swift
//  Hizmet Burada
//
//  Created by turan on 7.10.2024.
//
import Foundation
import Firebase
import FirebaseDatabase

class ServiceManager {
    private var ref: DatabaseReference!

        init() {
            ref = Database.database().reference()
        }
        
        func fetchCategoryData(completion: @escaping ([Category]?) -> Void) {
            // Firebase'deki "services" yolundaki veriyi alıyoruz
            ref.child("services").observeSingleEvent(of: .value, with: { snapshot in
                
                // Gelen verinin dizi formatında olup olmadığını kontrol ediyoruz
                guard let valueArray = snapshot.value as? [[String: Any]] else {
                    print("Veri alınamadı veya beklenen formata uygun değil.")
                    completion(nil)
                    return
                }
                
                do {
                    // Gelen veriyi JSON'a çeviriyoruz
                    let jsonData = try JSONSerialization.data(withJSONObject: valueArray, options: [])
                    // JSON verisini [Category] modeline decode ediyoruz
                    let categories = try JSONDecoder().decode([Category].self, from: jsonData)
                    completion(categories) // Başarıyla alınan veriyi completion ile geri döndürüyoruz
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                    completion(nil)
                }
                
            }) { error in
                print("Error fetching data: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
