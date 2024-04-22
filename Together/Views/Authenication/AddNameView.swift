//
//  AddNameView.swift
//  Together
//
//  Created by Hasan Narmah on 22/04/2024.
//

import SwiftUI

struct AddNameView: View {
    @State private var name = ""
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(spacing: 12){
            Text("What's you name?")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
            
            Text("This will be displayed to other users")
                .font(.footnote)
                .foregroundColor(AppColor.accent)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            TextField("Name", text: $name)
                .autocapitalization(.none)
                .modifier(TextFieldModifiers())
            
            
            NavigationLink{
                AddLocationView()
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
    AddNameView()
}
