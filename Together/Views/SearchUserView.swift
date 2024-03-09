//
//  SearchUserView.swift
//  Together
//
//  Created by Hasan Narmah on 09/03/2024.
//

import SwiftUI

import SwiftUI

struct SearchUserView: View {
    @State private var searchText = ""
    
    var body: some View {
        
        VStack {
            Text("Search 🔍")
                .font(.custom("Futura", size: 36))
                .foregroundColor(AppColor.text)
                .fontWeight(.bold)
                .padding()
        
            SearchBar(text: $searchText)
                .padding(.horizontal)
            
            List {
                ForEach(1..<10) { index in
                    Text("Item \(index)")
                }
            }
        }
        .navigationBarTitle("Search")
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchUserView()
    }
}

struct SearchBar: View {
    @Binding var text: String
    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding()
            
            Button(action: {
                self.text = ""
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
                    .padding(8)
            }
            .padding(.trailing, 8)
            .opacity(text.isEmpty ? 0 : 1)
        }
    }
}


#Preview {
    SearchUserView()
}
