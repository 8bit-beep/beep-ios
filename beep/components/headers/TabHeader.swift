//
//  ProfileHeader.swift
//  beep
//
//  Created by cher1shRXD on 3/29/25.
//

import SwiftUI

struct TabHeader: View {
    var title: String
    
    var body: some View {
        HStack(alignment: .center){
            Text(title).fontWeight(.bold).font(.system(size: 30)).foregroundStyle(Color.dark)
            Spacer()
        }
    }
}

#Preview {
    TabHeader(title: "프로필")
}
