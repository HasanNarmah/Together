//
//  ProfileView.swift
//  Together
//
//  Created by Hasan Narmah on 07/03/2024.
//

import SwiftUI

struct ProfileView: View {
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            //Communities and stats
            HStack(alignment: .top) {
                VStack (alignment: .leading, spacing: 12){
                    //full name and email 
                    VStack(alignment: .leading, spacing: 4){
                        Text("Jane Doe")
                            .modifier(TextFontModifiers())
                            .fontWeight(.semibold)
                        
                        Text("London, UK")
                            .font(.subheadline)
                    }
                    Text("Bio")
                        .font(.footnote)
                    
                    Text("2 Connections")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                Spacer()
                
                Circle()
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .trailing)
                    .padding()
            }
        }
    }
}
    
    #Preview {
        ProfileView()
    }

