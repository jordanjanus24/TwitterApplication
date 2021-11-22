//
//  PostItemView.swift
//  TwitterApplication
//
//  Created by Janus Jordan on 11/22/21.
//

import SwiftUI

struct PostItemView: View {
    @EnvironmentObject var users: UserViewModel
    let viewModel: PostsViewModel
    @State var post: Post
    var body: some View {
        HStack {
            VStack {
                Image(systemName: "person.circle.fill")
                    .font(.system(size:40,
                                  weight: .regular,
                                  design: .default))
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
                    .background(Color(UIColor.lightGray))
                    .cornerRadius(25)
                Spacer()
            }.padding()
            VStack {
                HStack {
                    Text((post.user?.firstName ?? "First") + " " + (post.user?.lastName ?? "Last"))
                        .font(.system(size:20,
                                      weight: .heavy,
                                      design: .default))
                        .foregroundColor(Color(UIColor.label))
                    Text((post.user?.username ?? "@Username"))
                        .font(.system(size:15,weight: .regular, design: .default))
                        .foregroundColor(Color(UIColor.darkGray))
                    Spacer()
                }
                HStack {
                    Image(systemName: "clock.fill")
                        .font(.system(size:15,
                                      weight: .regular,
                                      design: .default))
                        .foregroundColor(Color(UIColor.lightGray))
                        .frame(width: 15, height: 15)
                    Text(post.timestamp.relative())
                        .font(.system(size:15,weight: .regular, design: .default))
                        .foregroundColor(Color(UIColor.darkGray))
                    Spacer()
                }
                HStack {
                    Text(post.postMessage)
                        .font(.system(size:15,weight: .regular, design: .default))
                        .foregroundColor(Color(UIColor.darkGray))
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(width: .infinity, alignment: .leading)
                    Spacer()
                }
                HStack {
                    Button(action: {
                        guard self.users.currentUser != nil else {
                            return
                        }
                        self.viewModel.likeUnlikePost(postId: self.post.id!, userId: self.users.currentUser!.uid) { likes in
                            self.post.likes = likes
                        }
                    }) {
                        Image(systemName: self.post.likes.contains(self.users.currentUser!.uid) ? "heart.fill" : "heart")
                            .font(.system(size:20,
                                          weight: .regular,
                                          design: .default))
                            .foregroundColor(self.post.likes.contains(self.users.currentUser!.uid) ? Color(UIColor.systemPink) : Color(UIColor.lightGray))
                            .frame(width: 30, height: 30)
                    }.buttonStyle(PlainButtonStyle())
                    Text(String(post.likes.count))
                        .font(.system(size:15,weight: .regular, design: .default))
                        .foregroundColor(Color(UIColor.darkGray))
                    Spacer()
                }
            }.padding(.top, 5)
            Spacer()
        }
    }
}


struct PostItemView_Previews: PreviewProvider {
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
                                  postMessage: "This is my first and last tweet. Welcome to Twitter \n#iosdevelopment\n#swiftUIDevelopment\n#mobileAppDev",
                                  uid: "UIDTEST",
                                  timestamp: .now.addingTimeInterval(-1500),
                                  likes: ["UIDTEST"],
                                  user: mockUser)
        PostItemView(viewModel: PostsViewModel(), post: mockPost)
            .previewLayout(.fixed(width: 500, height: 180))
        
    }
}

