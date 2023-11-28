//
//  IndexAPI.swift
//  lztrans
//
//  Created by jsw_cool on 2023/8/15.
//

import Foundation
import Moya
import CommonCrypto

class IndexAPI{
    static func getProvider() -> MoyaProvider<Index>{
         return MoyaProvider<Index>()
    }
}

public enum Index{
    case index
}

extension Index:TargetType{
    public var baseURL: URL {
        switch self {
        case .index:
            return URL(string: "https://lzgj.test.brightcns.cn/gateway")!
        }
    }
    
    public var path: String {
        switch self {
        case .index:
            return ""
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .index:
            return .post
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .index:
            var params: [String: Any] = [:]
            params["cityCode"] = "450200"
            params["versionName"] = "4.3.8"
            params["sysName"] = "ios"
            //将业务参数转为string
            let data:Data = try! JSONSerialization.data(withJSONObject: params)
            let paramstr = String(data: data, encoding: .utf8)
            //最终传参
            var finalParams: [String: Any] = [:]
            finalParams["method"] = "apps.layout.home"
            finalParams["bizReq"] = paramstr
            finalParams["appId"] = "com.brightcns.dxlc"
            finalParams["signType"] = "MD5"
            finalParams["version"] = "1.0"
            finalParams["timestamp"] = "20230815164637"
            //前面的参数排序拼接 进行md5
            let array1 =  finalParams.keys.sorted(by: <)
            var signStr = ""
            for index in 0..<array1.count {
                let item = array1[index]
                let value = finalParams[item]!
                let str = "\(item)=\(value)"
                signStr = signStr.appending(str)
                if index == array1.count-1{
                    signStr.append("1234567890")
                }else{
                    signStr.append("&")
                }
            }
            finalParams["sign"] = signStr.md5
            return .requestParameters(parameters: finalParams, encoding: JSONEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        return ["Content-Type":"application/json; charset=utf-8"]
    }
}

 
extension String {
    var md5:String {
        let utf8 = cString(using: .utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(utf8, CC_LONG(utf8!.count - 1), &digest)
        return digest.reduce("") { $0 + String(format:"%02X", $1) }
    }
}
