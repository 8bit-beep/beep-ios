//
//  RegisterShift.swift
//  beep
//
//  Created by cher1shRXD on 3/31/25.
//

import SwiftUI

struct RegisterShift: View {
    @Environment(\.dismiss) var dismiss
    
    @State var reason: String = ""
    @State private var isPresented: Bool = false
    
    var rooms = Room()
    @State private var selectedRoom: String = "이동할 실을 선택해주세요."
    
    var periods: [Int] = [8,9,10,11]
    @State private var selectedStartPeriod: Int = 8
    @State private var selectedEndPeriod: Int = 11
    
    var body: some View {
        VStack(spacing: 0){
            HStack(alignment: .center, spacing: 4){
                Button{
                    dismiss()
                } label: {
                    Image("ChevronLeft").resizable().frame(width: 20, height: 24)
                }
                Text("실 이동 신청하기").fontWeight(.bold).font(.system(size: 20)).foregroundStyle(Color.dark)
                Spacer()
            }
            .padding(.bottom, 12)
            ScrollView(.vertical, showsIndicators: false){
                Spacer(minLength: 24)
                VStack(alignment: .leading ,spacing: 32) {
                    HStack{
                        Text("실 이동 신청하기")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(Color.dark)
                        Spacer()
                    }
                    
                    VStack(alignment: .leading){
                        Text("이동 사유")
                            .font(.bold(16))
                        ZStack(alignment: .topLeading){
                            TextEditor(text: $reason)
                                .frame(height: 120)
                                .font(.system(size: 14))
                                .padding(4)
                                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.grey, lineWidth: 0.5))
                                .hideKeyBoard()
                            if reason.isEmpty {
                                Text("이동 사유를 입력해주세요.")
                                    .padding(.top, 12)
                                    .padding(.horizontal, 8)
                                    .foregroundColor(.grey)
                                    .font(.system(size: 14))
                                
                            }
                        }
                        
                    }
                    
                    VStack(alignment: .leading) {
                        Text("이동 실")
                            .font(.system(size: 16, weight: .semibold))
                        
                        Menu {
                            ForEach(rooms.roomList, id: \.id) { room in
                                Button {
                                    selectedRoom = room.name
                                } label: {
                                    Text(rooms.parseRoomName(room.name))
                                }
                            }
                        } label: {
                            HStack {
                                Text(rooms.parseRoomName(selectedRoom))
                                    .foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.5))
                            )
                        }
                        
                    }
                    
                    VStack(alignment: .leading) {
                        Text("이동 교시")
                            .font(.system(size: 16, weight: .semibold))
                        
                        HStack(spacing: 16){
                            Menu {
                                ForEach(periods, id: \.self) { period in
                                    Button {
                                        selectedStartPeriod = period
                                        if selectedStartPeriod > selectedEndPeriod {
                                            selectedEndPeriod = period
                                        }
                                    } label: {
                                        Text("\(period)교시")
                                    }
                                }
                            } label: {
                                HStack {
                                    Text("\(selectedStartPeriod)교시")
                                        .foregroundColor(.primary)
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.5))
                                )
                            }
                            
                            Text("~")
                            
                            Menu {
                                ForEach(periods, id: \.self) { period in
                                    if period >= selectedStartPeriod {
                                        Button {
                                            selectedEndPeriod = period
                                        } label: {
                                            Text("\(period)교시")
                                        }
                                    }
                                    
                                }
                            } label: {
                                HStack {
                                    Text("\(selectedEndPeriod)교시")
                                        .foregroundColor(.primary)
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.5))
                                )
                            }
                        }
                        
                        
                    }
                }
                .padding(20)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.05), radius: 5)
                
                Spacer(minLength: 106)
                
            }
            .overlay {
                VStack {
                    Spacer()
                    NavigationLink {
                        RegisterShift()
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
            }
        }
        .padding(.horizontal, 16)
        .background(Color.background)
        .navigationBarBackButtonHidden()
    }
    
    
}

#Preview {
    RegisterShift()
}
