//
//  ContentView.swift
//  Together
//
//  Created by Hasan Narmah on 07/03/2024.
//

import SwiftUI

struct WelcomeView: View {
    
    var body: some View {
        ZStack{
            VStack {
                Text("Together 🌍")
                    .font(.custom("Futura", size: 46))
                    .foregroundColor(AppColor.text)
                    .fontWeight(.bold)
                    .padding(50)
                
                Spacer()
                Text("👋")
                    .font(.title)
                Text("Welcome")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(AppColor.text)
                
                Text("Empowering Connections, Rebuilding Lives Together")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(30)
                
                Spacer()
                
                NavigationLink{
                    LoginView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    Text("Next")
                    .modifier(ButtonModifiers())
                }
                }
            }
        
        }
    }


#Preview {
    WelcomeView()
}
