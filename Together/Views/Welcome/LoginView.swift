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
                    .autocapitalization(.none)
                    .modifier(TextFieldModifiers())
                
                SecureField("Password" , text: $password)
                    .modifier(TextFieldModifiers())
            }
                    
                NavigationLink{
                    Text("Forgot Password")
                } label: {
                    Text("Forgot Password?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.vertical)
                        .padding(.trailing, 28)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
             
                Button{
                    
                }   label: {
                    Text("Login")
                        .modifier(ButtonModifiers())
                }
                Spacer()
                
                Divider()
                
                NavigationLink{
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
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
