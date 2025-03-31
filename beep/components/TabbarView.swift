//
//  TabbarView.swift
//  beep
//
//  Created by cher1shRXD on 3/29/25.
//

import SwiftUI

struct TabbarView: View {
    @State var currentTab: Tab = .home
    
    var body: some View {
        ZStack {
            VStack(spacing: 0){
                switch currentTab {
                case .home:
                    VStack{
                        MainHeader()
                        Home()
                    }
                case .shift:
                    VStack{
                        TabHeader(title: "실이동")
                        Shift()
                    }
                case .profile:
                    VStack{
                        TabHeader(title: "프로필")
                        Profile()
                    }
                }
            }
            .padding(.horizontal, 16)
            VStack(spacing: 0){
                Spacer()
                Tabbar(currentTab: $currentTab)
            }
        }
        .background(Color.background)
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    TabbarView()
}
