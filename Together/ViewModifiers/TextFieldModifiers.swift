//
//  TextFieldModifiers.swift
//  Together
//
//  Created by Hasan Narmah on 22/04/2024.
//


import SwiftUI

struct TextFieldModifiers: ViewModifier {
    func body(content: Content) -> some View{
        content
            .font(.subheadline)
            .padding(12)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal, 24)
    }
}
