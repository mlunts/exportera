//
//  DeliveredInfo.swift
//  Exportera
//
//  Created by Marina Lunts on 26.05.2018.
//  Copyright © 2018 Marina Lunts. All rights reserved.
//

import Foundation

class DeliveredInfo: NSObject {
    var idUser : String?
    var actualDistance : Double?
    var startDate : Date?
    var endDate : Date?
    
    func setUser(id: String?) {
        self.idUser = id
    }
}
