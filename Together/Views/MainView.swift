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
                    
                }
            
            SearchUserView()
                  .tabItem{
                      Image(systemName: "magnifyingglass.circle.fill")
                      
                  }
            
            CreatePostView()
                .tabItem{
                    Image(systemName: "plus")
                    
                }
            
            Nearby()
                .tabItem{
                    Image(systemName: "location.circle")
                    
                }
            

            ProfileView()
                .tabItem{
                    Image(systemName: "person.crop.circle.fill")
                    
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
