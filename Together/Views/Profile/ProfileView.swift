//
//  ProfileView.swift
//  Together
//
//  Created by Hasan Narmah on 07/03/2024.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var selectedFilter: ProfileFilter = .posts
    @Namespace var animation
    
    //for future ref to add on more filters to profile page
    private var filterBarWidth: CGFloat{
        let count = CGFloat(ProfileFilter.allCases.count)
        return UIScreen.main.bounds.width / count - 20
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            //Communities and stats
            VStack(spacing: 20) {
                HStack(alignment: .top) {
                    VStack (alignment: .leading, spacing: 12){
                        //full name and email
                        VStack(alignment: .leading, spacing: 4){
                            Text("Jane Doe")
                                .modifier(TextFontModifiers())
                                .fontWeight(.semibold)
                            
                            Text("London, UK")
                                .font(.subheadline)
                        }
                        
                        Text("2 Connections")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    Spacer()
                    
                    Circle()
                        .frame(width: 100, height: 100, alignment: .trailing)
                        .padding()
                }
                Button{
                    
                }label: {
                    Text("Connect")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 352, height: 32)
                        .background(AppColor.accent)
                        .cornerRadius(8)
                    
                }
                // user content list view
                VStack{
                    HStack{
                        ForEach(ProfileFilter.allCases){ filter in
                            VStack{
                                Text(filter.title)
                                    .font(.subheadline)
                                    .fontWeight(selectedFilter == filter ? .semibold : .regular)
                                
                                if selectedFilter == filter {
                                    Rectangle()
                                        .foregroundColor(AppColor.accent)
                                        .frame(width: filterBarWidth, height: 1)
                                        .matchedGeometryEffect(id: "item", in: animation)
                                }else {
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .frame(width: filterBarWidth, height: 1)
                                }
                            }
                            .onTapGesture {
                                withAnimation(.spring()){
                                    selectedFilter = filter
                                }
                            }

                        }
                    }
                    
                    LazyVStack{
                        ForEach(0...13, id: \.self) { thread in
                          PostCell()
                        }
                    }
                }
                .padding(.vertical, 8)
            }
        }
        .padding(.horizontal)
    }
}
    
    #Preview {
        ProfileView()
    }

