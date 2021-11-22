//
//  AuthViewModel.swift
//  TwitterApplication
//
//  Created by Janus Jordan on 11/21/21.
//

import SwiftUI
import FirebaseAuth

class AuthViewModel: ObservableObject {
    
    var users: UserViewModel
    
    private let auth = Auth.auth()
    
    @Published var userId = ""
    @Published var signedIn = false
    
    @Published var shouldShowError = false
    @Published var errorDescription = ""
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    init(users: UserViewModel) {
        self.users = users
        self.signedIn = self.isSignedIn
        if self.isSignedIn {
            self.userId = self.auth.currentUser!.uid
            self.users.fetchUser(uid: self.userId) { user in
                self.users.loginUser(user: user)
            }
        }
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) {
            [weak self] result, error in
            DispatchQueue.main.async {
                if let error = error, let authError = AuthErrorCode(rawValue: error._code) {
                    self?.setErrorMessage(error: authError)
                    return
                }
                guard result != nil else {
                    return
                }
                self?.signedIn = true
                self?.userId = (result?.user.uid)!
                self?.users.fetchUser(uid: (self?.userId)!) { user in
                    self?.users.loginUser(user: user)
                }
            }
        }
    }
    func signUp(username: String, name: (first: String, last: String), email: String, password: String, birthdate: Date) {
        auth.createUser(withEmail: email, password: password) {
            [weak self] result, error in
            DispatchQueue.main.async {
                if let error = error, let authError = AuthErrorCode(rawValue: error._code) {
                    self?.setErrorMessage(error: authError)
                    return
                }
                guard result != nil, self?.auth.currentUser?.uid != nil else {
                    return
                }
                self?.signedIn = true
                self?.userId = (result?.user.uid)!
                self?.users.createUser(userId: (self?.userId)!,
                                       name: name,
                                       username: username,
                                       emailAddress: email,
                                       birthdate: birthdate) { user in
                    self?.users.loginUser(user: user)
                }
            }
        }
    }
    func signOut() {
        try? auth.signOut()
        self.signedIn = false
    }
    private func setErrorMessage(error: AuthErrorCode) {
        self.shouldShowError = true
        switch error {
            case .invalidEmail:
                self.errorDescription = "Invalid Email Address"
            case .emailAlreadyInUse:
                self.errorDescription = "Email Address is already in use."
            case .userNotFound:
                self.errorDescription = "User not found."
            case .wrongPassword:
                self.errorDescription = "Invalid Password"
            case .weakPassword:
                self.errorDescription = "Password is too weak"
            default: return
        }
    }
}
