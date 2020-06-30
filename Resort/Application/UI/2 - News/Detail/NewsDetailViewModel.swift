//
//  NewsDetailViewModel.swift
//  Resort
//
//  Created by Luca LG. Gramaglia on 17/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

struct NewsDetailViewModel {
        
    private let news: News
    
    init(_ news: News) {
        self.news = news
    }
}

extension NewsDetailViewModel {
    
    var title: String {
        return news.title
    }
    
    var description: String {
        return news.content
    }
    
    var date: String? {
        return ""
    }
}
