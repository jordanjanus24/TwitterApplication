//
//  PostsView.swift
//  TwitterApplication
//
//  Created by Janus Jordan on 11/21/21.
//

import SwiftUI

struct PostsView: View {
    let viewModel: PostsViewModel
    
    @State var userIds: [String]
    @State var posts: [Post] = []
    
    init(viewModel: PostsViewModel = PostsViewModel(), userIds: [String], posts: [Post] = []) {
        self.viewModel = viewModel
        self.userIds = userIds
        self.posts = posts
    }
    
    var body: some View {
        VStack {
            if posts.count>=1 {
                List{
                    ForEach(0..<posts.count, id: \.self) { index in
                        PostItemView(viewModel: viewModel, post: posts[index])
                    }
                }
            } else {
                Spacer()
                Text("No Posts yet.")
                Spacer()
            }
        }
        .onAppear {
            self.viewModel.listenToUserIds(userIds: self.userIds) { posts in
                self.posts = posts
            }
        }.listStyle(.plain).listRowSeparator(.hidden)
    }
}


struct PostsView_Previews: PreviewProvider {
    static var previews: some View {
        let mockUser: User = User(username: "@jordanjanus",
                            firstName: "Janus",lastName: "Jordan",
                            emailAddress: "jordanjanus24@gmail.com",
                            birthdate: .now,
                            tagline: "Welcome to my Profile!",
                            profilePhoto: "",
                            uid: "UIDTEST",
                            joinDate: .now,
                            followers: [],following: [])
        let mockPost: Post = Post(id: nil,
                                  postMessage: "This is my first and last tweet. Welcome to Twitter \n #iosdevelopment",
                                  uid: "UIDTEST",
                                  timestamp: .now,
                                  likes: ["UIDTEST"],
                                  user: mockUser)
        PostsView(viewModel: PostsViewModel(), userIds: [], posts: [mockPost])
        
    }
}

