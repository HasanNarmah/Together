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
                .frame(height: 320)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            //listing details
            HStack{
                VStack(alignment: .leading){
                  Text("Hasan Narmah")
                        .fontWeight(.semibold)
                    
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
                    Image(systemName: "bubble.circle.fill")
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
