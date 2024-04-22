//
//  AddPasswordView.swift
//  Together
//
//  Created by Hasan Narmah on 22/04/2024.
//

import SwiftUI

struct CreatePasswordView: View {
    @State private var password = ""
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(spacing: 12){
            Text("Create a password")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
            
            Text("Your password must be at least 6 charaters in length")
                .font(.footnote)
                .foregroundColor(AppColor.accent)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            Text("You'll use this to sign into your account")
                .font(.footnote)
                .foregroundColor(AppColor.accent)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            
            TextField("Password", text: $password)
                .autocapitalization(.none)
                .modifier(TextFieldModifiers())
            
            Button{
                print("move to password")
            }   label: {
                Text("Next")
                    .modifier(ButtonModifiers())
            }
            Spacer()
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading){
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .onTapGesture {
                        dismiss()
                    }
            }
        }
    }
}

#Preview {
    CreatePasswordView()
}
