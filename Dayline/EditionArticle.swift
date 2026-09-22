
//
//  EditionArticle.swift
//  Dayline
//
//  Created by Jibryll Brinkley on 9/22/26.
//

import Foundation

struct EditionArticle: Identifiable, Codable, Hashable {
    let id: UUID
    let type: EditionSectionType
    let title: String
    let subtitle: String?
    let body: String
    let imageName: String?
    let pageNumber: Int

    init(
        id: UUID = UUID(),
        type: EditionSectionType,
        title: String,
        subtitle: String? = nil,
        body: String,
        imageName: String? = nil,
        pageNumber: Int
    ) {
        self.id = id
        self.type = type
        self.title = title
        self.subtitle = subtitle
        self.body = body
        self.imageName = imageName
        self.pageNumber = pageNumber
    }
}
