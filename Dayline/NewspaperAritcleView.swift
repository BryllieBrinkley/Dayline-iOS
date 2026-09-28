//
//  NewspaperAritcleView.swift
//  Dayline
//
//  Created by Jibryll Brinkley on 9/22/26.
//

import SwiftUI

struct NewspaperArticleView: View {
    let title: String
    var subtitle: String?
    let bodyText: String
    let page: Int


    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.system(.title2, design: .serif, weight: .bold))

            if let subtitle {
                Text(subtitle)
                    .font(.system(.headline, design: .serif))
            }

            Text(bodyText)
                .font(.system(.body, design: .serif))
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)

            Text("Page \(page)")
                .font(.system(.caption, design: .serif))
                .foregroundStyle(.secondary)
                .padding(.top, 2)
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }
}
#Preview {
    NewspaperArticleView(title: "Article title placeholder", bodyText: """
 Body text of the article / newspaper
 """, page: 1)
}
