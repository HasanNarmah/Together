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
        
        NavigationStack(){
            
            List{
                ForEach(0...10, id:\.self){ user in
                    NavigationLink {
                        //                   ReusableProfileContent(user: user)
                    } label: {
                        Text("username")
                            .font(.callout)
                        
                        
                    }
                }
            }
            
            

            .listStyle(.plain)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Search")
            .font(.custom("Futura", size: 36))
            .searchable(text: $searchText)
            .onSubmit(of: .search, {
                //fetching user from firebase
                //            Task{await searchUsers()}
            })
            
            
            .onChange(of: searchText, perform: { newValue in
                if newValue.isEmpty{
                    //                fetchedUsers = []
                }
            })

            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button("Cancel") {
                        
                    }
                    .tint(.red)
                }
            }
        }
    }
}



#Preview {
    SearchUserView()
}
