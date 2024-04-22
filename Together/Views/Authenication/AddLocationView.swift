//
//  AddLocationView.swift
//  Together
//
//  Created by Hasan Narmah on 22/04/2024.
//

import SwiftUI

struct AddLocationView: View {
    @State private var location = ""
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(spacing: 12){
            Text("Where are you from?")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
            
            Text("Your location will be shared with other users and communities")
                .font(.footnote)
                .foregroundColor(AppColor.accent)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            TextField("Location", text: $location)
                .autocapitalization(.none)
                .modifier(TextFieldModifiers())
            
            NavigationLink{
                AddEmailView()
                    .navigationBarBackButtonHidden(true)
            } label: {
                Text("Next")
                .modifier(ButtonModifiers())
            }
            Spacer()
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading){
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .onTapGesture {
                        dismiss()
                    }
            }
        }
    }
}

#Preview {
    AddLocationView()
}
