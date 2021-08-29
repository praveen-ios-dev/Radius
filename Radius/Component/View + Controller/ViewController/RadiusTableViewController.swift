//
//  RadiusTableViewController.swift
//  Radius
//
//  Created by kumar praveen on 28/08/21.
//

import UIKit

class RadiusTableViewController: UITableViewController {
    
    let worker = Worker()
    lazy var radiusVM = RadiusViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        tableView.separatorStyle = .none
        callAPI()
    }
    
    fileprivate func callAPI() {
        RefreshManager.shared.loadDataIfNeeded { (isApiCallNeeded) in
            if isApiCallNeeded{
                view.showLoading()
                Worker.getRadiusList(URL.assignmentAPI){ [weak self] (response, error) in
                    if let _ = response{
                        self?.view.stopLoading()
                        self?.radiusVM = RadiusViewModel()
                        self?.radiusVM.radiusDelegate = self
                        self?.tableView.reloadData()
                    }else{
                        self?.showAlert(self ?? UIViewController(), title: Strings.sorry, message: Strings.apiFailMsg)
                    }
                }
            }else{
                radiusVM = RadiusViewModel()
                radiusVM.radiusDelegate = self
            }
        }
        self.tableView.separatorStyle = .singleLine
    }
    
    func registerCell(){
        tableView.register(UINib(nibName: Xib.RadiusXib , bundle: .main), forCellReuseIdentifier: Identifier.RadiusTableViewCell)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return radiusVM.numberOfSection()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return radiusVM.getNumberOfRows(section)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.RadiusTableViewCell, for: indexPath) as? RadiusTableViewCell{
            cell.selectionStyle = .none
            let options = radiusVM.getOptionsObj(indexPath)
            cell.setNameAndIcon(options)
            cell.isUserInteractionEnabled = (options?.isEnabled ?? true)
            cell.accessoryType = (options?.isEnabled ?? true) && (options?.isSelected ?? false) ? .checkmark : .none
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        radiusVM.selectLogic(indexPath)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return radiusVM.getHeaderText(section)
    }
}

extension RadiusTableViewController : SelectionProtocol{
    func updateCell() {
        tableView.reloadData()
    }
}
