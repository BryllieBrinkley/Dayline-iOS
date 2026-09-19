//
//  SelectConnectionsView.swift
//  Dayline
//
//  Created by Jibryll Brinkley on 9/17/26.
//

import SwiftUI

import SwiftUI

import SwiftUI

struct SelectConnectionsView: View {

    @State private var isEmailSelected = false
    @State private var isCalendarSelected = false
    @State private var isRemindersSelected = false
    @State private var isInterestsSelected = false

    var body: some View {

        VStack(alignment: .leading, spacing: 10) {

            Text("Choose what goes into your edition.")
                .font(.system(size: 18, weight: .regular))
                .foregroundStyle(.secondary)

            VStack {

                SelectConnectionRow(
                    connectionType: "Email",
                    systemImage: "envelope",
                    isSelected: $isEmailSelected
                )


                SelectConnectionRow(
                    connectionType: "Calendar",
                    systemImage: "calendar",
                    isSelected: $isCalendarSelected
                )


                SelectConnectionRow(
                    connectionType: "Reminders",
                    systemImage: "checklist",
                    isSelected: $isRemindersSelected
                )

                SelectConnectionRow(
                    connectionType: "Interests",
                    systemImage: "sparkles",
                    isSelected: $isInterestsSelected
                )
            }
            .background(.white)

            HStack {

                Spacer()

                Label(
                    "Private by design. You control every source.",
                    systemImage: "lock.fill"
                )
                .font(.caption)
                .foregroundStyle(.secondary)

                Spacer()
            }
        }
    }
}



struct SelectConnectionRow: View {

    let connectionType: String
    let systemImage: String

    @Binding var isSelected: Bool

    var body: some View {

        Button {

            isSelected.toggle()

        } label: {

            HStack(spacing: 16) {

                Image(systemName: systemImage)
                    .font(.system(size: 18))
                    .foregroundStyle(.secondary)
                    .frame(width: 24)

                Text(connectionType)
                    .font(.body)
                    .foregroundStyle(.primary)

                Spacer()

                Image(
                    systemName: isSelected
                        ? "checkmark.circle.fill"
                        : "circle"
                )
                .font(.system(size: 20))
                .foregroundStyle(
                    isSelected
                        ? .blue
                        : .secondary
                )
            }
            .padding(.horizontal, 16)
            .frame(height: 52)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}


#Preview {
    SelectConnectionsView()
}
