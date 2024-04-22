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
        @State private var showMainView = false
            
        
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
                Text("Together 🌍")
                .font(.custom("Futura", size: 36))
                .foregroundColor(AppColor.text)
                .fontWeight(.bold)
                .padding(50)
                
            VStack {
                TextField("Email", text: $email)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 24)
                
                SecureField("Password" , text: $password)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 24)
            }
                    
                NavigationLink{
                    Text("Forgot Password")
                } label: {
                    Text("Forgot Password?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.top)
                        .padding(.trailing, 28)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                
                .padding(10)
                
                Button{
                    
                }   label: {
                    Text("Login")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 352, height: 44)
                        .background(.blue)
                        .cornerRadius(8)
                }
                Spacer()
                
                Divider()
                
                NavigationLink{
                    RegistrationView()
                } label: {
                    HStack(spacing: 3){
                        Text("Don't have an account?")
                        
                        Text("Sign Up")
                            .fontWeight(.semibold)
                    }
                    .font(.footnote)
                    .foregroundColor(.black)
                }
                .padding(.vertical, 16)
                }
            }
        }
    }


        #Preview {
            LoginView()
        }
