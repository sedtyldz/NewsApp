//
//  MainPage.swift
//  NewsApp
//
//  Created by Sedat Yıldız on 19.09.2024.
//

import SwiftUI

struct MainPage: View {
    var body: some View {
        
        TabView{
                NewsPage()
                    .tabItem {
                        Label("News", systemImage: "newspaper")
                    }
                UserPage()
                    .tabItem {
                        Label("Profile", systemImage: "person.circle")
                    }
        }
        .navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    MainPage()
}
