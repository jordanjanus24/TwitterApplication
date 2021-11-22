//
//  AddNewPostView.swift
//  TwitterApplication
//
//  Created by Janus Jordan on 11/21/21.
//
import SwiftUI
import ToastUI

struct AddNewPostView: View {
    @EnvironmentObject var home: HomeViewModel
    @EnvironmentObject var user: UserViewModel
    let posts: PostsViewModel
    
    @State var postMessage = ""
    @State var showToast = false
    
    init(posts: PostsViewModel = PostsViewModel()) {
        self.posts = posts
    }
    
    var body: some View {
        Spacer().fullScreenCover(isPresented: $home.addNewPost, content: {
            VStack {
                HStack {
                    Button(action: {
                        self.home.addNewPost.toggle()
                    }) {
                        Text("Cancel")
                            .font(.system(size:17,
                                          weight: .regular,
                                          design: .default))
                            .foregroundColor(Color(UIColor.label))
                    }
                    Spacer()
                    Button(action: {
                        guard !postMessage.isEmpty else {
                            return
                        }
                        self.posts.addPost(userId: (self.user.currentUser?.uid)!, postMessage: postMessage) {
                            self.showToast = true
                        }
                    }) {
                        Text("Tweet")
                            .font(.system(size:17,
                                          weight: .bold,
                                          design: .default))
                            .frame(width: 100, height: 5)
                            .foregroundColor(Color(UIColor.white))
                            .padding()
                            .disabled(postMessage.isEmpty)
                            .background(!postMessage.isEmpty ? Color(ACCENT_COLOR) : Color(UIColor.systemGray))
                            .cornerRadius(5)
                    }.disabled(postMessage.isEmpty)
                }.padding()
                TextField("What's Happening?", text: $postMessage)
                    .font(.system(size:19,
                                  weight: .regular,
                                  design: .default))
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(.leading, 20)
                    .padding(.top, 5)
                    .padding(.trailing,20)
                    .foregroundColor(Color(UIColor.label))
                Spacer()
            }.toast(isPresented: $showToast, dismissAfter: 1.0, onDismiss: {
                self.showToast = false
                self.home.addNewPost.toggle()
            }, content: {
                ToastView("Successfully Added new Post.")
            })
        })
    }
}

