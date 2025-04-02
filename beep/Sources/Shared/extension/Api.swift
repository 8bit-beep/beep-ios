import Moya
import Foundation

enum Api {
    case getMe
    case login(dauthId: String, dauthPw: String)
    case getToken(code: String)
    case reissueToken(refreshToken: String)
    case attend(room: String)
    case changeRoom(room: String)
    case getShift
    case createShift(room: String, reason: String, period: Int)
    case deleteShift(id: String)
    case cancelAttend
}

extension Api: TargetType {
    var baseURL: URL {
        switch self {
        case .login: return URL(string: "https://dauth.b1nd.com/api")!
        default: return URL(string: "https://beepapi.com")!
        }
        
    }
    
    var path: String {
        switch self {
        case .getMe:
            return "/users/me"
        case .login:
            return "/auth/login"
        case .getToken:
            return "/dauth/login"
        case .reissueToken:
            return "/auth/refresh"
        case .attend:
            return "/attends"
        case .changeRoom:
            return "/users/me/room"
        case .getShift:
            return "/shifts/me"
        case .createShift:
            return "/shifts"
        case .deleteShift(let id):
            return "/shifts/\(id)"
        case .cancelAttend:
            return "/attends/cancel"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMe, .getShift:
            return .get
        case .login, .getToken, .reissueToken, .attend, .createShift, .cancelAttend:
            return .post
        case .changeRoom:
            return .patch
        case .deleteShift:
            return .delete
        }
    }
    
    var task: Task {
        switch self {
        case .getMe, .getShift, .deleteShift, .cancelAttend:
            return .requestPlain
            
        case .login(let dauthId, let duathPw):
            return .requestParameters(
                parameters: [
                    "id": dauthId,
                    "pw": duathPw,
                    "clientId": "575fe863c46f4126a9c17e4af4b82d5d351bdff5507d454086a88edd19afa723",
                    "redirectUrl": "https://beep.cher1shrxd.me/callback/dauth"
                ], encoding: JSONEncoding.default)
            
        case .getToken(let code):
            return .requestParameters(
                parameters: [
                    "code": code,
                ], encoding: JSONEncoding.default)
            
        case .reissueToken(let refreshToken):
            return .requestParameters(
                parameters: [
                    "refreshToken": refreshToken
                ],
                encoding: JSONEncoding.default)
            
        case .attend(room: let room):
            return .requestParameters(
                parameters: [
                    "room": room
                ], encoding: JSONEncoding.default)
        
        case .changeRoom(let room):
            return .requestParameters(
                parameters: [
                    "roomName": room
                ], encoding: JSONEncoding.default)
            
        case .createShift(let room, let reason, let period):
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            formatter.locale = Locale(identifier: "ko_KR") 
            let currentDate = formatter.string(from: Date())
            
            return .requestParameters(
                parameters: [
                    "room": room,
                    "reason": reason,
                    "period": period,
                    "date": currentDate
                ], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}

