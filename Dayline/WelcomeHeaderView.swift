//
//  ContentView.swift
//  Dayline
//
//  Created by Jibryll Brinkley on 9/17/26.
//

import SwiftUI

struct WelcomeHeaderView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Dayline")
                .font(.system(size: 48,
                              weight: .bold,
                              design: .serif))
                
            Text("Wake up more informed.")
                           .font(.system(
                               size: 39,
                               weight: .bold,
                               design: .serif
                           ))

            Text("Your schedule, inbox, tasks, and news into one personalized morning edition — ready when you wake up.")
                          .font(.system(size: 24, weight: .regular))
                          .foregroundStyle(.secondary)
                          .lineSpacing(3)
                          .fixedSize(
                              horizontal: false,
                              vertical: true
                          )
        
        
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 24)
    }
}

#Preview {
    WelcomeHeaderView()
}
