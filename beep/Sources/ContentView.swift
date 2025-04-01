//
//  ContentView.swift
//  beep
//
//  Created by cher1shRXD on 3/29/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var toastManager = ToastManager()
    @AppStorage("accessToken") var accessToken: String?
    @AppStorage("refreshToken") var refreshToken: String?
    
    var body: some View {
        NavigationView {
            if accessToken != nil {
                TabbarView()
            } else {
                OnBoarding()
                    .environmentObject(toastManager)
            }
            
        }.overlay{
            VStack(alignment: .leading, spacing: 0){
                ToastContainer()
                    .environmentObject(toastManager)
                Spacer()
            }
            .padding(.top, 12)
        }
    }
}

#Preview {
    ContentView()
}
