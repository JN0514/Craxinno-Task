//
//  AgendaViewModel.swift
//  Craxinno
//
//  Created by Jayasurya on 23/06/23.
//

import Foundation

protocol AgendaViewModelDelegate: NSObject{
    func actionForResponse(agendaDetailModel: AgendaDetailModel)
    func reloadAgendaListForResponse()
}

class AgendaViewModel: NSObject{
    
    weak var delegate: AgendaViewModelDelegate?
    var agendaModel: AgendaModel?
    
    var arrOfDayEvents: [[AgendaSingleData]] = []
    var arrOfUniqueDates: [Date] = []
    
    var arrOfDayEventsToAvoidConcurrencyAccess:[[AgendaSingleData]] = []
    var arrOfUniqueDatesToAvoidConcurrencyAccess: [Date] = []

    var str = """
{
    "replyCode": "success",
    "replyMsg": "Agenda Detail",
    "data": {
        "id": 25857,
        "user_id": 117195,
        "event_id": 1989,
        "name": "Final Cut Pro for the iPad is slick but limited",
        "start_date": "2023-06-19T13:00:00.000Z",
        "end_date": "2023-06-20T02:00:00.000Z",
        "description": "<p>\r\n\t<span style=\"font-family:georgia,serif;\"><span style=\"font-size:16px;\"><span style=\"color: rgb(0, 0, 0); letter-spacing: -0.18px;\">Final Cut Pro for iPad is a carefully designed app that gets a lot of the basics right. It&rsquo;s a great adaptation of its desktop app, and FCP users will feel right at home. It also takes advantage of the iPad&rsquo;s touch-first interface and utilizes accessories like the Magic Keyboard and Apple Pencil well. It&rsquo;s also priced accessibly &mdash; Apple is&nbsp;</span><a href=\"https://go.redirectingat.com/?xs=1&amp;id=1025X1701640&amp;url=https%3A%2F%2Fapps.apple.com%2Fus%2Fapp%2Ffinal-cut-pro-for-ipad%2Fid1631624924&amp;xcust=___vg__p_23498184__t_w__r_https://www.theverge.com/tech__d_D\" rel=\"sponsored nofollow noopener\" style=\"box-sizing: border-box; border: 0px solid; --tw-border-spacing-x: 0; --tw-border-spacing-y: 0; --tw-translate-x: 0; --tw-translate-y: 0; --tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scale-x: 1; --tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; --tw-scroll-snap-strictness: proximity; --tw-ordinal: ; --tw-slashed-zero: ; --tw-numeric-figure: ; --tw-numeric-spacing: ; --tw-numeric-fraction: ; --tw-ring-inset: ; --tw-ring-offset-width: 0px; --tw-ring-offset-color: #fff; --tw-ring-color: rgba(59,130,246,.5); --tw-ring-offset-shadow: 0 0 #0000; --tw-ring-shadow: 0 0 #0000; --tw-shadow: inset 0 -1px 0 0 #000; --tw-shadow-colored: inset 0 -1px 0 0 var(--tw-shadow-color); --tw-blur: ; --tw-brightness: ; --tw-contrast: ; --tw-grayscale: ; --tw-hue-rotate: ; --tw-invert: ; --tw-saturate: ; --tw-sepia: ; --tw-drop-shadow: ; --tw-backdrop-blur: ; --tw-backdrop-brightness: ; --tw-backdrop-contrast: ; --tw-backdrop-grayscale: ; --tw-backdrop-hue-rotate: ; --tw-backdrop-invert: ; --tw-backdrop-opacity: ; --tw-backdrop-saturate: ; --tw-backdrop-sepia: ; text-decoration: inherit; box-shadow: var(--tw-ring-offset-shadow,0 0 #0000),var(--tw-ring-shadow,0 0 #0000),var(--tw-shadow); font-family: __fkRomanStandard_6e52d0, __fkRomanStandard_Fallback_6e52d0, Georgia, serif; font-size: 18px; letter-spacing: -0.18px;\" target=\"_blank\">selling it as a subscription at $5 per month or $50 per year</a><span style=\"color: rgb(0, 0, 0); letter-spacing: -0.18px;\">, which makes it easy to use for a month or two to see if it&rsquo;s something you want to stick with.</span></span></span></p>\r\n",
        "sponsor_name": "Apple",
        "sponsor_img": "1687173881.jpg",
        "location_name": "Florida",
        "header_img": "1686918323.jpg",
        "my_agenda": 0,
        "attendees": [],
        "register_links": [
            {
                "register_link": "https://craxinno.com/",
                "register_text": "Craxinno Technologies"
            }
        ],
        "agenda_documents": [
            {
                "document_name": "Feature List",
                "document_file": "https://eventowl.net/app/webroot/uploads/agenda_img/1684985550.jfif"
            }
        ],
        "agenda_speakers": [
            {
                "name": "Jonty Rodes",
                "title": "Creater",
                "company_name": "JR  Consultancy",
                "image": "https://eventowl.net/app/webroot/uploads/speaker/1685099505_M10.jpg"
            },
            {
                "name": "Eddy Joe",
                "title": "Manager",
                "company_name": "Eddy Joe Visco",
                "image": "https://eventowl.net/app/webroot/uploads/speaker/1684988147_1.jpg"
            },
            {
                "name": "Tom Handy",
                "title": "Manager",
                "company_name": "TOM & Jerry Studio",
                "image": "https://eventowl.net/app/webroot/uploads/speaker/1684988075_97.jpg"
            },
            {
                "name": "Tim Cook",
                "title": "CEO",
                "company_name": "Tim and Cook Partners",
                "image": "https://eventowl.net/app/webroot/uploads/speaker/1684987880_61.jpg"
            }
        ]
    },
    "cmd": "agendas",
    "imgPath": "https://eventowl.net/app/webroot/uploads/agenda_img/",
    "attendeeImgPath": "https://eventowl.net/app/webroot/uploads/user_pictures/",
    "speakerImgPath": "https://eventowl.net/app/webroot/uploads/speaker/"
}
"""
    
