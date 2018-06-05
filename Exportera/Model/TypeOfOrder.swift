//
//  TypeOfOrder.swift
//  Exportera
//
//  Created by Marina Lunts on 10.05.2018.
//  Copyright © 2018 Marina Lunts. All rights reserved.
//

import Foundation

enum OrderType: String{
    case cargo
    case documents
    case tyreDisk
    case packages
    case pallets
    
    
    var getType: String {
        switch self {
        case .cargo: return "Cargo"
        case .documents: return "Documents"
        case .tyreDisk: return "Tyre or Disks"
        case .packages: return "Package"
        case .pallets: return "Pallets"
        }
    }
}
