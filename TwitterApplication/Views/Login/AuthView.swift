//
//  AuthView.swift
//  TwitterApplication
//
//  Created by Janus Jordan on 11/21/21.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            if viewModel.signedIn {
                HomepageView()
            }
            else {
                LoginView()
            }
        }.alert(isPresented: self.$viewModel.shouldShowError, content: {
            Alert(title: Text("Error"), message: Text(viewModel.errorDescription), dismissButton: .default(Text("Got it!")))
        })
    }
}
