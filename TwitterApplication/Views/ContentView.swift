//
//  ContentView.swift
//  TwitterApplication
//
//  Created by Janus Jordan on 11/21/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            ZStack {
                ZStack {
                    AuthView()
                }
                SplashScreen()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
