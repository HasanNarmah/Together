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
        NavigationStack {
            GeometryReader { geometry in
                ScrollView {
                    VStack(spacing: 0) {
                        // Header Section
                        VStack(spacing: 20) {
                            Spacer(minLength: 60)
                            
                            // App Icon/Logo
                            Circle()
                                .fill(AppColor.accent.opacity(0.1))
                                .frame(width: 80, height: 80)
                                .overlay(
                                    Text("🤝")
                                        .font(.system(size: 40))
                                )
                                .padding(.bottom, 10)
                            
                            // App Title
                            Text("Together")
                                .font(.custom("Futura", size: 42))
                                .foregroundColor(AppColor.text)
                                .fontWeight(.bold)
                            
                            // Mission Statement
                            Text("Rebuilding connections, one conversation at a time")
                                .font(.subheadline)
                                .foregroundColor(AppColor.textSecondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 40)
                        }
                        .padding(.bottom, 50)
                        
                        // Form Section
                        VStack(spacing: 24) {
                            VStack(spacing: 16) {
                                TextField("Email", text: $email)
                                    .autocapitalization(.none)
                                    .keyboardType(.emailAddress)
                                    .modifier(TextFieldModifiers())
                                
                                SecureField("Password", text: $password)
                                    .modifier(TextFieldModifiers())
                            }
                            
                            // Forgot Password Link
                            HStack {
                                Spacer()
                                NavigationLink {
                                    Text("Forgot Password") // Placeholder for forgot password view
                                } label: {
                                    Text("Forgot Password?")
                                        .font(.footnote)
                                        .foregroundColor(AppColor.primary)
                                        .underline()
                                }
                                .padding(.trailing, 24)
                            }
                            
                            // Login Button
                            NavigationLink {
                                MainView()
                                    .navigationBarBackButtonHidden(true)
                            } label: {
                                Text("Sign In")
                                    .modifier(ButtonModifiers())
                            }
                            .disabled(email.isEmpty || password.isEmpty)
                        }
                        .padding(.bottom, 40)
                        
                        // Bottom Section
                        VStack(spacing: 16) {
                            // Divider with text
                            HStack {
                                Rectangle()
                                    .fill(AppColor.separator)
                                    .frame(height: 1)
                                
                                Text("New here?")
                                    .font(.footnote)
                                    .foregroundColor(AppColor.textSecondary)
                                    .padding(.horizontal, 16)
                                
                                Rectangle()
                                    .fill(AppColor.separator)
                                    .frame(height: 1)
                            }
                            .padding(.horizontal, 24)
                            
                            // Sign Up Link
                            NavigationLink {
                                AddNameView()
                                    .navigationBarBackButtonHidden(true)
                            } label: {
                                VStack(spacing: 8) {
                                    Text("Create Account")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(AppColor.accent)
                                    
                                    Text("Join our community of peace-builders")
                                        .font(.caption)
                                        .foregroundColor(AppColor.textSecondary)
                                        .multilineTextAlignment(.center)
                                }
                            }
                            .padding(.vertical, 20)
                        }
                        
                        Spacer(minLength: 30)
                    }
                    .frame(minHeight: geometry.size.height)
                }
            }
            .background(AppColor.background)
        }
    }
    }


        #Preview {
            LoginView()
        }
