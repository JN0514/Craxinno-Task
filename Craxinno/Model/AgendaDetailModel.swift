//
//  AgendaDetailModel.swift
//  Craxinno
//
//  Created by Jayasurya on 23/06/23.
//

import Foundation

struct AgendaDetailModel: Codable{
    var data: AgendaDataModel
    var imgPath: String
}

struct AgendaDataModel: Codable{
    var name: String
    var start_date: String
    var end_date: String
    var description: String
    var sponsor_name: String
    var location_name: String
    var sponsor_img: String
    var header_img: String
    var attendees: [Image]
    var register_links: [Register]
    var agenda_documents: [Document]
    var agenda_speakers: [Speaker]
}

struct Register: Codable{
    var register_link: String
    var register_text: String
}

struct Document: Codable{
    var document_name: String
    var document_file: String
}

struct Speaker: Codable{
    var name: String
    var title: String
    var image: String
}
