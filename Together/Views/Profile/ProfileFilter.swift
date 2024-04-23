//
//  ProfileFilter.swift
//  Together
//
//  Created by Hasan Narmah on 23/04/2024.
//

import Foundation

enum ProfileFilter: Int, CaseIterable, Identifiable{
    case posts
    case replies
    
    var title: String {
        switch self{
        case .posts: return "Posts"
        case .replies: return "Replies"
        }
    }
    var id: Int {return self.rawValue}
}
