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
            .foregroundColor(AppColor.text)
            .padding(12)
            .background(AppColor.background)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(AppColor.separator, lineWidth: 1)
            )
            .cornerRadius(10)
            .padding(.horizontal, 24)
    }
}
