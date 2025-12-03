//
//  ButtonModifiers.swift
//  Together
//
//  Created by Hasan Narmah on 22/04/2024.
//

import SwiftUI

struct ButtonModifiers: ViewModifier {
    func body(content: Content) -> some View{
        content
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .frame(width: 352, height: 44)
            .background(AppColor.primary)
            .cornerRadius(8)
            .padding()
    }
}

