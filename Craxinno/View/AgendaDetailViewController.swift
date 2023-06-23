//
//  AgendaDetailViewController.swift
//  Craxinno
//
//  Created by Jayasurya on 23/06/23.
//

import UIKit

class AgendaDetailViewController: UIViewController {

    var agendaDetailView: AgendaDetailView?
    
    let agendaDetailModel: AgendaDetailModel
    let placeHolderImg = UIImage(systemName: "person.fill")!

    var initialOffsetY: CGFloat?
    
    init(agendaDetailModel: AgendaDetailModel){
        self.agendaDetailModel = agendaDetailModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    override func loadView() {
        super.loadView()
        agendaDetailView = AgendaDetailView(frame: view.frame)
        agendaDetailView?.backgroundColor = UIColor.systemBackground
        
        let imgPath = agendaDetailModel.imgPath
        let eventImg = imgPath+agendaDetailModel.data.header_img
        let sponserImg = imgPath+agendaDetailModel.data.sponsor_img
        
        
        agendaDetailView?.eventImgView.downloadAndSetImage(url: eventImg, placeholderImage: placeHolderImg)
        agendaDetailView?.sponserImgView.downloadAndSetImage(url: sponserImg, placeholderImage: placeHolderImg)
        agendaDetailView?.eventNameString = agendaDetailModel.data.name
        
        if let plainText = agendaDetailModel.data.description.convertHTMLToPlainText(){
            agendaDetailView?.descriptionString = plainText
        }
        

        setAttendeesImgs()
        setSpeakerDetails()
        setTimeAndLocation()
        view.addSubview(agendaDetailView!)
    }

    func setTimeAndLocation(){
        guard let agendaDetailView = self.agendaDetailView else {return}
        let date = extractDateFromString(self.agendaDetailModel.data.start_date)
        
        let timeDateFormatter = DateFormatter()
        timeDateFormatter.dateFormat = "h:mm a"
        
        let startDate = self.extractDateFromString(agendaDetailModel.data.start_date)
        let endDate = self.extractDateFromString(agendaDetailModel.data.end_date)
        
        let startTime = timeDateFormatter.string(from: startDate)
        let endTime = timeDateFormatter.string(from: endDate)
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MMMM d, yyyy"
        
        agendaDetailView.timeView.imgIcon.image = UIImage(systemName: "magazine")
        agendaDetailView.timeView.titleLbl.text = dateFormater.string(from: date)
        agendaDetailView.timeView.subTitleLbl.text = "\(startTime) - \(endTime)"
        agendaDetailView.placeView.imgIcon.image = UIImage(systemName: "figure.walk")
        agendaDetailView.placeView.titleLbl.text = self.agendaDetailModel.data.location_name
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
    
    func setSpeakerDetails(){
        var speakerDetailViews: [SpeakerView] = []
        
        for speakerDetail in agendaDetailModel.data.agenda_speakers{
            let speakerView = SpeakerView()
            speakerView.profileImgView.downloadAndSetImage(url: speakerDetail.image, placeholderImage: placeHolderImg)
            speakerView.speakerNameLbl.text = speakerDetail.name
            speakerView.designationLbl.text = speakerDetail.title
            speakerDetailViews.append(speakerView)
        }
        
        guard let agendaDetailView = self.agendaDetailView else {return}

        let n = speakerDetailViews.count

        if(n > 0){
            let speakerView = speakerDetailViews[0]
            agendaDetailView.speakersContainerView.addSubview(speakerView)
            speakerView.snp.makeConstraints { make in
                make.left.top.right.equalTo(agendaDetailView.speakersContainerView)
                make.height.equalTo(50)
            }
            
            var lastSpeakerView = speakerView
            
            var i = 1
            while(i<5 && i<n){
                let speakerView = speakerDetailViews[i]
                agendaDetailView.speakersContainerView.addSubview(speakerView)
                speakerView.snp.makeConstraints { make in
                    make.top.equalTo(lastSpeakerView.snp.bottom).offset(12)
                    make.left.right.equalTo(lastSpeakerView)
                    make.height.equalTo(50)

                }
                lastSpeakerView = speakerView
                i+=1
            }
            
            lastSpeakerView.snp.makeConstraints { make in
                make.bottom.equalTo(agendaDetailView.speakersContainerView)
            }
        }
    }
    
    func setAttendeesImgs(){
        var imgViews: [UIImageView] = []
        
        for imgUrlAttendee in agendaDetailModel.data.attendees{
            let imgView = UIImageView()
            imgView.backgroundColor = .clear
            imgView.downloadAndSetImage(url: imgUrlAttendee.image, placeholderImage: placeHolderImg)
            imgView.contentMode = .scaleToFill
            imgView.layer.cornerRadius = 25
            imgView.layer.masksToBounds = true
            imgViews.append(imgView)
        }
        
        guard let agendaDetailView = self.agendaDetailView else {return}
        
        let n = imgViews.count
        if(n > 0){
            let imgV = imgViews[0]
            agendaDetailView.attendeesImgContainer.addSubview(imgV)
            imgV.snp.makeConstraints { make in
                make.left.top.bottom.equalTo(agendaDetailView.attendeesImgContainer)
                make.width.height.equalTo(50)
            }
            
            var lastImg = imgV
            
            var i = 1
            while(i<5 && i<n){
                let imgV = imgViews[i]
                agendaDetailView.attendeesImgContainer.addSubview(imgV)
                imgV.snp.makeConstraints { make in
                    make.left.equalTo(lastImg.snp.right).offset(7)
                    make.top.bottom.equalTo(lastImg)
                    make.width.height.equalTo(50)
                }
                lastImg = imgV
                i+=1
            }
            
            lastImg.snp.makeConstraints { make in
                make.right.equalTo(agendaDetailView.attendeesImgContainer)
            }
            
            if(n>=5){
                agendaDetailView.countLbl.text = "+\(n-4)"
            }
            else{
                agendaDetailView.countLbl.text = ""
            }
        }
        else{
            agendaDetailView.countLbl.text = ""
        }

        
    }
    
    func setSpeakersDetail(){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        agendaDetailView?.backBtn.addTarget(self, action: #selector(goBackAction(_:)), for: .touchUpInside)
        agendaDetailView?.scrollView.delegate = self
        agendaDetailView?.registerBtn.addTarget(self, action: #selector(registerBtnClicked), for: .touchUpInside)
        agendaDetailView?.documentBtn.addTarget(self, action: #selector(documentBtnClicked), for: .touchUpInside)
    }
    
    @objc
    func registerBtnClicked(){
        if agendaDetailModel.data.register_links.count>0, let url = URL(string: agendaDetailModel.data.register_links[0].register_link){
            UIApplication.shared.open(url)
        }
    }

    @objc
    func documentBtnClicked(){
        if agendaDetailModel.data.agenda_documents.count>0, let url = URL(string: agendaDetailModel.data.agenda_documents[0].document_file){
            UIApplication.shared.open(url)
        }
    }
    
    @objc
    func goBackAction(_ btn: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}

extension AgendaDetailViewController: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let agendaDetailView = self.agendaDetailView else {return}
        if let initialOffsetY = initialOffsetY{
            let diff = initialOffsetY - scrollView.contentOffset.y
            if(diff >= 0){
                agendaDetailView.eventImgView.snp.updateConstraints { make in
                    make.height.equalTo(diff+250)
                }
            }
        }
        else{
            initialOffsetY = scrollView.contentOffset.y
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setDefaultHeightForEventImage(scrollView)
    }
    
    func setDefaultHeightForEventImage(_ scrollView: UIScrollView){
        guard let agendaDetailView = self.agendaDetailView else {return}

        if let initialOffsetY = initialOffsetY{
            let diff = initialOffsetY - scrollView.contentOffset.y
            if(diff >= 0){
                agendaDetailView.eventImgView.snp.updateConstraints { make in
                    make.height.equalTo(250)
                }
            }
        }
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if(!decelerate){
            setDefaultHeightForEventImage(scrollView)
        }
    }
}

extension String{
    func convertHTMLToPlainText() -> String? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil) {
            return attributedString.string
        } else {
            return nil
        }
    }
}

extension UIImageView{
    func downloadAndSetImage(url: String, placeholderImage: UIImage){
        self.image = placeholderImage

        guard let imageUrl = URL(string: url) else {
            print("Invalid image URL")
            return
        }

        let task = URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response")
                return
            }
            
            if let imageData = data {

                if let image = UIImage(data: imageData) {

                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
        }

        task.resume()

    }
}
