//
//  NewsRowViewModel.swift
//  Resort
//
//  Created by Luca LG. Gramaglia on 17/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

struct NewsRowViewModel: RowViewModel {
    
    private let news: News
    
    init(news: News) {
        self.news = news
    }
}

extension NewsRowViewModel {
    
    var date: String? {
        guard let date = news.date else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: date)
    }
    
    var title: String {
        return news.title
    }
    
    var description: String {
        return news.content
    }
}
