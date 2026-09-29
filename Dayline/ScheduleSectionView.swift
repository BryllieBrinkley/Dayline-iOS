//
//  ScheduleSectionView.swift
//  Dayline
//
//  Created by Jibryll Brinkley on 9/18/26.
//

import SwiftUI

import SwiftUI

struct ScheduleSectionView: View {

    let scheduleItems = ScheduleItem.sampleItems
    @Environment(\.openURL) private var openURL

    var body: some View {
        VStack(spacing: 0) {

            HStack {
                Text("Your Schedule")
                    .font(.title3)
                    .fontWeight(.semibold)

                Spacer()

                Button("See all") {
                    
                }
                .font(.subheadline)
            }
            .padding(.bottom, 6)

            Divider()

        }
    }
}

#Preview {
    ScheduleSectionView()
}
