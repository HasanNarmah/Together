//
//  PostView.swift
//  Together
//
//  Created by Hasan Narmah on 08/03/2024.
//

import SwiftUI

struct PostsView: View {
    var body: some View {
        VStack(spacing:8){
            //images
            Rectangle()
                .frame(height: 250)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .foregroundColor(AppColor.background)
            
            //listing details
            HStack{
                VStack(alignment: .leading){
                  Text("Jane Doe")
                        .fontWeight(.semibold)
                        .font(.custom("Futura", size: 15))
                        .foregroundColor(AppColor.accent)
                    
                    Text("London, UK")
                        .foregroundColor(.gray)
                    
                    HStack(spacing: 4) {
                        Text("Posted")
                            .foregroundColor(.gray)
                            
                        Text("6:01")
                            .foregroundColor(.gray)
                    }
                }
                
                Spacer()
                
                HStack(spacing: 2){
                    Image(systemName: "text.bubble")
                        .resizable()
                        .frame(width: 30.0, height: 30.0)
                        .foregroundColor(AppColor.accent)
                        .padding()
                    
                    
                    
                    Image(systemName: "hand.thumbsup")
                        .resizable()
                        .frame(width: 30.0, height: 30.0)
                        .foregroundColor(AppColor.accent)
                        .padding()
                }
            }
            
            .font(.footnote)
        }
        .padding()
    }
}

#Preview {
    PostsView()
}
