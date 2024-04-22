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
                    SecureField("Password" , text: $password)
                }
                    
                    Button{
                        
                    }   label: {
                        Text("Register")
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
                        LoginView()
                    } label: {
                        HStack(spacing: 3){
                            Text("Have an account?")
                            
                            Text("Login")
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
    }


#Preview {
    RegistrationView()
}
