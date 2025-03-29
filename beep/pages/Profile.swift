//
//  Profile.swift
//  beep
//
//  Created by cher1shRXD on 3/29/25.
//

import SwiftUI

struct Profile: View {
    var body: some View {
        VStack(alignment: .center, spacing: 32){
            VStack(spacing: 18){
                HStack{
                    Text("이름")
                        .font(.system(size: 16))
                        .foregroundColor(Color.black)
                    Spacer()
                    Text("김태우")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color.black)
                    
                }
                
                HStack{
                    Text("학번")
                        .font(.system(size: 16))
                        .foregroundColor(Color.black)
                    Spacer()
                    Text("2학년 2반 10번")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color.black)
                    
                }
                
                HStack{
                    Text("실")
                        .font(.system(size: 16))
                        .foregroundColor(Color.black)
                    Spacer()
                    Text("LAB 21, 22실")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color.black)
                    Button(action: {}) {
                        Image(systemName: "pencil")
                    }
                    .foregroundStyle(Color.dark)
                }
                
            }
            .padding(20)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.05), radius: 5)
            
            Button(action: {
                
            }){
                HStack(alignment: .center){
                    Text("로그아웃")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color.red)
                    Spacer()
                }
                .padding(20)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.05), radius: 5)
                
            }
            Spacer()
        }.padding(.top, 16)
    }
}

#Preview {
    Profile()
}
