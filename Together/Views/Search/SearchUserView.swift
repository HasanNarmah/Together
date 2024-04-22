//
//  SearchUserView.swift
//  Together
//
//  Created by Hasan Narmah on 09/03/2024.
//

import SwiftUI

struct SearchUserView: View {
    @State private var searchText = ""
    var body: some View {
        NavigationStack {
            ScrollView{
                LazyVStack(spacing: 12){
                    ForEach(0...15, id: \.self) { user in
                        SearchListView()
                    }
                }
                .padding(.top , 8)
                .searchable(text: $searchText, prompt: "Search")
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}




#Preview {
SearchUserView()
}
