//
//  CompleteSignUpView.swift
//  Together
//
//  Created by Hasan Narmah on 22/04/2024.
//

import SwiftUI

struct CompleteSignUpView: View {
    @State private var password = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        let name = "Together"
        
        
        VStack(spacing: 12){
            Text("Welcome to Together, Jane Doe")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
            
            
            
            Text("Click below to complete registration and start connecting ")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
                .padding()
            
            Text("Empowering Connections, Rebuilding Lives Together")
                .font(.footnote)
                .foregroundColor(AppColor.accent)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            
            Button{
                print("move to mainview")
            }   label: {
                Text("Complete sign up")
                    .modifier(ButtonModifiers())
            }
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
    CompleteSignUpView()
}
