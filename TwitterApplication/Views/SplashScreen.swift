//
//  SplashScreen.swift
//  TwitterApplication
//
//  Created by Janus Jordan on 11/21/21.
//

import SwiftUI

struct SplashScreen: View {
    @State var animate: Bool = false
    @State var showSplash: Bool = true
    var body: some View {
        ZStack {
            Color(ACCENT_COLOR)
            Image("logo-white")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 85, height: 85)
                .scaleEffect(animate ? 50 : 1)
                .animation(.easeOut(duration: 0.7), value: animate)
        }
        .edgesIgnoringSafeArea(.all)
        .opacity(showSplash ? 1: 0)
        .animation(.easeIn(duration: 0.5), value: showSplash)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                animate.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                showSplash.toggle()
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
