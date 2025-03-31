//
//  Shift.swift
//  beep
//
//  Created by cher1shRXD on 3/31/25.
//

import SwiftUI

struct Shift: View {
    var body: some View {
        VStack{
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 0){
                    HStack{
                        Text("실 이동 신청 목록")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(Color.dark)
                        Spacer()
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                    ScrollView(.vertical, showsIndicators: false){
                        VStack(spacing: 16){
                            ShiftItem()
                            ShiftItem()
                            ShiftItem()
                            ShiftItem()
                            ShiftItem()
                            ShiftItem()
                            ShiftItem()
                            ShiftItem()
                        }
                        .padding(.top, 12)
                        .padding(.bottom, 16)
                    }
                    .padding(.horizontal, 12)
                    .foregroundStyle(.black)
                }
                .frame(width: UIScreen.main.bounds.width - 32, height: UIScreen.main.bounds.height * 0.55)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.05), radius: 5)
                .padding(.vertical, 16)
            }
            
        }
        .overlay {
            VStack {
                Spacer()
                Button {
                    
                } label: {
                    HStack(alignment: .center){
                        Text("신청하기")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color.white)
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(Color.dark)
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.05), radius: 5)
                }
            }
            .padding(.bottom, 106)
        }
    }
}

#Preview {
    Shift()
}
