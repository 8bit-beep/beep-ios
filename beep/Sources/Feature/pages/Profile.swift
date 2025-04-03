//
//  Profile.swift
//  beep
//
//  Created by cher1shRXD on 3/29/25.
//

import SwiftUI

struct Profile: View {
    @EnvironmentObject var viewModel: UserViewModel
    @EnvironmentObject private var toastManager: ToastManager
    @State private var modalView: Bool = true;
    let room = Room()
    
    var body: some View {
        VStack(alignment: .center, spacing: 32){
            VStack(spacing: 18){
                HStack{
                    Text("이름")
                        .font(.system(size: 16))
                        .foregroundColor(Color.black)
                    Spacer()
                    if let username = viewModel.userData?.data.username {
                        Text(username)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color.black)
                    } else {
                        Text("--")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color.black)
                    }
                    
                }
                
                HStack{
                    Text("학번")
                        .font(.system(size: 16))
                        .foregroundColor(Color.black)
                    Spacer()
                    if let grade = viewModel.userData?.data.grade,
                       let cls = viewModel.userData?.data.cls,
                       let num = viewModel.userData?.data.num {
                        Text("\(grade)학년 \(cls)반 \(num)번")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color.black)
                    } else {
                        Text("--")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color.black)
                    }
                    
                }
                
                HStack{
                    Text("실")
                        .font(.system(size: 16))
                        .foregroundColor(Color.black)
                    Spacer()
                    if let fixedRoomName = viewModel.userData?.data.fixedRoom?.name {
                        Text(room.parseRoomName(fixedRoomName))
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color.black)
                    } else {
                        Text("--")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color.black)
                    }
                    NavigationLink {
                        ChangeRoom()
                            .environmentObject(toastManager)
                    } label: {
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
            
            Button{
                UserDefaults.standard.removeObject(forKey: "accessToken")
                UserDefaults.standard.removeObject(forKey: "refreshToken")
            } label: {
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
        }
        .padding(.top, 16)
        .onAppear {
            viewModel.fetchUserData()
        }
    }
}

#Preview {
    Profile()
}
