//
//  AgendaDetailView.swift
//  Craxinno
//
//  Created by Jayasurya on 23/06/23.
//

import UIKit

class AgendaDetailView: UIView {

    weak var backBtn: UIButton!
    
    weak var eventImgView: UIImageView!
    weak var contentView: UIView!
    weak var scrollView: UIScrollView!
    weak var eventNameLbl: UILabel!
    weak var attendeesImgContainer: UIView!
    weak var countLbl: UILabel!
    
    weak var timeView: AgendaPlaceAndTimeView!
    weak var placeView: AgendaPlaceAndTimeView!

    weak var entercodeBtn: UIButton!
    weak var suryveyBtn: UIButton!
    weak var stackView: UIStackView!
    
    weak var speakerLbl: UILabel!
    weak var speakersContainerView: UIView!
    
    weak var registLinkLbl: UILabel!
    weak var registerBtn: UIButton!
    
    weak var documentLbl: UILabel!
    weak var documentBtn: UIButton!
    
    weak var descriptionLbl: UILabel!
    weak var descriptionTxtView: UITextView!
    
    weak var sponserLbl: UILabel!
    weak var sponserImgView: UIImageView!
    
    
    var eventNameString: String = ""{
        didSet{
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 0.9
            let attrStr = NSAttributedString(string: eventNameString.capitalized, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .medium), NSAttributedString.Key.foregroundColor: UIColor.label, NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.kern: 0.5])
            self.eventNameLbl.attributedText = attrStr
        }
    }
    
    var descriptionString: String = ""{
        didSet{
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 1.5
            let attrStr = NSAttributedString(string: descriptionString, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .regular), NSAttributedString.Key.foregroundColor: UIColor.label, NSAttributedString.Key.paragraphStyle: paragraphStyle])
            self.descriptionTxtView.attributedText = attrStr
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeUIAgendaDetailView()
        setConstraintsAgendaDetailView()
