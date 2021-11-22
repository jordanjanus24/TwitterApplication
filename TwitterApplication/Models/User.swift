//
//  User.swift
//  TwitterApplication
//
//  Created by Janus Jordan on 11/21/21.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Identifiable, Codable {
    @DocumentID var id: String?
    let username: String
    let firstName: String
    let lastName: String
    let emailAddress: String
    let birthdate: Date
    let tagline: String
    let profilePhoto: String
    let uid: String
    let joinDate: Date
    var followers: [String]
    var following: [String]
    enum CodingKeys: String, CodingKey {
        case id, username, firstName, lastName, emailAddress, birthdate, tagline, profilePhoto, uid, joinDate, followers, following
    }
}
