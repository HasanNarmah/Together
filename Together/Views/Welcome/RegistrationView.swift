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
    @Environment(\.dismiss) var dismiss
        
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
                    
                    TextField("Name", text: $name)
                        .modifier(TextFieldModifiers())
                    
                    TextField("Email", text: $email)
                        .modifier(TextFieldModifiers())
                    
                    SecureField("Password" , text: $password)
                        .modifier(TextFieldModifiers())
                }
                    
                    Button{
                       
                    }   label: {
                        Text("Sign Up")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 352, height: 44)
                            .background(.blue)
                            .cornerRadius(8)
                            .padding()
                    }
                    Spacer()
                    
                    Divider()
                    
                    Button{
                        dismiss()
                    } label: {
                        HStack(spacing: 3){
                            Text("Already have an account?")
                            Text("Login")
                                .fontWeight(.semibold)
                        }
                        .font(.footnote)
                    }
                    .padding(.vertical, 16)
                    }
                }
            }
        }
    


#Preview {
    RegistrationView()
}
