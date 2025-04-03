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
    @State private var isLaunch: Bool = true
    
    var body: some View {
        
        if isLaunch {
            Splash()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        withAnimation(.linear) {
                            self.isLaunch = false
                        }
                    }
                }
        } else {
            NavigationView {
                if accessToken != nil {
                    TabbarView()
                        .environmentObject(toastManager)
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
}

#Preview {
    ContentView()
}
