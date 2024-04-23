//
//  TextFontModifiers.swift
//  Together
//
//  Created by Hasan Narmah on 23/04/2024.
//

import SwiftUI

struct TextFontModifiers: ViewModifier {
    func body(content: Content) -> some View{
        content
            .font(.custom("Futura", size: 30))
            .foregroundColor(AppColor.text)
    }
}
