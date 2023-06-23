//
//  AgentListView.swift
//  Craxinno
//
//  Created by Jayasurya on 22/06/23.
//

import UIKit
import SnapKit

class AgentListView: UIView {

    weak var titleLbl: UILabel!
    weak var profileImgView: UIImageView!
    weak var dateCollectionView: UICollectionView!
    weak var agendaTblView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        initializeUIAgentListView()
        setConstraintsAgentListView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func initializeUIAgentListView(){
        let titleLbl = UILabel()
        titleLbl.text = "Agenda"
        titleLbl.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        titleLbl.textColor = UIColor.label
        titleLbl.backgroundColor = .clear
        titleLbl.textAlignment = .left
        self.titleLbl = titleLbl
        self.addSubview(titleLbl)
        
        let imgView = UIImageView()
        var img = UIImage(systemName: "person")
        img = img?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
        imgView.image = img
        imgView.contentMode = .scaleAspectFit
        imgView.layer.cornerRadius = 18
        imgView.backgroundColor = .clear
        self.profileImgView = imgView
        self.addSubview(imgView)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let datecol = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        datecol.collectionViewLayout = layout
        datecol.showsHorizontalScrollIndicator = false
        datecol.backgroundColor = .clear
        self.dateCollectionView = datecol
        self.addSubview(datecol)
        
        let tblView = UITableView()
        tblView.showsVerticalScrollIndicator = false
        tblView.backgroundColor = .clear
        tblView.separatorStyle = .none
        self.agendaTblView = tblView
        self.addSubview(tblView)
    }
    
    private func setConstraintsAgentListView(){
        self.titleLbl.snp.makeConstraints { make in
            make.left.equalTo(self).offset(25)
            if(frame.height > 667){
                make.top.equalTo(self).offset(60)
            }
            else{
                make.top.equalTo(self).offset(45)
            }
        }
        
        self.profileImgView.snp.makeConstraints { make in
            make.right.equalTo(self).offset(-25)
            make.centerY.equalTo(titleLbl)
            make.height.width.equalTo(30)
        }
        
        self.dateCollectionView.snp.makeConstraints { make in
            make.left.equalTo(titleLbl)
            make.right.equalTo(self)
            if(frame.height > 667){
                make.top.equalTo(titleLbl.snp.bottom).offset(30)
            }
            else{
                make.top.equalTo(titleLbl.snp.bottom).offset(20)
            }
            make.height.equalTo(30)
        }
        
        self.agendaTblView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self)
            make.top.equalTo(dateCollectionView.snp.bottom).offset(5)
        }
    }

}
