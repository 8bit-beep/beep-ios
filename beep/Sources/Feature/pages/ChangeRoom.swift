//
//  ChangeRoom.swift
//  beep
//
//  Created by cher1shRXD on 4/2/25.
//

import SwiftUI
import Moya

struct ChangeRoom: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var toastManager: ToastManager
    
    var rooms = Room()
    @State private var selectedRoom: String = "변경할 실을 선택해주세요."
    
    let provider = MoyaProvider<Api>(session: Session(interceptor: ApiInterceptor()))
    
    var body: some View {
        VStack(spacing: 16){
            HStack(alignment: .center, spacing: 4){
                Button{
                    dismiss()
                } label: {
                    Image("ChevronLeft").resizable().frame(width: 20, height: 24)
                }
                Text("실 변경하기").fontWeight(.bold).font(.system(size: 20)).foregroundStyle(Color.dark)
                Spacer()
            }
            .padding(.top, 8)
            .padding(.bottom, 12)
            
            Spacer()
            
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
            
            Button {
                provider.request(.changeRoom(room: selectedRoom)) { result in
                    if(selectedRoom == "변경할 실을 선택해주세요.") {
                        dismiss()
                    }
                    switch result {
                    case .success:
                        toastManager.showToast(message: "실 변경 성공", detail: "\(rooms.parseRoomName(selectedRoom))로 변경되었습니다.")
                        dismiss()
                        break
                    case .failure:
                        toastManager.showToast(message: "실 변경 실패", detail: "네트워크 에러")
                        break
                    }
                }
            } label: {
                HStack(alignment: .center){
                    Text("변경하기")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color.white)
                }
                .padding(20)
                .frame(maxWidth: .infinity)
                .background(Color.dark)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.05), radius: 5)
            }
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
        .navigationBarBackButtonHidden()
        .overlay{
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
    ChangeRoom()
}
