import Foundation

// Mevcut modellemeler
struct Comment2: Codable {
    let nameSurname: String
    let star: Int
    let date: String
    let comment: String
}

struct Question: Codable {
    let question: String
    let answers: [String]
}

struct Task: Codable {
    let task: String
    let questions: [Question]
    let comments: [Comment2]
    let imageUrl: String
    let id: Int
    let personnelCount: Int
}

struct Category: Codable {
    let category: String
    let tasks: [Task]
}
