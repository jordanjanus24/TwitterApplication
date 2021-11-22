//
//  ProfileView.swift
//  TwitterApplication
//
//  Created by Janus Jordan on 11/21/21.
//

import SwiftUI
    
struct ProfileView: View {
    
    #if PREVIEW
    let user: UserViewModel
    
    init(user: UserViewModel) {
        self.user = user
    }
    #else
    @EnvironmentObject var user: UserViewModel
    @EnvironmentObject var home: HomeViewModel
    #endif
    @State var currentUser: User?
    
    var body: some View {
        ZStack {
            VStack {
                GeometryReader { g in
                    Color(ACCENT_COLOR).frame(width: g.size.width, height: 200)
                }
                Spacer()
            }.edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Button(action: {
                        self.home.selectedIndex = self.home.lastSelectedIndex
                    }) {
                        Image(systemName: "arrow.backward")
                            .font(.system(size:20,
                                          weight: .regular,
                                          design: .default))
                            .foregroundColor(.white)
                            .frame(width: 50, height: 50)
                            .background(Color(UIColor.lightGray))
                            .cornerRadius(25)
                    }
                    Spacer()
                }.padding()
                HStack {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size:60,
                                      weight: .regular,
                                      design: .default))
                        .foregroundColor(.white)
                        .frame(width: 100, height: 100)
                        .background(Color(UIColor.lightGray))
                        .cornerRadius(50)
                    Spacer()
                }.padding(.leading,20)
                .padding(.trailing,20)
                .padding(.top,10)
                .padding(.bottom,0)
                VStack {
                    HStack {
                        Text((currentUser?.firstName ?? "First") + " " + (currentUser?.lastName ?? "Last"))
                            .font(.system(size:20,
                                          weight: .heavy,
                                          design: .default))
                            .foregroundColor(Color(UIColor.label))
                        Spacer()
                    }
                    HStack {
                        Text(currentUser?.username ?? "@Username")
                            .font(.system(size:15,
                                          weight: .regular,
                                          design: .default))
                            .foregroundColor(Color(UIColor.darkGray))
                        Spacer()
                    }
                    HStack {
                        Image(systemName: "calendar")
                            .font(.system(size:15,
                                          weight: .regular,
                                          design: .default))
                            .foregroundColor(Color(UIColor.darkGray))
                        Text("Joined " + (currentUser?.joinDate ?? .now).string(with: "MMMM yyyy"))
                            .font(.system(size:15,
                                          weight: .regular,
                                          design: .default))
                            .foregroundColor(Color(UIColor.darkGray))
                        Spacer()
                    }.padding(.top,3)
                    HStack {
                        Text(String(currentUser?.following.count ?? 0))
                            .font(.system(size:15,
                                          weight: .bold,
                                          design: .default))
                            .foregroundColor(Color(UIColor.label))
                        Text("Following")
                            .font(.system(size:15,
                                          weight: .regular,
                                          design: .default))
                            .foregroundColor(Color(UIColor.darkGray))
                        Text(String(currentUser?.followers.count ?? 0))
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
                    }.padding(.top,3)
                    
                }.padding(.leading, 23)
                HStack {
                    Spacer()
                    Text("Tweets")
                        .font(.system(size:15,
                                                weight: .heavy,
                                                design: .default))
                        .foregroundColor(Color(ACCENT_COLOR))
                        .padding()
                    Spacer()
                }
                Divider()
                PostsView(userIds: [(self.user.currentUser?.uid)!])
                Spacer()
                
            }.onAppear {
                self.currentUser = self.user.currentUser
            }.navigationBarHidden(true)
        }
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let mockUser: User = User(username: "@jordanjanus",
                        firstName: "Janus",lastName: "Jordan",
                        emailAddress: "jordanjanus24@gmail.com",
                        birthdate: .now,
                        tagline: "Welcome to my Profile!",
                        profilePhoto: "",
                        uid: "",
                        joinDate: .now,
                        followers: [],following: [])
        ProfileView(currentUser: mockUser)
            .environmentObject(UserViewModel())
        
    }
}
