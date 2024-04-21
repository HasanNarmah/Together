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
            
            ZStack {
                //AppColor.background.ignoresSafeArea()
                ScrollView{
                    LazyVStack (spacing: 32){
                        ForEach(0...10, id:\.self){ listing in
                            PostsView()
                                .frame(height: 400)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                }
            }
            .navigationBarTitle("Together")
            .font(.custom("Futura", size: 40))
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
}

#Preview {
    FeedView()
}
