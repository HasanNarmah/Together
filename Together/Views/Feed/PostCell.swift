//
//  PostView.swift
//  Together
//
//  Created by Hasan Narmah on 08/03/2024.
//

import SwiftUI

struct PostCell: View {
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
                
                HStack(spacing: 16){
                    Button{
                        
                    }label: {
                        Image(systemName: "bubble.right")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                    
                    Button{
                        
                    }label: {
                        Image(systemName: "heart")
                        .resizable()
                        .frame(width: 20, height: 20)
                    }
                    
                    Button{
                        
                    }label: {
                        Image(systemName: "paperplane")
                        .resizable()
                        .frame(width: 20, height: 20)
                    }
                }
                .foregroundColor(AppColor.accent)
                .padding(.vertical, 8)
            }
            
            .font(.footnote)
        }
        .padding()
        Divider()
    }
    
}

#Preview {
    PostCell()
}
