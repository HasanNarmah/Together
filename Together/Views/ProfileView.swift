//
//  ProfileView.swift
//  Together
//
//  Created by Hasan Narmah on 07/03/2024.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack{
            Text("Hasan Narmah")
                .font(.custom("Futura", size: 36))
                .foregroundColor(AppColor.text)
                .fontWeight(.bold)
                .padding()
            
            Spacer()
            
            
            Circle()
                .frame(height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .position(CGPoint(x: 200.0, y: 100.0))
            
            Spacer()
            
            
            Rectangle()
                .frame(height: 400)
        }
        
    }
}

#Preview {
    ProfileView()
}
