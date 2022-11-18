//
//  ApiHeaders.swift
//  Fleetio
//
//  Created by Deep Desai on 2022-11-13.
//

import Foundation

struct ApiManager {
    // Api Request Object Creation
    func getMutableRequest(section: String) -> NSMutableURLRequest {
        guard let url = NSURL(string: "https://secure.fleetio.com/api/v1/\(section)") as? URL else { return NSMutableURLRequest() }
        
        let request = NSMutableURLRequest(url:  url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("Token token=a3ddc620b35b609682192c167de1b1f3f5100387", forHTTPHeaderField: "Authorization")
        request.setValue("798819214b", forHTTPHeaderField: "Account-Token")
        
        return request
    }
}

