//
//  Shift.swift
//  beep
//
//  Created by cher1shRXD on 3/31/25.
//

import SwiftUI
import Shimmer

struct Shift: View {
    @StateObject private var viewModel = ShiftViewModel()
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var toastManager: ToastManager
    @State var isUpdated: Bool = false
    @State private var isAnimating = false
    
    var body: some View {
        VStack(spacing: 0){
            VStack(spacing: 0){
                HStack{
                    Text("실 이동 신청 목록")
                        .font(.system(size: 25, weight: .bold))
                        .foregroundColor(Color.dark)
                    Spacer()
                    Button {
                        viewModel.fetchShiftData()
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.5)) {
                            isAnimating.toggle()
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.5)) {
                                isAnimating.toggle()
                            }
                        }
                    } label: {
                        Image("Refresh")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .rotationEffect(.degrees(isAnimating ? 360 : 0))
                            .scaleEffect(isAnimating ? 0.8 : 1.0)
                    }
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                ScrollView(.vertical, showsIndicators: false){
                    VStack(spacing: 16){
                        if let data = viewModel.shiftData {
                            if(data.isEmpty) {
                                Text("실 이동 신청 기록이 없습니다.")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(Color.grey)
                            }
                            ForEach(data, id:\.id) { shiftData in
                                ShiftItem(shiftData: shiftData, isUpdated: $isUpdated)
                                    .environmentObject(toastManager)
                            }
                        } else {
                            HStack{
                                VStack(alignment: .leading, spacing: 4){
                                    Text("placeholder")
                                        .font(.system(size: 16, weight: .semibold))
                                    Text("placeholder")
                                        .font(.system(size: 14, weight: .medium))
                                    Text("placeholder")
                                        .font(.system(size: 12, weight: .light))
                                }
                                .redacted(reason: .placeholder)
                                .shimmering()
                                Spacer()
                            }
                            .padding(16)
                            .frame(maxWidth: .infinity)
                            .background(Color(hex: "FBFBFB"))
                            .cornerRadius(20)
                            .shadow(color: Color(hex: "FBFBFB"), radius: 5)
                            
                            HStack{
                                VStack(alignment: .leading, spacing: 4){
                                    Text("placeholder")
                                        .font(.system(size: 16, weight: .semibold))
                                    Text("placeholder")
                                        .font(.system(size: 14, weight: .medium))
                                    Text("placeholder")
                                        .font(.system(size: 12, weight: .light))
                                }
                                .redacted(reason: .placeholder)
                                .shimmering()
                                Spacer()
                                Button {
                                    
                                } label: {
                                    Image("X").resizable().frame(width: 16, height: 16)
                                }
                                .redacted(reason: .placeholder)
                                .shimmering()
                            }
                            .padding(16)
                            .frame(maxWidth: .infinity)
                            .background(Color(hex: "FBFBFB"))
                            .cornerRadius(20)
                            .shadow(color: Color(hex: "FBFBFB"), radius: 5)
                        }
                    }
                    .padding(.top, 12)
                    .padding(.bottom, 16)
                }
                .padding(.horizontal, 12)
                .foregroundStyle(.black)
                .refreshable {
                    viewModel.fetchShiftData()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.55)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.05), radius: 5)
            
            Spacer()
            
            Button {
                toastManager.showToast(message: "실을 설정해야합니다.", type: .error)
            } label: {
                NavigationLink {
                    RegisterShift()
                        .environmentObject(toastManager)
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
                .disabled(userViewModel.userData?.data.fixedRoom == nil)
            }
        }
        .padding(.bottom, 106)
        .onAppear{
            viewModel.fetchShiftData()
        }
        .onChange(of: isUpdated) { _ in
            if isUpdated {
                viewModel.fetchShiftData()
                isUpdated.toggle()
            }
            
        }
    }
}

#Preview {
    Shift()
}
