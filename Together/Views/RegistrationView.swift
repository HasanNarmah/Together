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
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                TextField("Name", text: $name)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Email", text: $email)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                
                SecureField("Password", text: $password)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
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
