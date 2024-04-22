//
//  SearchListView.swift
//  Together
//
//  Created by Hasan Narmah on 22/04/2024.
//

import SwiftUI

struct SearchListView: View {
    var body: some View {
        HStack{
            Circle()
                .frame(height: 50)
                .foregroundColor(AppColor.background)
            
            VStack(alignment: .leading){
                Text("Jane Doe")
                    .fontWeight(.bold)
                      .font(.custom("Futura", size: 20))
                      .foregroundColor(AppColor.accent)
                      .padding(.leading)
                
                Text("London, UK")
                    .foregroundColor(.gray)
                    .padding(.leading)
                    .font(.footnote)
            }
            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    SearchListView()
}
