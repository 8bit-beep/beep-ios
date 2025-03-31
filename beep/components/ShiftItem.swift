//
//  ShiftItem.swift
//  beep
//
//  Created by cher1shRXD on 3/31/25.
//

import SwiftUI

struct ShiftItem: View {
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 4){
                Text("LAB 21, 22실 -> LAB 2실")
                    .font(.system(size: 20, weight: .semibold))
                Text("10교시 - 11교시")
                    .font(.system(size: 15, weight: .medium))
                Text("안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요")
                    .font(.system(size: 12, weight: .light))
            }
            Spacer()
            Button {
                
            } label: {
                Image("X").resizable().frame(width: 16, height: 16)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .background(Color(hex: "FBFBFB"))
        .cornerRadius(20)
    }
}

#Preview {
    ShiftItem()
}
