//
//  SubActivitiesVC.swift
//  Resort
//
//  Created by Luca LG. Gramaglia on 15/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

class SubActivitiesVC: UIViewController {

    // MARK: - IBOutlets
    
    // MARK: Header
    
    @IBOutlet private var backButton: UIButton!
    @IBOutlet private var logoImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
        
    // MARK: UITableView
    
    @IBOutlet weak var activitiesTableView: UITableView! {
        didSet {
            activitiesTableView.separatorStyle = .none
        }
    }
    
    // MARK: - IVar
    
    var headerTitle: String?
    var iconImage: UIImage?
    var rowViewModels: [RowViewModel]?
    var activites: [Activity]?
    weak var coordinator: ActivityListCoordinator?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildHeader()
        initTableView()
    }
    
    // MARK: - Private methods
    
    private func buildHeader() {
        logoImageView.image = iconImage
        titleLabel.text = headerTitle
    }
    
    private func initTableView() {
        activitiesTableView.dataSource = self
        activitiesTableView.delegate = self
        activitiesTableView.registerNib(forCellClass: ActivityTableViewCell.self)
        activitiesTableView.backgroundColor = .clear
    }
    
    // MARK: - IBAction
    
    @IBAction func back(_ sender: Any) {
        coordinator?.detailsDidGoBackToList()
    }
}

// MARK: - UITableViewDataSource

extension SubActivitiesVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowViewModels?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let rowViewModel = self.rowViewModels?[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withClass: ActivityTableViewCell.self, at: indexPath)
        if let rowViewModel = rowViewModel{
            cell.setup(with: rowViewModel)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -50, 0, 0)
        cell.layer.transform = rotationTransform
        
        UIView.animate(withDuration: 0.3) {
            cell.layer.transform = CATransform3DIdentity
        }
    }
}

// MARK: - UITableViewDelegate

extension SubActivitiesVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ActivityTableViewCell.rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let activity = activites?[indexPath.row],
            let url = activity.url else { return }
        
        coordinator?.openMedia(with: url, title: activity.title)
    }
}