    func getDailyAgendas(){
        if let url = URL(string: "http://eventowl.net:3680/demo_agneda_list"){
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

            let parameters: [String: String] = [
                "eid": "1989",
                "pid": "117195"
            ]

            var components = URLComponents()
            components.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }

            if let encodedData = components.query?.data(using: .utf8) {
                request.httpBody = encodedData
            }
            
            
            let task = URLSession.shared.dataTask(with: request) {[weak self] (data, response, error) in

                guard let self = self else{return}
                
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse else {
                    print("Invalid response")
                    return
                }

                print("Status code: \(httpResponse.statusCode)")

                if let responseData = data {
                    let jsonDecoder = JSONDecoder()
                    do{
                        let agendaModel = try jsonDecoder.decode(AgendaModel.self, from: responseData)
                        self.agendaModel = agendaModel
                        let count = agendaModel.data.count
                        var i = 0
                        while(i<count){
                            let agendaSingleData = agendaModel.data[i]
                            let date = extractDateFromString(agendaSingleData.start_date)
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd"
                            arrOfUniqueDates.append(date)
                            var sameDateEvents: [AgendaSingleData] = []
                            while(i<count &&
                                  dateFormatter.string(from: date) ==
                                  dateFormatter.string(from: extractDateFromString(agendaModel.data[i].start_date))){
                                sameDateEvents.append(agendaModel.data[i])
                                i+=1
                            }
                            arrOfDayEvents.append(sameDateEvents)
                        }
                        self.delegate?.reloadAgendaListForResponse()
                        
                    }
                    catch{
                        print(error.localizedDescription)
                    }
                }
            }


            task.resume()

        }
    }
    
    func callDummy(){
        let data = str.data(using: .utf8)
        if let responseData = data {
            let jsonDecoder = JSONDecoder()
            do{
                let agendaModel = try jsonDecoder.decode(AgendaModel.self, from: responseData)
                self.agendaModel = agendaModel
                let count = agendaModel.data.count
                var i = 0
                while(i<count){
                    let agendaSingleData = agendaModel.data[i]
                    let date = extractDateFromString(agendaSingleData.start_date)
                    arrOfUniqueDates.append(date)
                    var sameDateEvents: [AgendaSingleData] = []
                    while(i<count && date == extractDateFromString(agendaModel.data[i].start_date)){
                        sameDateEvents.append(agendaModel.data[i])
                        i+=1
                    }
                    arrOfDayEvents.append(sameDateEvents)
                }
                self.delegate?.reloadAgendaListForResponse()
                
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func extractDateFromString(_ dateStr: String) -> Date{

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: dateStr) {
            return date
        } else {
            print("Failed to convert string to date.")
            return Date()
        }
    }
    
    func getAgendaDetails(id: Int){
        if let url = URL(string: "http://eventowl.net:3680/demo_agenda_detail?sid=1&eid=1989&pid=117195&aid=\(id)"){
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request) { [weak self](data, response, error)  in
                guard let self = self else{return}
                
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse else {
                    print("Invalid response")
                    return
                }

                print("Status code: \(httpResponse.statusCode)")

                if let responseData = data {
                    let jsonDecoder = JSONDecoder()
                    do{
                        
                        let agendaDetailModel = try jsonDecoder.decode(AgendaDetailModel.self, from: responseData)
                        delegate?.actionForResponse(agendaDetailModel: agendaDetailModel)
                        
                    }
                    catch{
                        print(error.localizedDescription)
                    }
                }
            }

            task.resume()

        }
        
    }
    
}
