//
//  MainHeader.swift
//  beep
//
//  Created by cher1shRXD on 3/29/25.
//

import SwiftUI

struct MainHeader: View {
    var body: some View {
        HStack(alignment: .center){
            Image("Logo").resizable().frame(width: 48, height: 43)
            Spacer()
            Link(destination: URL(string: "https://thunder-bream-d76.notion.site/1c62ee22c3f68069b14fe2da853a6ac3?pvs=4")!) {
                Image("Info")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            
        }
    }
}

#Preview {
    MainHeader()
}
