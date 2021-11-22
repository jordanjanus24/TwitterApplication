//
//  RegistrationView.swift
//  TwitterApplication
//
//  Created by Janus Jordan on 11/21/21.
//

import SwiftUI

struct RegistrationView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State var username = ""
    @State var email = ""
    @State var firstName = ""
    @State var lastName = ""
    @State var password = ""
    @State var birthdate: Date = Date()

    var body: some View {
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding(.top,50)
                Text("Create an Account")
                VStack {
                    TextField("@Username", text: $username)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .background(Color(.secondarySystemFill))
                    HStack {
                        TextField("First", text: $firstName)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .padding()
                            .background(Color(.secondarySystemFill))
                        TextField("Last", text: $lastName)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .padding()
                            .background(Color(.secondarySystemFill))
                    }
                    TextField("Email Address", text: $email)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .background(Color(.secondarySystemFill))
                    SecureField("Password", text: $password)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .background(Color(.secondarySystemFill))
                    DatePicker(
                        "Birthdate",
                        selection: $birthdate,
                        displayedComponents: [.date]
                    ).padding()
                    Button(action: {
                        guard !username.isEmpty, !email.isEmpty, !password.isEmpty else {
                            return
                        }
                        viewModel.signUp(username: username,
                                         name:
                                            (first: firstName,
                                             last:lastName),
                                         email: email,
                                         password: password,
                                         birthdate: birthdate)
                    }, label: {
                        Text("Create Account")
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50)
                            .cornerRadius(8)
                            .background(Color.blue)
                    }).padding()
                }.padding()
                Spacer()
            }
        }
}

struct RegistrationView_Preview: PreviewProvider {
    static var previews: some View {
        RegistrationView()
            .environmentObject(AuthViewModel(users: UserViewModel()))
    }
}
