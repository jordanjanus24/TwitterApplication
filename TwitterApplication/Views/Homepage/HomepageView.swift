//
//  HomepageView.swift
//  TwitterApplication
//
//  Created by Janus Jordan on 11/21/21.
//

import SwiftUI
    
struct HomepageView: View {
    
    @EnvironmentObject var auth: AuthViewModel
    @EnvironmentObject var users: UserViewModel
    @EnvironmentObject var home: HomeViewModel
    
    
    let icons = [
        "house",
        "magnifyingglass",
        "plus",
        "person.circle",
        "key"
    ]
    
    var body: some View {
        VStack {
            ZStack {
                AddNewPostView(posts: PostsViewModel())
                switch self.home.selectedIndex {
                    case 0:
                    if self.users.currentUser != nil {
                        PostsView(viewModel: PostsViewModel(),
                              userIds: [self.auth.userId] + (self.users.currentUser?.following ?? []))
                        .navigationBarTitle("Home")
                    }
                    case 1:
                        SearchView()
                    case 3:
                        ProfileView()
                    default:
                        List {
                            VStack {
                                Spacer()
                                Text("Second Screen")
                                Spacer()
                            }.navigationTitle("Second")
                        }
                }
                
            }
            Spacer()
            Divider()
            HStack {
                ForEach(0..<icons.count,id: \.self) { number in
                    Spacer()
                    Button(action: {
                        if number == 2 {
                            self.home.addNewPost.toggle()
                        }
                        else if number == 4 {
                            auth.signOut()
                        }
                        else {
                            self.home.lastSelectedIndex = self.home.selectedIndex
                            self.home.selectedIndex = number
                        }
                    }) {
                        if number == 2 {
                            Image(systemName: icons[number])
                                .font(.system(size:25,
                                              weight: .regular,
                                              design: .default))
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                                .background(Color.blue)
                                .cornerRadius(30)
                            
                        } else {
                            Image(systemName: icons[number])
                                .font(.system(size:25,
                                              weight: .regular,
                                              design: .default))
                                .foregroundColor(self.home.selectedIndex == number ? Color(.label) : Color(UIColor.lightGray))
                            
                        }
                       
                    }
                    Spacer()
                }
            }.padding()
           
        }
    }
}


struct HomepageView_Preview: PreviewProvider {
    static var previews: some View {
        HomepageView()
            .environmentObject(HomeViewModel())
    }
}
