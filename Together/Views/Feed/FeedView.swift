//
//  FeedView.swift
//  Together
//
//  Created by Hasan Narmah on 07/03/2024.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
        NavigationStack{
            ScrollView{
                LazyVStack{
                    ForEach(0...10, id: \.self) { post in
                        PostsView()
                    }
                }
            }
            
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                   Text("Together")
                        .font(.custom("Futura", size: 30))
                        .foregroundColor(AppColor.text)
                        .fontWeight(.bold)
                        .padding(.bottom)
                }
                ToolbarItem(placement: .navigationBarTrailing){
                   Image(systemName: "person.fill")
                        .font(.custom("Futura", size: 20))
                        .foregroundColor(AppColor.text)
                        .fontWeight(.bold)
                        .padding(.bottom)
                }
            }
        }
        
    }
}
    
    #Preview {
        FeedView()
    }

