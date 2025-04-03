//
//  Splash.swift
//  beep
//
//  Created by cher1shRXD on 4/3/25.
//

import SwiftUI

struct Splash: View {
    var body: some View {
        VStack(alignment: .center, spacing: 16){
            Spacer()
            Image("LogoWhite")
                .resizable()
                .frame(width: 120, height: 120)
                
            Text("인원체크를 간편하게")
                .font(.system(size: 24, weight: .light))
            Spacer()
        }
        .padding(16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.dark)
        .foregroundStyle(.white)
    }
}

#Preview {
    Splash()
}
