//
//  NewsArticle.swift
//  Dayline
//
//  Created by Jibryll Brinkley on 9/28/26.
//

import Foundation

struct News: Codable {
    let articles: [NewsArticle]
}

struct NewsArticle: Codable {
    let title: String?
    let description: String?
    let content: String?
    let url: String?
    let image: String?
    
}
