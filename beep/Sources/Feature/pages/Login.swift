//
//  Login.swift
//  beep
//
//  Created by cher1shRXD on 4/1/25.
//

import SwiftUI
import Moya

struct Login: View {
    @State var dauthId: String = ""
    @State var dauthPw: String = ""
    @AppStorage("accessToken") var accessTokenStore: String?
    @AppStorage("refreshToken") var refreshTokenStore: String?
    let provider = MoyaProvider<Api>()
    @EnvironmentObject private var toastManager: ToastManager
    
    var body: some View {
        VStack(alignment: .center, spacing: 40){
            Spacer()
            Image("Logo")
                .resizable()
                .frame(width: 80, height: 80)
            
            VStack(alignment: .leading, spacing: 16){
                HStack(alignment: .center, spacing: 0){
                    Text("도담도담")
                        .font(.system(size: 20))
                        .foregroundStyle(Color(hex: "0083F0"))
                    Text("으로 로그인")
                        .font(.system(size: 20))
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                
                TextField("도담도담 아이디", text: $dauthId)
                    .padding(16)
                    .background(.white)
                    .cornerRadius(20)
                    .shadow(color: Color(hex: "F0F0F0"), radius: 8)
                
                SecureField("도담도담 비밀번호", text: $dauthPw)
                    .padding(16)
                    .background(.white)
                    .cornerRadius(16)
                    .shadow(color: Color(hex: "F0F0F0"), radius: 8)
                
            }
            
            Button {
                provider.request(.login(dauthId: dauthId, dauthPw: dauthPw)) { result in
                    switch result {
                    case .success(let response):
                        do {
                            if let json = try response.mapJSON() as? [String: Any],
                               let data = json["data"] as? [String: Any],
                               let location = data["location"] as? String {
                                print("📍 Location URL: \(location)")
                                
                                let codeSubstring = location.components(separatedBy: "code=")[1].split(separator: "&")[0]
                                let code = String(codeSubstring)
                                
                                print(code)
                                provider.request(.getToken(code: code)) { tokenResult in
                                    switch tokenResult {
                                    case .success(let tokenResponse):
                                        do {
                                            if let tokenData = try tokenResponse.mapJSON() as? [String: Any],
                                               let accessToken = tokenData["accessToken"] as? String,
                                               let refreshToken = tokenData["refreshToken"] as? String{
                                                accessTokenStore = accessToken
                                                refreshTokenStore = refreshToken
                                                print("✅ 토큰 저장 성공")
                                            } else {
                                                toastManager.showToast(message: "네트워크 에러", type: .error)
                                            }
                                        } catch(let error){
                                            print("❌ 요청 실패: \(error.localizedDescription)")
                                            toastManager.showToast(message: "네트워크 에러", type: .error)
                                        }
                                    case .failure(let error):
                                        print("❌ 토큰 요청 실패: \(error.localizedDescription)")
                                        toastManager.showToast(message: "네트워크 에러", type: .error)
                                    }
                                }
                                toastManager.showToast(message: "로그인 성공")
                            } else {
                                print("❌ 'location' 값을 찾을 수 없음")
                                toastManager.showToast(message: "로그인 실패", type: .error, detail: "아이디, 비밀번호를 확인해주세요.")
                            }
                        } catch {
                            print("❌ JSON 파싱 오류: \(error.localizedDescription)")
                            toastManager.showToast(message: "파싱 에러", type: .error)
                        }
                        
                    case .failure(let error):
                        print("❌ 요청 실패: \(error.localizedDescription)")
                        toastManager.showToast(message: "네트워크 에러", type: .error)
                    }
                }
            } label: {
                HStack(alignment: .center){
                    Text("로그인하기")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color.white)
                    
                    
                }
                .padding(16)
                .frame(maxWidth: .infinity)
                .background(Color(hex: "0083F0"))
                .cornerRadius(20)
                .shadow(color: .black.opacity(0.05), radius: 5)
            }
            Spacer()
            Spacer()
            
        }
        .padding(16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
        .navigationBarBackButtonHidden(true)
    }
    
}

#Preview {
    Login()
}
