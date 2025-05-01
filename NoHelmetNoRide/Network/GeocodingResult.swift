//
//  GeocodingResult.swift
//  NoHelmetNoRide
//
//  Created by LCH on 4/30/25.
//

// Naver map api로부터 받은 jon 디코딩을 위한 struct 정의
struct GeocodingResult: Decodable {
    let status: String
    let meta: Meta
    let addresses: [Address]
    let errorMessage: String?
}

struct Meta: Decodable {
    let totalCount: Int
    let page: Int
    let count: Int
}

struct Address: Decodable {
    let roadAddress: String
    let jibunAddress: String
    let englishAddress: String
    let addressElements: [AddressElements]
    let x: String
    let y: String
    let distance: Double
}

struct AddressElements: Decodable {
    let types: [String]
    let longName: String
    let shortName: String
    let code: String
}
