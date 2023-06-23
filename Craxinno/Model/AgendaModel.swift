//
//  AgendaEachEventModel.swift
//  Craxinno
//
//  Created by Jayasurya on 23/06/23.
//

import Foundation


struct AgendaModel: Codable{
    var data: [AgendaSingleData]
}

struct AgendaSingleData: Codable{
    var id: Int
    var name: String
    var start_date: String
    var end_date: String
    var attendees: [Image]
}

struct Image: Codable{
    var image: String
}