//        setDummy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setDummy(){
        let img = UIImage(named: "images")
        eventImgView.image = img

        eventNameString = "Alone in the Dark’s new footage is full of terror — and you can play a demo right now"
        
        descriptionString = "Alone in the Dark’s new footage is full of terror — and you can play a demo right now Alone in the Dark’s new footage is full of terror — and you can play a demo right now Alone in the Dark’s new footage is full of terror — and you can play a demo right now Alone in the Dark’s new footage is full of terror — and you can play a demo right now Alone in the Dark’s new footage is full of terror — and you can play a demo right now Alone in the Dark’s new footage is full of terror — and you can play a demo right now Alone in the Dark’s new footage is full of terror — and you can play a demo right now Alone in the Dark’s new footage is full of terror — and you can play a demo right now Alone in the Dark’s new footage is full of terror — and you can play a demo right now Alone in the Dark’s new footage is full of terror — and you can play a demo right now Alone in the Dark’s new footage is full of terror — and you can play a demo right now Alone in the Dark’s new footage is full of terror — and you can play a demo right now "
        
        sponserImgView.image = img
    }
    private func initializeUIAgendaDetailView(){
        let blueColor = UIColor.systemBlue
        
        let eventImg = UIImageView()
        eventImg.backgroundColor = .clear
        eventImg.contentMode = .scaleAspectFill
        self.eventImgView = eventImg
        self.addSubview(eventImg)
        
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        self.scrollView = scrollView
        self.addSubview(scrollView)
        
        let v = UIView()
        v.backgroundColor = UIColor.systemBackground
        self.contentView = v
        self.scrollView.addSubview(v)
        
        let evName = UILabel()
        evName.textColor = UIColor.label
        evName.backgroundColor = .clear
        evName.textAlignment = .left
        evName.numberOfLines = 0
        self.eventNameLbl = evName
        self.contentView.addSubview(evName)
        
        let attendeContainer = UIView()
        attendeContainer.backgroundColor = .clear
        self.attendeesImgContainer = attendeContainer
        self.contentView.addSubview(attendeContainer)
        
        let countLbl = UILabel()
        countLbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        countLbl.textColor = UIColor.label
        countLbl.backgroundColor = .clear
        countLbl.textAlignment = .left
        self.countLbl = countLbl
        self.contentView.addSubview(countLbl)
        
        let timeView = AgendaPlaceAndTimeView()
        self.timeView = timeView
        self.contentView.addSubview(timeView)
        
        let placeView = AgendaPlaceAndTimeView()
        self.placeView = placeView
        self.contentView.addSubview(placeView)
        
        
        let btn = UIButton()
        btn.setTitle("Enter Code", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        btn.backgroundColor = blueColor
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = false
        self.entercodeBtn = btn
        
        let btn2 = UIButton()
        btn2.setTitle("Take Survey", for: .normal)
        btn2.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        btn2.backgroundColor = blueColor
        btn2.layer.cornerRadius = 5
        btn2.layer.masksToBounds = false
        self.suryveyBtn = btn2
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        if(frame.size.height > 667){
            stackView.spacing = 22
        }
        else{
            stackView.spacing = 18
        }
        stackView.backgroundColor = .clear
        self.stackView = stackView
        self.stackView.addArrangedSubview(entercodeBtn)
        self.stackView.addArrangedSubview(suryveyBtn)
        self.contentView.addSubview(stackView)
        
        let speakerLbl = UILabel()
        speakerLbl.text = "Speakers"
        speakerLbl.textColor = UIColor.label
        speakerLbl.backgroundColor = .clear
        speakerLbl.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        self.speakerLbl = speakerLbl
        self.contentView.addSubview(speakerLbl)
        
        let speakerContainerView = UIView()
        speakerContainerView.backgroundColor = .clear
        self.speakersContainerView = speakerContainerView
        self.contentView.addSubview(speakerContainerView)
        
        
        let regLinkLbl = UILabel()
        regLinkLbl.text = "Registration Links"
        regLinkLbl.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        regLinkLbl.textColor = UIColor.label
        regLinkLbl.backgroundColor = .clear
        self.registLinkLbl = regLinkLbl
        self.contentView.addSubview(regLinkLbl)
        
        let regBtn = UIButton()
        regBtn.setTitle("Craxinno Technologies", for: .normal)
        regBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        regBtn.backgroundColor = blueColor
        regBtn.layer.cornerRadius = 5
        regBtn.layer.masksToBounds = false
        self.registerBtn = regBtn
        self.contentView.addSubview(regBtn)
        
        
        let docLbl = UILabel()
        docLbl.text = "Documents"
        docLbl.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        docLbl.textColor = UIColor.label
        docLbl.backgroundColor = .clear
        self.documentLbl = docLbl
        self.contentView.addSubview(docLbl)
        
        let docBtn = UIButton()
        docBtn.setTitle("Feature List (DOC)", for: .normal)
        docBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        docBtn.backgroundColor = blueColor
        docBtn.layer.cornerRadius = 5
        docBtn.layer.masksToBounds = false
        self.documentBtn = docBtn
        self.contentView.addSubview(docBtn)
        
        let descLbl = UILabel()
        descLbl.text = "Description"
        descLbl.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        descLbl.textColor = UIColor.label
        descLbl.backgroundColor = .clear
        self.descriptionLbl = descLbl
        self.contentView.addSubview(descLbl)
        
        let descTxtView = UITextView()
        descTxtView.isScrollEnabled = false
        descTxtView.isEditable = false
        descTxtView.backgroundColor = .clear
        self.descriptionTxtView = descTxtView
        self.contentView.addSubview(descTxtView)
        
        let sponsorLbl = UILabel()
        sponsorLbl.text = "Sponser Name"
        sponsorLbl.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        sponsorLbl.textColor = UIColor.label
        sponsorLbl.backgroundColor = .clear
        self.sponserLbl = sponsorLbl
        self.contentView.addSubview(sponsorLbl)
        
        let sponserImg = UIImageView()
        sponserImg.backgroundColor = .clear
        sponserImg.contentMode = .scaleAspectFit
        self.sponserImgView = sponserImg
        self.contentView.addSubview(sponserImg)
        
        let backBtn = UIButton()
        let backImg = UIImage(data: UIImage(systemName: "arrow.backward.circle")!.pngData()!)?.withTintColor(UIColor.blue, renderingMode: .alwaysOriginal)
        backBtn.setImage(backImg, for: .normal)
        backBtn.backgroundColor = .clear
        self.backBtn = backBtn
        self.addSubview(backBtn)
    }
    
    private func setConstraintsAgendaDetailView(){
        self.backBtn.snp.makeConstraints { make in
            make.left.equalTo(self).offset(17)
            if(frame.size.height > 667){
                make.top.equalTo(self).offset(40)
            }
            else{
                make.top.equalTo(self).offset(30)
            }
            make.height.width.equalTo(40)
        }
        
        self.eventImgView.snp.makeConstraints { make in
            make.top.left.right.equalTo(self)
            make.height.equalTo(250)
        }
        
        self.scrollView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(self)
        }
        
        self.contentView.snp.makeConstraints { make in
            make.bottom.equalTo(scrollView)
            make.top.equalTo(scrollView).offset(200)
            make.left.right.equalTo(self)
        }
        
        self.eventNameLbl.snp.makeConstraints { make in
            make.left.equalTo(self).inset(33)
            make.right.equalTo(self).inset(100)
            make.top.equalTo(self.contentView).offset(15)
        }
        
        self.attendeesImgContainer.snp.makeConstraints { make in
            make.left.equalTo(eventNameLbl)
            make.top.equalTo(eventNameLbl.snp.bottom).offset(22)
        }
        
        self.countLbl.snp.makeConstraints { make in
            make.left.equalTo(attendeesImgContainer.snp.right).offset(10)
            make.centerY.equalTo(attendeesImgContainer)
        }
        
        self.timeView.snp.makeConstraints { make in
            make.left.right.equalTo(self).inset(33)
            make.top.equalTo(attendeesImgContainer.snp.bottom).offset(15)
        }
        
        self.placeView.snp.makeConstraints { make in
            make.left.right.equalTo(self).inset(33)
            make.top.equalTo(timeView.snp.bottom).offset(20)
        }
        
        self.stackView.snp.makeConstraints { make in
            make.left.right.equalTo(self).inset(25)
            make.top.equalTo(placeView.snp.bottom).offset(27)
            make.height.equalTo(45)
        }
        
        self.speakerLbl.snp.makeConstraints { make in
            make.left.equalTo(stackView).inset(3)
            make.top.equalTo(stackView.snp.bottom).offset(35)
        }
        
        self.speakersContainerView.snp.makeConstraints { make in
            make.top.equalTo(speakerLbl.snp.bottom).offset(15)
            make.left.right.equalTo(stackView).inset(3)
        }
        
        self.registLinkLbl.snp.makeConstraints { make in
            make.left.equalTo(speakerLbl)
            make.top.equalTo(speakersContainerView.snp.bottom).offset(17)
        }
        
        self.registerBtn.snp.makeConstraints { make in
            make.top.equalTo(registLinkLbl.snp.bottom).offset(10)
            make.height.equalTo(45)
            make.left.right.equalTo(stackView).inset(35)
        }
        
        self.documentLbl.snp.makeConstraints { make in
            make.left.equalTo(registLinkLbl)
            make.top.equalTo(registerBtn.snp.bottom).offset(17)
        }
        
        self.documentBtn.snp.makeConstraints { make in
            make.left.right.equalTo(registerBtn)
            make.height.equalTo(45)
            make.top.equalTo(documentLbl.snp.bottom).offset(10)
        }
        
        self.descriptionLbl.snp.makeConstraints { make in
            make.left.equalTo(registLinkLbl).offset(-2)
            make.top.equalTo(documentBtn.snp.bottom).offset(17)
        }
        
        self.descriptionTxtView.snp.makeConstraints { make in
            make.left.right.equalTo(stackView)
            make.top.equalTo(descriptionLbl.snp.bottom)
        }
        
        self.sponserLbl.snp.makeConstraints { make in
            make.left.equalTo(descriptionLbl)
            make.top.equalTo(descriptionTxtView.snp.bottom)
        }
        
        self.sponserImgView.snp.makeConstraints { make in
            make.left.right.equalTo(self)
            make.top.equalTo(sponserLbl.snp.bottom).offset(10)
            make.height.equalTo(100)
            make.bottom.equalTo(scrollView)
        }
    }
}

