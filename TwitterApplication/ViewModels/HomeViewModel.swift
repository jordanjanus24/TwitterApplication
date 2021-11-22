//
//  HomeViewModel.swift
//  TwitterApplication
//
//  Created by Janus Jordan on 11/21/21.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var selectedIndex: Int = 0
    @Published var lastSelectedIndex: Int = 0
    
    @Published var addNewPost = false
}
