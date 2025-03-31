//
//  Home.swift
//  beep
//
//  Created by cher1shRXD on 3/29/25.
//

import SwiftUI

struct Home: View {
    @StateObject private var nfcReader = NFCManager()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(alignment: .center, spacing: 32){
                VStack{
                    HStack{
                        Text("출석체크")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(Color.dark)
                        Spacer()
                    }
                    
                    Image("Phone")
                        .padding(.bottom, 36)
                    
                    
                    Button (action: {
                        nfcReader.startScanning()
                    }) {
                        VStack{
                            Text("출석하기")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .padding(.vertical, 18)
                        .frame(maxWidth: .infinity)
                        .background(Color.serveColor)
                        .cornerRadius(10)
                        
                    }
                }
                .padding(20)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.05), radius: 5)
                
                VStack(spacing: 10){
                    HStack{
                        Text("출석 현황")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(Color.dark)
                        Spacer()
                    }
                    VStack(spacing: 4){
                        HStack{
                            Text("출석 현황 :")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color.black)
                            Text("X")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color.red)
                            Spacer()
                        }
                        HStack{
                            Text("출석 장소 :")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color.black)
                            Text("LAB 21, 227:06")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color.black)
                            Spacer()
                        }
                        HStack{
                            Text("출석 시간 :")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color.black)
                            Text("7:06")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color.black)
                            Spacer()
                        }
                    }
                    
                }
                .padding(20)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.05), radius: 5)
            }
            .padding(.top, 16)
            .padding(.bottom, 128)
        }
    }
}

#Preview {
    Home()
}
