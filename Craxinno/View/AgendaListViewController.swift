//
//  ViewController.swift
//  Craxinno
//
//  Created by Jayasurya on 22/06/23.
//

import UIKit

class AgendaListViewController: UIViewController {

  
    var agendaListview: AgentListView?
    
    let agendaVM = AgendaViewModel()
    var currentSelectedDateInCollection = 0
    
    override func loadView() {
        super.loadView()
        agendaListview = AgentListView(frame: view.frame)
        view.addSubview(agendaListview!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.systemBackground
        agendaVM.delegate = self
        setUpView()
        agendaVM.getDailyAgendas()
    }

    private func setUpView(){
        
        agendaListview?.dateCollectionView.dataSource = self
        agendaListview?.dateCollectionView.delegate = self
        agendaListview?.dateCollectionView.register(DateCollectionCell.self, forCellWithReuseIdentifier: DateCollectionCell.identifier)
        
        
        agendaListview?.agendaTblView.dataSource = self
        agendaListview?.agendaTblView.delegate = self
        agendaListview?.agendaTblView.register(AgendaListRowCell.self, forCellReuseIdentifier: AgendaListRowCell.identifier)
    }
}

extension AgendaListViewController: AgendaViewModelDelegate{
    func actionForResponse(agendaDetailModel: AgendaDetailModel) {
        DispatchQueue.main.async {
            let vc = AgendaDetailViewController(agendaDetailModel: agendaDetailModel)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func reloadAgendaListForResponse() {
        
        DispatchQueue.main.async {
            self.agendaVM.arrOfDayEventsToAvoidConcurrencyAccess = self.agendaVM.arrOfDayEvents
            self.agendaVM.arrOfUniqueDatesToAvoidConcurrencyAccess = self.agendaVM.arrOfUniqueDates
            self.agendaListview?.agendaTblView.reloadData()
            self.agendaListview?.dateCollectionView.reloadData()
        }
    }
    
    
}

extension AgendaListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return agendaVM.arrOfUniqueDatesToAvoidConcurrencyAccess.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateCollectionCell.identifier, for: indexPath) as? DateCollectionCell else{return UICollectionViewCell()}
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E,MMM d"
        
        let dateStr = dateFormatter.string(from: agendaVM.arrOfUniqueDatesToAvoidConcurrencyAccess[indexPath.row])
        cell.lbl.text = dateStr.uppercased()
        if(currentSelectedDateInCollection == indexPath.row){
            cell.lbl.textColor = UIColor.systemBlue
        }
        else{
            cell.lbl.textColor = UIColor.label
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(indexPath.row != currentSelectedDateInCollection){
            let selectedCell = collectionView.cellForItem(at: indexPath) as! DateCollectionCell
            selectedCell.lbl.textColor = UIColor.systemBlue
            
            let unselectedCell = collectionView.cellForItem(at: IndexPath(item: currentSelectedDateInCollection, section: 0)) as! DateCollectionCell
            unselectedCell.lbl.textColor = UIColor.label
            
            currentSelectedDateInCollection = indexPath.row
            self.agendaListview?.agendaTblView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: collectionView.frame.size.height)
    }
}

extension AgendaListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.agendaVM.arrOfDayEventsToAvoidConcurrencyAccess.count > 0){
            return self.agendaVM.arrOfDayEventsToAvoidConcurrencyAccess[currentSelectedDateInCollection].count
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let agendaRow = tableView.dequeueReusableCell(withIdentifier: AgendaListRowCell.identifier, for: indexPath) as? AgendaListRowCell else{return UITableViewCell()}
        let agendaSingleData = self.agendaVM.arrOfDayEventsToAvoidConcurrencyAccess[currentSelectedDateInCollection][indexPath.row]
        agendaRow.agendaListRowView.eventName.text = agendaSingleData.name
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        
        let startDate = self.agendaVM.extractDateFromString(agendaSingleData.start_date)
        let endDate = self.agendaVM.extractDateFromString(agendaSingleData.end_date)
        
        let startTime = dateFormatter.string(from: startDate)
        let endTime = dateFormatter.string(from: endDate)

        agendaRow.agendaListRowView.startEndTime.text = "\(startTime) - \(endTime)"
        agendaRow.setNumberOfImgs(numOfImgs: agendaSingleData.attendees)
        return agendaRow
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = self.agendaVM.arrOfDayEventsToAvoidConcurrencyAccess[currentSelectedDateInCollection][indexPath.row].id
        self.agendaVM.getAgendaDetails(id: id)

    }
}

class DateCollectionCell: UICollectionViewCell{
    static let identifier = "DateCollectionCell"
    
    let lbl: UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = .clear
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.addSubview(lbl)
        lbl.snp.makeConstraints { make in
            make.center.equalTo(self)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
