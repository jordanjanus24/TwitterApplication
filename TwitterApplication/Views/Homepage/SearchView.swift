//
//  SearchView.swift
//  TwitterApplication
//
//  Created by Janus Jordan on 11/22/21.
//

import SwiftUI
struct SearchView: View {
    
    @EnvironmentObject var users: UserViewModel
    
    @State var searchResults: [User] = []
    @State var isEditing = false
    @State var searchText = ""
    var body: some View {
        VStack {
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, alignment: .leading)
                    TextField("@Username", text: $searchText)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .onSubmit {
                            self.users.fetchUsersByUsername(username: searchText, completion: { users in
                                print(self.searchResults)
                                self.searchResults = users
                            })
                        }
                    Spacer()
                }.padding(7)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
                if isEditing {
                    Button(action: {
                        self.isEditing = false
                        self.searchText = ""
                    }) {
                        Text("Cancel")
                    }
                    .padding(.trailing, 10)
                    .transition(.move(edge: .trailing))
                    .animation(.linear, value: isEditing)
                }
            }
            if searchText != "" {
                List{
                    ForEach(0..<searchResults.count, id: \.self) { index in
                        UserItemView(user: searchResults[index],
                                     currentUser: searchResults[index].uid == (self.users.currentUser?.uid)!)
                    }
                }.listStyle(.plain).listRowSeparator(.hidden)
            } else {
                VStack {
                    Spacer()
                    Text("No Users found.")
                    Spacer()
                }
            }
            
        }
        .navigationTitle("Search")
    }
}
