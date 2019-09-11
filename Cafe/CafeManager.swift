//
// Created by Luiz on 2019-09-10.
// Copyright (c) 2019 Luiz. All rights reserved.
//

import Foundation

class CafeManager: DataManage {
    
    var cafes : [Cafe] = []

    init() {
        self.fetchCafes()
    }
    func fetchCafes() {
        for item in load(file: "Cafe") {
            let cafe = Cafe(json: item)
            cafes.append(cafe)
        }
    }
    
}
