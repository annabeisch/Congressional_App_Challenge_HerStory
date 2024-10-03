//
//  Wikithon.swift
//  herstory
//
//  Created by Anna Beischer on 9/8/24.
//

import Foundation
struct Wikithon: Identifiable, Codable {
    let id: String
    let name: String
    let date: String  // Dates can be tricky; handle them as strings or use a date formatter
    let unsung_heroes: [UnsungHero]
}
