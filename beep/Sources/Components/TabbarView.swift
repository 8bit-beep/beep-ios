import SwiftUI

struct TabbarView: View {
    @State var currentTab: Tab = .home
    @StateObject private var toastManager = ToastManager()
    @StateObject private var viewModel = UserViewModel()
    
    var body: some View {
        ZStack {
            VStack(spacing: 0){
                Group {
                    switch currentTab {
                    case .home:
                        VStack{
                            MainHeader()
                            Home()
                        }
                    case .shift:
                        VStack{
                            TabHeader(title: "실 이동")
                            Shift()
                        }
                    case .profile:
                        VStack{
                            TabHeader(title: "프로필")
                            Profile()
                        }
                    }
                }
                .environmentObject(toastManager)
                .environmentObject(viewModel)
            }
            .padding(.horizontal, 16)

            VStack(spacing: 0){
                Spacer()
                Tabbar(currentTab: $currentTab)
            }
        }
        .background(Color.background)
        .edgesIgnoringSafeArea(.bottom)
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
    TabbarView()
}
