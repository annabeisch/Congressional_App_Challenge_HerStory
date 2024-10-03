//
//  UnsungHero.swift
//  herstory
//
//  Created by Anna Beischer on 9/8/24.
//

import Foundation
struct UnsungHero: Identifiable, Codable {
    let id: String
    let name: String
    let added_date: String  // Dates can be tricky; handle them as strings or use a date formatter
    let completion_status: String
}
