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
        }
    }
}

#Preview {
    ProfileView()
}
