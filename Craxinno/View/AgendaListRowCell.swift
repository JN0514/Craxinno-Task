//
//  AgendaListRowCell.swift
//  Craxinno
//
//  Created by Jayasurya on 22/06/23.
//

import UIKit

class AgendaListRowCell: UITableViewCell {

    static let identifier = "AgendaListRowCell"
    weak var agendaListRowView: AgendaListRowView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.selectionStyle = .none
        initializeUIAgendaListRowCell()
        setConstraintsAgendaListRowCell()
        setDummy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setDummy(){
        self.agendaListRowView.eventName.text = "Alone in the Dark’s new footage is full of terror — and you can play a demo right now"
        self.agendaListRowView.startEndTime.text = "4:00 pm - 5:00 pm EST"
        
    }
    
    func setNumberOfImgs(numOfImgs: [Image]){
        let n = numOfImgs.count
        
        for imgview in self.agendaListRowView.attendeesImgContainer.subviews{
            if(imgview.isKind(of: UIImageView.self)){
                imgview.removeFromSuperview()
            }
        }
        
        if(n > 0){
            let imgV = UIImageView()
            imgV.downloadAndSetImage(url: numOfImgs[0].image, placeholderImage: UIImage(systemName: "person.fill")!)
            imgV.backgroundColor = .clear
            imgV.contentMode = .scaleToFill
            imgV.layer.cornerRadius = 25
            imgV.layer.masksToBounds = true
            self.agendaListRowView.attendeesImgContainer.addSubview(imgV)
            imgV.snp.makeConstraints { make in
                make.left.top.bottom.equalTo(self.agendaListRowView.attendeesImgContainer)
                make.width.height.equalTo(50)
            }
            
            var lastImg = imgV
            
            var i = 1
            while(i<5 && i<n){
                let imgV = UIImageView()
                imgV.downloadAndSetImage(url: numOfImgs[1].image, placeholderImage: UIImage(systemName: "person.fill")!)
                imgV.backgroundColor = .clear
                imgV.contentMode = .scaleToFill
                imgV.layer.cornerRadius = 25
                imgV.layer.masksToBounds = true
                self.agendaListRowView.attendeesImgContainer.addSubview(imgV)
                imgV.snp.makeConstraints { make in
                    make.left.equalTo(lastImg.snp.right).offset(7)
                    make.top.bottom.equalTo(lastImg)
                    make.width.height.equalTo(50)
                }
                lastImg = imgV
                i+=1
            }
            
            lastImg.snp.makeConstraints { make in
                make.right.equalTo(self.agendaListRowView.attendeesImgContainer)
            }
            
            if(n>=5){
                self.agendaListRowView.remCountLbl.text = "+\(n-4)"
            }
            else{
                self.agendaListRowView.remCountLbl.text = ""
            }
        }
        else{
            self.agendaListRowView.remCountLbl.text = ""
        }

        
    }
    
    private func initializeUIAgendaListRowCell(){
        let agrow = AgendaListRowView()
        agrow.layer.cornerRadius = 20
        agrow.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        agrow.layer.borderWidth = 0.6
        agrow.layer.borderColor = UIColor.tertiaryLabel.cgColor
        agrow.layer.masksToBounds = false
        self.agendaListRowView = agrow
        self.contentView.addSubview(agrow)
    }
    
    private func setConstraintsAgendaListRowCell(){
        self.agendaListRowView.snp.makeConstraints { make in
            make.left.equalTo(self.contentView).offset(20)
            make.right.top.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView).offset(-16)
        }
        
        self.contentView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
}


class AgendaListRowView: UIView{
    
    weak var eventName: UILabel!
    weak var startEndTime: UILabel!
    weak var attendeesImgContainer: UIView!
    weak var remCountLbl: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        initializeUIAgendaListRowView()
        setConstraintsAgendaListRowView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    private func initializeUIAgendaListRowView(){
        let evName = UILabel()
        evName.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        evName.textColor = UIColor.label
        evName.backgroundColor = .clear
        evName.textAlignment = .left
        evName.numberOfLines = 0
        self.eventName = evName
        self.addSubview(evName)
        
        let durationLbl = UILabel()
        durationLbl.font = UIFont.systemFont(ofSize: 12, weight: .light)
        durationLbl.textColor = UIColor.label
        durationLbl.backgroundColor = .clear
        durationLbl.textAlignment = .left
        self.startEndTime = durationLbl
        self.addSubview(durationLbl)
        
        let countLbl = UILabel()
        countLbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        countLbl.textColor = UIColor.label
        countLbl.backgroundColor = .clear
        countLbl.textAlignment = .left
        self.remCountLbl = countLbl
        self.addSubview(countLbl)
        
        let v = UIView()
        v.backgroundColor = .clear
        self.attendeesImgContainer = v
        self.addSubview(v)
    }
    
    private func setConstraintsAgendaListRowView(){
        self.eventName.snp.makeConstraints { make in
            make.left.equalTo(self).offset(28)
            make.top.equalTo(self).offset(18)
            make.right.equalTo(self).inset(80)
        }
        
        self.startEndTime.snp.makeConstraints { make in
            make.left.equalTo(eventName)
            make.top.equalTo(eventName.snp.bottom).offset(10)
        }
        
        self.attendeesImgContainer.snp.makeConstraints { make in
            make.left.equalTo(eventName)
            make.top.equalTo(startEndTime.snp.bottom).offset(10)
            make.bottom.equalTo(self).inset(18)
        }
        
        self.remCountLbl.snp.makeConstraints { make in
            make.left.equalTo(attendeesImgContainer.snp.right).offset(10)
            make.centerY.equalTo(attendeesImgContainer)
        }
    }

}
