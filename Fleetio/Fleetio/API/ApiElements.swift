//
//  ApiHeaders.swift
//  Fleetio
//
//  Created by Deep Desai on 2022-11-13.
//

import Foundation

struct ApiElements {
    let headers = [
        "accept": "application/json",
        "Authorization": "Token token=a3ddc620b35b609682192c167de1b1f3f5100387",
        "Account-Token": "798819214b"
    ]
    
    func getMutableRequest(section: String) -> NSMutableURLRequest {
        
        guard let url = NSURL(string: "https://secure.fleetio.com/api/v1/\(section)") as? URL else { return NSMutableURLRequest() }
        
        return NSMutableURLRequest(url:  url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
    }
}

