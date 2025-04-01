//
//  OnBoarding.swift
//  beep
//
//  Created by cher1shRXD on 4/1/25.
//

import SwiftUI

struct OnBoarding: View {
    @EnvironmentObject private var toastManager: ToastManager
    
    var body: some View {
        VStack(alignment: .center){
            Spacer()
            Image("LogoWhite")
                .resizable()
                .frame(width: 120, height: 120)
                
            Text("인원체크를 간편하게")
                .font(.system(size: 24, weight: .light))
            Spacer()
            NavigationLink {
                Login()
                    .environmentObject(toastManager)
            } label: {
                HStack(alignment: .center){
                    Text("도담도담으로 로그인하기")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color.white)
                    
                    Text(":D")
                        .font(.system(size: 32, weight: .heavy))
                        .foregroundColor(Color.white)
                }
                .padding(12)
                .frame(maxWidth: .infinity)
                .background(Color(hex: "0083F0"))
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.05), radius: 5)
            }
            
        }
        .padding(16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.dark)
        .foregroundStyle(.white)
    }
}

#Preview {
    OnBoarding()
}
