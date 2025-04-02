import Foundation
import Moya

class ShiftViewModel: ObservableObject {
    @Published var shiftData: [ShiftModel]?
    private let provider = MoyaProvider<Api>(session: Session(interceptor: ApiInterceptor()))

    func fetchShiftData() {
        provider.request(.getShift) { result in
            switch result {
            case .success(let response):
                do {
                    let data = try response.map([ShiftModel].self)
                    print(data)
                    DispatchQueue.main.async {
                        self.shiftData = data
                    }
                } catch {
                    print("❌ JSON 디코딩 실패: \(error.localizedDescription)")
                }
            case .failure(let error):
                print("❌ API 호출 실패: \(error.localizedDescription)")
            }
        }
    }
}
