//
//  ProfileInfoView.swift
//  Together
//
//  Created by Hasan Narmah on 10/03/2024.
//

import SwiftUI

struct ProfileInfoView: View {
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack{
                HStack(spacing: 6) {
                    //placeholder image
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                }
                
                
                VStack(alignment: .center, spacing: 6){
                    Text("Hasan Narmah")
                        .padding(.top)
                        .font(.custom("Futura", size: 26))
                        .fontWeight(.semibold)
                        .foregroundColor(AppColor.accent)
                    
                    
                    Text("User email")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(3)
                    
                }
            }
            
            
            Text("Posts")
                .font(.custom("Futura", size: 25))
                .foregroundColor(AppColor.accent)
                .padding(.top)
                .fontWeight(.semibold)
                .foregroundColor(.brown)
                .padding(.vertical, 15)
            
        }
        .padding(15)
        
        HStack{
            PostsView()
        }
    }
}


#Preview {
    ProfileInfoView()
}
