//
//  NetworkService.swift
//  NoHelmetNoRide
//
//  Created by LCH on 4/30/25.
//
import Foundation
import Alamofire

class NetworkService {
    /*
    func addressToCoordinates(address: String) async throws -> GeocodingResult {
     
        //일반 메서드에서 async await를 사용하려면 withCheckedThrowingContinuation를 활용하면 됨
        try await withCheckedThrowingContinuation { completion in
            
            guard let key = Bundle.main.infoDictionary?["NMFNcpKeyId"] as? String else {
                print("APIKey 가져오기 실패")
                return
            }
            
            guard let secretKey = Bundle.main.infoDictionary?["APISecret"] as? String else {
                print("APISecret 가져오기 실패")
                return
            }
            
            let headers: HTTPHeaders = [
                "x-ncp-apigw-api-key-id": key,
                "x-ncp-apigw-api-key": secretKey,
                "Accept": "application/json"
            ]
            
            AF.request("https://maps.apigw.ntruss.com/map-geocode/v2/geocode",
                       method: .get,
                       parameters: ["query" : address],
                       headers: headers).responseDecodable(of: GeocodingResult.self) { response in
                switch response.result {
                case .success(let result):
                    completion.resume(returning: result)
                case .failure(let error):
                    completion.resume(throwing: error)
                }
            }
        }
    }
    */
    
    // 네이버 지도 API로 부터 주소를 입력받아서 결과 값을 받는 메서드
    func serializedAddressToCoordinates(address: String) async throws -> GeocodingResult {
        
        // info.plist로부터 key 추출
        guard let key = Bundle.main.infoDictionary?["NMFNcpKeyId"] as? String else {
            print("APIKey 가져오기 실패")
            throw CustomNetworkError.wrongAPIID
        }
        
        // info.plist로부터 key 추출
        guard let secretKey = Bundle.main.infoDictionary?["APISecret"] as? String else {
            print("APISecret 가져오기 실패")
            throw CustomNetworkError.wrongAPIKey
        }
        
        // API요청을 위한 HTTPHeaders 설정
        let headers: HTTPHeaders = [
            "x-ncp-apigw-api-key-id": key, // API 키 입력
            "x-ncp-apigw-api-key": secretKey, // API 키 입력
            "Accept": "application/json" // 서버로부터 응답 json으로 요청(미설정시 기본값 xml)
        ]
        
        // Alamofire를 통한 네트워크 통신
        let request = await AF.request("https://maps.apigw.ntruss.com/map-geocode/v2/geocode",
                       method: .get,
                       parameters: ["query" : address],
                       headers: headers)
            .serializingDecodable(GeocodingResult.self)
            .response
        switch request.result {
        case .success(let result):
            return result
        case .failure(let error):
            throw error
        }
    }
}