class SpeakerView: UIView{
    
    weak var profileImgView: UIImageView!
    weak var speakerNameLbl: UILabel!
    weak var designationLbl: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        initializeUISpeakerView()
        setconstraintsSpeakerView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeUISpeakerView(){
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.layer.cornerRadius = 25
        imgView.layer.masksToBounds = true
        imgView.layer.borderWidth = 0.3
        imgView.layer.borderColor = UIColor.systemBlue.cgColor
        self.profileImgView = imgView
        self.addSubview(imgView)
        
        let name = UILabel()
        name.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        name.textColor = UIColor.label
        name.backgroundColor = .clear
        name.numberOfLines = 0
        name.textAlignment = .left
        self.speakerNameLbl = name
        self.addSubview(name)
        
        let desingLbl = UILabel()
        desingLbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        desingLbl.textColor = UIColor.label
        desingLbl.backgroundColor = .clear
        desingLbl.textAlignment = .left
        desingLbl.numberOfLines = 0
        self.designationLbl = desingLbl
        self.addSubview(desingLbl)
        
    }
    
    func setconstraintsSpeakerView(){
        self.profileImgView.snp.makeConstraints { make in
            make.top.left.equalTo(self).inset(2)
            make.height.width.equalTo(50)
        }
        
        self.speakerNameLbl.snp.makeConstraints { make in
            make.left.equalTo(self.profileImgView.snp.right).offset(8)
            make.top.equalTo(self.profileImgView).offset(4)
            make.right.equalTo(self).offset(-30)
        }
        
        self.designationLbl.snp.makeConstraints { make in
            make.left.right.equalTo(self.speakerNameLbl)
            make.top.equalTo(self.speakerNameLbl.snp.bottom).offset(5)
        }
    }
}

