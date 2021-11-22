//
//  PostsViewModel.swift
//  TwitterApplication
//
//  Created by Janus Jordan on 11/21/21.
//

import SwiftUI
import FirebaseFirestore

class PostsViewModel: ObservableObject {
    private var POSTS = "posts"
    private var USERS = "users"
    private var db = Firestore.firestore()
    
    @Published var posts: [Post] = []
    
    func addPost(userId: String, postMessage: String, completion: @escaping () -> Void) {
        let post = Post(postMessage: postMessage, uid: userId, timestamp: .now, likes: [])
        let _ = try? db.collection(POSTS).addDocument(from: post) { error in
            guard error == nil else {
                return
            }
            completion()
        }
    }
    
    func listenToUserIds(userIds: [String], completion: @escaping ([Post]) -> Void) {
        db.collection(POSTS)
            .order(by: "timestamp", descending: true)
            .whereField("uid", in: userIds)
            .addSnapshotListener { querySnapshot, error in
                guard error == nil else {
                    return
                }
                guard let documents = querySnapshot?.documents else {
                    return
                }
                self.posts = documents.compactMap { (document) -> Post? in
                    return try? document.data(as: Post.self)
                }
                let postUserIds = self.posts.map { post in post.uid }.removingDuplicates()
                if postUserIds.count >= 1 {
                    self.getUsersForPosts(userIds: postUserIds, completion: completion)
                } else {
                    completion(self.posts)
                }
        }
    }
    private func getUsersForPosts(userIds: [String], completion: @escaping([Post]) -> Void) {
        let data = db.collection(USERS).whereField("uid", in: userIds)
        data.getDocuments(completion: {
            querySnapshot, error in
            guard (!(querySnapshot?.documents.isEmpty)!) else {
                return
            }
            guard let documents = querySnapshot?.documents else {
                return
            }
            let users = documents.compactMap { document in
                return try? (document.data(as: User.self))!
            }
            self.posts = self.posts.compactMap { (post) -> Post in
                var post = post
                let userFound = users.filter { user in user.uid == post.uid }
                guard !userFound.isEmpty else {
                    return post
                }
                post.user = userFound.first
                return post
            }
            completion(self.posts)
            
        })
        
    }
    func likeUnlikePost(postId: String, userId: String, completion: @escaping ([String]) -> Void) {
        let data = db.collection(POSTS).document(postId)
        data.getDocument( completion: { docSnapshot, error in
            guard docSnapshot != nil, error == nil else {
                return
            }
            guard var post = try? docSnapshot?.data(as: Post.self) else {
                return
            }
            if post.likes.contains(userId) {
                post.likes = post.likes.filter { likeUser in likeUser != userId }
            } else {
                post.likes.append(userId)
            }
            completion(post.likes)
            try? docSnapshot?.reference.setData(from: post)
            
        })
    }
    
    
}
