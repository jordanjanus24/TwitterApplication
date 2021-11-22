//
//  Post.swift
//  TwitterApplication
//
//  Created by Janus Jordan on 11/21/21.
//

import Foundation
import FirebaseFirestoreSwift

struct Post: Identifiable, Codable {
    
    @DocumentID var id: String?
    let postMessage: String
    let uid: String
    let timestamp: Date
    var likes: [String]
    var user: User? = nil
    enum CodingKeys: String, CodingKey {
        case id, postMessage, uid, timestamp, likes, user
    }
}