class AgendaPlaceAndTimeView: UIView{
    weak var imgIcon: UIImageView!
    weak var titleLbl: UILabel!
    weak var subTitleLbl: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        initializeUIAgendaPlaceAndTimeView()
        setConstraintsAgendaPlaceAndTimeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setDummy(){
        self.imgIcon.image = UIImage(systemName: "timer")
        self.titleLbl.text = "January 10, 2019"
        self.subTitleLbl.text = "01:14 pm - 4:00 pm EST"
    }
    
    private func initializeUIAgendaPlaceAndTimeView(){
        let imgIcon = UIImageView()
        imgIcon.backgroundColor = .clear
        imgIcon.contentMode = .scaleAspectFit
        self.imgIcon = imgIcon
        self.addSubview(imgIcon)
        
        let title = UILabel()
        title.numberOfLines = 0
        title.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        title.textColor = UIColor.label
        title.backgroundColor = .clear
        title.textAlignment = .left
        self.titleLbl = title
        self.addSubview(title)
        
        let subtitle = UILabel()
        subtitle.numberOfLines = 0
        subtitle.font = UIFont.systemFont(ofSize: 15, weight: .thin)
        subtitle.textColor = UIColor.label
        subtitle.backgroundColor = .clear
        subtitle.textAlignment = .left
        self.subTitleLbl = subtitle
        self.addSubview(subtitle)
    }
    
    private func setConstraintsAgendaPlaceAndTimeView(){
        self.imgIcon.snp.makeConstraints { make in
            make.left.top.equalTo(self)
            make.height.equalTo(25)
            make.width.equalTo(20)
        }
        
        self.titleLbl.snp.makeConstraints { make in
            make.left.equalTo(imgIcon.snp.right).offset(10)
            make.centerY.equalTo(imgIcon)
            make.right.equalTo(self).inset(10)
        }
        
        self.subTitleLbl.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(8)
            make.left.equalTo(titleLbl)
            make.bottom.equalTo(self)
        }
    }
}
