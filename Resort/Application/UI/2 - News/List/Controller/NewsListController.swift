//
//  NewsListController.swift
//  Resort
//
//  Created by Luca LG. Gramaglia on 17/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

class NewsListController: NSObject {

    // MARK: - IVars
    
    let viewModel: NewsListViewModel
    let newsListLoader: NewsListLoader
    private var newsList: [News]?
        
    // MARK: - Init
    
    init(viewModel: NewsListViewModel = NewsListViewModel(), newsListLoader: NewsListLoader) {
        self.viewModel = viewModel
        self.newsListLoader = newsListLoader
    }
    
    func start() {
        
        self.viewModel.isLoading.value = true
        self.viewModel.isTableViewHidden.value = true
        self.viewModel.title.value = "Loading..."
        
        newsListLoader.load { [weak self] result in
            
            switch result {
            case .success(let news):
                self?.viewModel.isLoading.value = false
                self?.viewModel.isTableViewHidden.value = false
                self?.buildViewModels(of: news)
                self?.newsList = news
                
            case .failure(let error):
                print("error: \(error)")
                self?.viewModel.isLoading.value = false
                self?.viewModel.isTableViewHidden.value = true
            }
        }
    }
    
    // MARK: - Data source
    
    private func buildViewModels(of newsList: [News]) {
        self.viewModel.rowViewModels.value = NewsListController.viewModels(from: newsList)
    }
    
    static func viewModels(from newsList: [News]) -> [NewsRowViewModel] {
        return newsList.map { NewsRowViewModel(news: $0) }
    }
    
    func getNews(for rowIndex: Int) -> News? {
        return newsList?[rowIndex]
    }
}
