//
//  loginView.swift
//  Together
//
//  Created by Hasan Narmah on 07/03/2024.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var showRegistration = false
    
    var body: some View {
        
        VStack {
            Text("Together 🌍")
                .font(.custom("Futura", size: 36))
                .foregroundColor(AppColor.text)
                .fontWeight(.bold)
                .padding()
            
            Spacer()
            
            Text("Login")
                .foregroundColor(AppColor.text)
                .font(.title)
                .fontWeight(.bold)
                .padding()
                        
            TextField("Email", text: $email)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                        
            SecureField("Password", text: $password)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Spacer()
                        
            Button(action: {
                // Action for login button
            }) {
                Text("Login")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(AppColor.accent)
                    .cornerRadius(10)
            }
            .padding()
                        
            Button(action: {
                self.showRegistration = true
            }) {
                Text("Register")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(AppColor.accent)
                    .cornerRadius(10)
                                
            }
            .sheet(isPresented: $showRegistration) {
                RegistrationView()
            }
            .padding()
            Spacer()
        }
        .padding()
               }
           }
        


#Preview {
    LoginView()
}
