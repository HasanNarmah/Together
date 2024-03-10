//
//  RegistrationView.swift
//  Together
//
//  Created by Hasan Narmah on 07/03/2024.
//

import SwiftUI

struct RegistrationView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var showLogin = false
        
    var body: some View {

        NavigationView {
            VStack {
                Text("Together 🌍")
                    .font(.custom("Futura", size: 36))
                    .foregroundColor(AppColor.text)
                    .fontWeight(.bold)
                    .padding()
                
                Spacer()
                
                Text("Registration")
                    .font(.custom("Futura", size: 36))
                    .padding()
                
                TextField("Name", text: $name)
                    .multilineTextAlignment(.center)
                    .padding()
                    
                
                TextField("Email", text: $email)
                    .multilineTextAlignment(.center)
                    .padding()
                    .autocapitalization(.none)
                
                SecureField("Password", text: $password)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
                
                Button(action: {
                    // Action for registration button
                }) {
                    Text("Register")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(AppColor.accent)
                        .cornerRadius(10)
                }
                .padding()
                
                Button(action: {
                    self.showLogin = true
                }) {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(AppColor.accent)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.clear)
                        .cornerRadius(10)
                    
                }
                .sheet(isPresented: $showLogin) {
                    LoginView()
                }
                .padding()
                
                Spacer()
            }
            .padding()
        }
        }
    }


#Preview {
    RegistrationView()
}
