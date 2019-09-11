//
//  CafeManager.swift
//  Cafe
//
//  Created by Luiz on 9/10/19.
//  Copyright © 2019 Luiz. All rights reserved.
//

import Foundation

protocol DataManage {
    func load(file name: String ) -> [JsonObject]
}

extension DataManage {
    func load(file name: String) -> [JsonObject] {
        var json : [JsonObject] = [[:]]
        guard let path = Bundle.main.path(forResource: name, ofType: "json") else {
            return json
        }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe )
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as! JsonObject
            json = jsonResult["businesses"] as! [JsonObject]
        } catch  {
            print("Error reading Json File ", "\(#file)", "\(#function)", "\(#line)")
        }
        return json
    }
}
