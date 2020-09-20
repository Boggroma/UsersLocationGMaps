//
//  Client.swift
//  UsersLocationGMaps
//
//  Created by мак on 18.09.2020.
//  Copyright © 2020 viktorsafonov. All rights reserved.
//

import Foundation
    
    
    
    struct ClientData: Decodable {
        enum CodingKeys: String, CodingKey {
            case idClient = "IdClient"
            case idClientAccount = "IdClientAccount"
            case clientCode = "ClientCode"
            case latitude = "Latitude"
            case longitude = "Longitude"
            case avatarHash = "AvatarHash"
            case statusOnline = "StatusOnline"
        }
        
        var idClient: Int
        var idClientAccount: Int
        var clientCode: String
        var latitude: Double
        var longitude: Double
        var avatarHash: String?
        var statusOnline: Bool
    
}
