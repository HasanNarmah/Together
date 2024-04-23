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
            ScrollView(showsIndicators: false){
                LazyVStack{
                    ForEach(0...10, id: \.self) { post in
                        PostCell()
                    }
                }
            }
            
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                   Text("Together 🌍")
                        .modifier(TextFontModifiers())
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

