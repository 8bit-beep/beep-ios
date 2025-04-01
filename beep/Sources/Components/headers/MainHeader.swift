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
            Image("Info").resizable().frame(width: 30, height: 30)
        }
    }
}

#Preview {
    MainHeader()
}
