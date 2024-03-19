//
//  MainView.swift
//  Together
//
//  Created by Hasan Narmah on 09/03/2024.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        
        //TabView with recent posts and profile tab
        TabView {
          FeedView()
                .tabItem{
                    Image(systemName: "rectangle.portrait.on.rectangle.portrait.angled")
                    Text("Posts")
                }
            
            SearchUserView()
                  .tabItem{
                      Image(systemName: "magnifyingglass.circle.fill")
                      Text("Search")
                  }
            
            Nearby()
                .tabItem{
                    Image(systemName: "location.circle")
                    Text("Nearby")
                }
            
            ProfileView()
                .tabItem{
                    Image(systemName: "person.crop.circle.fill")
                    Text("Profile")
                }
        }
        //changing tab lable colour
        .background(Color.clear)
        .tint(AppColor.accent)
    }
}


#Preview {
    MainView()
}
