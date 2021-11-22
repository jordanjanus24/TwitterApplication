//
//  UserItemView.swift
//  TwitterApplication
//
//  Created by Janus Jordan on 11/22/21.
//

import SwiftUI
struct UserItemView: View {
    
    @EnvironmentObject var users: UserViewModel
    @State var user: User
    @State var currentUser = false
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
                    Text(user.firstName + " " + user.lastName)
                        .font(.system(size:20,
                                      weight: .heavy,
                                      design: .default))
                        .foregroundColor(Color(UIColor.label))
                    Text(user.username)
                        .font(.system(size:15,weight: .regular, design: .default))
                        .foregroundColor(Color(UIColor.darkGray))
                    Spacer()
                }
                HStack {
                    Image(systemName: "calendar")
                        .font(.system(size:15,
                                      weight: .regular,
                                      design: .default))
                        .foregroundColor(Color(UIColor.lightGray))
                        .frame(width: 15, height: 15)
                    Text("Joined " + user.joinDate.relative())
                        .font(.system(size:15,weight: .regular, design: .default))
                        .foregroundColor(Color(UIColor.darkGray))
                    Spacer()
                }
                HStack {
                    Text(String(user.following.count))
                        .font(.system(size:15,
                                      weight: .bold,
                                      design: .default))
                        .foregroundColor(Color(UIColor.label))
                    Text("Following")
                        .font(.system(size:15,
                                      weight: .regular,
                                      design: .default))
                        .foregroundColor(Color(UIColor.darkGray))
                    Text(String(user.followers.count))
                        .font(.system(size:15,
                                      weight: .bold,
                                      design: .default))
                        .foregroundColor(Color(UIColor.label))
                    Text("Followers")
                        .font(.system(size:15,
                                      weight: .regular,
                                      design: .default))
                        .foregroundColor(Color(UIColor.darkGray))
                    Spacer()
                }
                if !currentUser {
                    HStack {
                        Button(action: {
                            self.users.followUnfollowUser(userId: self.user.uid) { user in
                                self.user = user
                            }
                        }) {
                            Text(users.isCurrentlyFollowing(userId: user.uid) ? "Unfollow" : "Follow")
                                .foregroundColor(Color.white)
                                .frame(width: 120, height: 30)
                                .background(Color(ACCENT_COLOR))
                                .cornerRadius(1)
                        }.buttonStyle(PlainButtonStyle())
                        
                        Spacer()
                    }
                }
                
                Spacer()
            }.padding()
        }
    }
}



struct UserItemView_Previews: PreviewProvider {
    static var previews: some View {
        UserItemView(user: User(username: "@jordanjanus",
                                firstName: "Janus",lastName: "Jordan",
                                emailAddress: "jordanjanus24@gmail.com",
                                birthdate: .now,
                                tagline: "Welcome to my Profile!",
                                profilePhoto: "",
                                uid: "",
                                joinDate: .now.addingTimeInterval(-1500),
                                followers: [],following: []))
            .previewLayout(.fixed(width: 500, height: 180))
    }
}
