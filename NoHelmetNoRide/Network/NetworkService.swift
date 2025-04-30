//
//  NetworkService.swift
//  NoHelmetNoRide
//
//  Created by LCH on 4/30/25.
//
import Foundation
import Alamofire

class NetworkService {
    
    func addressToCoordinates(address: String) async throws -> GeocodingResult {
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
}
