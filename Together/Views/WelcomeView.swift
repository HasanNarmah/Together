//
//  ContentView.swift
//  Together
//
//  Created by Hasan Narmah on 07/03/2024.
//

import SwiftUI

struct WelcomeView: View {
    
    @State private var showLogin = false
    
    var body: some View {
        ZStack{
            AppColor.background.ignoresSafeArea()
            VStack {
                Text("Together 🌍")
                    .font(.custom("Futura", size: 36))
                    .foregroundColor(AppColor.text)
                    .fontWeight(.bold)
                    .padding()
                
                Spacer()
                Text("👋")
                    .font(.title)
                Text("Welcome")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(AppColor.text)
                
                Text("Together is a tool for those who are caught in a conflict.")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
                
                Button(action: {
                    self.showLogin = true
                }) {
                    Text("Get Started")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(AppColor.accent)
                        .cornerRadius(10)
                    
                }
                .sheet(isPresented: $showLogin) {
                    LoginView()
                }
            }
        }
    }
}

#Preview {
    WelcomeView()
}
