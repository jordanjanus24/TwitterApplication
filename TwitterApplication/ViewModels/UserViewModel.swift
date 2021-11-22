//
//  UserViewModel.swift
//  TwitterApplication
//
//  Created by Janus Jordan on 11/21/21.
//

import SwiftUI
import FirebaseFirestore


class UserViewModel: ObservableObject {
    private var ID = "users"
    private var db = Firestore.firestore()
    @Published var currentUser: User? = nil
    
    func fetchUser(uid: String, completion: @escaping (User) -> Void ) {
        let data = db.collection(ID).whereField("uid", isEqualTo: uid)
        data.getDocuments(completion: {
            querySnapshot, error in
                guard (!(querySnapshot?.documents.isEmpty)!) else {
                   return
               }
               guard let document = querySnapshot?.documents[0] else {
                   return
               }
            do {
               completion(try (document.data(as: User.self))!)
            } catch {
                print(error)
            }
        })
        
    }
    func loginUser(user: User) {
        self.currentUser = user
    }
    
    func createUser(userId: String, name: (first: String, last: String), username: String, emailAddress: String, birthdate: Date, completion:@escaping (User) -> Void ) {
        let userTag: String = username.prefix(1) != "@" ? "@" + username: username
        let user = User(username: userTag,
                        firstName: name.first,
                        lastName: name.last,
                        emailAddress: emailAddress,
                        birthdate: birthdate,
                        tagline: "",
                        profilePhoto: "",
                        uid: userId,
                        joinDate: .now,
                        followers: [],
                        following: [])
        let _ = try? db.collection(ID).addDocument(from: user) { error in
            guard error == nil else {
                return
            }
            completion(user)
        }
    }
    func fetchUsersByUsername(username: String, completion: @escaping ([User]) -> Void) {
        let data = db.collection(ID)
        data.getDocuments(completion: {
            querySnapshot, error in
               guard querySnapshot != nil,error == nil else {
                   return
               }
               guard let documents = querySnapshot?.documents else {
                   return
               }
               var users = documents.compactMap { (document) -> User? in
                   return try? document.data(as: User.self)
               }
               users = users.filter { user in user.username.contains(username)}
               completion(users)
        })
    }
    func followUnfollowUser(userId: String, completion: @escaping (User)-> Void) {
        let data = db.collection(ID)
        data.whereField("uid", isEqualTo: userId).getDocuments { querySnapshot, error in
            guard querySnapshot != nil, self.currentUser != nil, error == nil else {
                return
            }
            guard let documents = querySnapshot?.documents,!documents.isEmpty else {
                return
            }
            guard var followingUser = try? documents.first?.data(as: User.self) else {
                return
            }
            guard let currentUserId = self.currentUser?.uid else {
                return
            }
            if(self.isCurrentlyFollowing(userId: userId)) {
                self.currentUser?.following = (self.currentUser?.following.filter { following in following != userId})!
                followingUser.followers = followingUser.followers.filter { following in following != currentUserId}
            }
            else {
                self.currentUser?.following.append(userId)
                followingUser.followers.append(currentUserId)
            }
            self.updateUser(userId: self.currentUser!.uid, user: self.currentUser!)
            self.updateUser(userId: followingUser.uid, user: followingUser)
            completion(followingUser)
        }
    }
    private func updateUser(userId: String,user: User) {
        db.collection(ID).whereField("uid", isEqualTo: userId)
            .getDocuments { querySnapshot, error in
            guard querySnapshot != nil,error == nil else {
                return
            }
            guard let documents = querySnapshot?.documents,!documents.isEmpty else {
                return
            }
            try? documents.first?.reference.setData(from: user)
        }
        
    }
    
    func isCurrentlyFollowing(userId: String) -> Bool {
        return currentUser?.following.contains(userId) ?? false
    }
}
