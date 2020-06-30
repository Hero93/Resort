//
//  NewsListVC.swift
//  Resort
//
//  Created by Luca Gramaglia on 14/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

class NewsListVC: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private var newsTableView: UITableView! {
        didSet {
            newsTableView.dataSource = self
            newsTableView.delegate = self
            newsTableView.registerNib(forCellClass: NewsTableViewCell.self)
            newsTableView.separatorStyle = .none
            newsTableView.backgroundColor = .clear
        }
    }
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView! {
        didSet {
            activityIndicatorView.hidesWhenStopped = true
        }
    }
    
    var controller: NewsListController?
    weak var coordinator: NewsCoordinator?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        controller?.start()
    }
    
    func initBinding() {
        controller?.viewModel.rowViewModels.addObserver(fireNow: false) { [weak self] (rowViewModels) in
            self?.newsTableView.reloadData()
        }
        
        controller?.viewModel.isTableViewHidden.addObserver { [weak self] (isHidden) in
            self?.newsTableView.isHidden = isHidden
        }
        
        controller?.viewModel.isLoading.addObserver { [weak self] (isLoading) in
            if isLoading {
                self?.activityIndicatorView.startAnimating()
            } else {
                self?.activityIndicatorView.stopAnimating()
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension NewsListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller?.viewModel.rowViewModels.value.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rowViewModel = self.controller?.viewModel.rowViewModels.value[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withClass: NewsTableViewCell.self, at: indexPath)
        if let rowViewModel = rowViewModel{
            cell.setup(with: rowViewModel)
        }
        cell.selectionStyle = .none

        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 0, 0)
        cell.layer.transform = rotationTransform
        
        UIView.animate(withDuration: 0.4) {
            cell.layer.transform = CATransform3DIdentity
        }
    }
}

// MARK: - UITableViewDelegate

extension NewsListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return NewsTableViewCell.rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let rowIndex = indexPath.row
        guard let news = controller?.getNews(for: rowIndex) else { return }
        coordinator?.openDetail(news: news)
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        UIView.animate(withDuration: 0.3) {
            cell?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
    }

    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        UIView.animate(withDuration: 0.3) {
            cell?.transform = .identity
        }
    }
}
