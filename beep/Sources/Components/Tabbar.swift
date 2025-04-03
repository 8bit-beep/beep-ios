//
//  Tabbar.swift
//  beep
//
//  Created by cher1shRXD on 3/29/25.
//

import SwiftUI

enum Tab {
    case home
    case shift
    case profile
}

struct Tabbar: View {
    @Binding var currentTab: Tab;
    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
                .opacity(0.2)
            HStack(alignment: .center) {
                Spacer()
                
                Button {
                    currentTab = .shift
                } label: {
                    VStack(alignment: .center, spacing: 4) {
                        Image(systemName: "rectangle.2.swap")
                            .font(.system(size: 16, weight: .bold))
                        Text("실 이동")
                            .font(.caption)
                    }
                }
                .foregroundStyle(currentTab == .shift ? Color.main : Color.dark)
                .disabled(currentTab == .shift)
                
                Spacer()
                
                Button {
                    currentTab = .home
                } label: {
                    VStack(alignment: .center, spacing: 4) {
                        Image(systemName: "house")
                            .font(.system(size: 18, weight: .bold))
                        Text("홈")
                            .font(.caption)
                    }
                }
                .foregroundStyle(currentTab == .home ? Color.main : Color.dark)
                .disabled(currentTab == .home)
                
                Spacer()
                
                Button {
                    currentTab = .profile
                } label: {
                    VStack(alignment: .center, spacing: 4) {
                        Image(systemName: "person")
                            .font(.system(size: 20, weight: .bold))
                        Text("프로필")
                            .font(.caption)
                    }
                }
                .foregroundStyle(currentTab == .profile ? Color.main : Color.dark)
                .disabled(currentTab == .profile)
                
                Spacer()
                
            }
            .frame(width: UIScreen.main.bounds.width, height: 72)
            .padding(.bottom, 16)
            .background(Color.white)
        }
    }
    
}

#Preview {
    Tabbar(currentTab: .constant(Tab.home))
}
