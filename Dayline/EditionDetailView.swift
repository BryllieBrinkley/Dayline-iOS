//
//  EditionDetailView.swift
//  Dayline
//
//  Created by Jibryll Brinkley on 9/22/26.
//

import SwiftUI

struct EditionDetailView: View {
    @Environment(\.dismiss) private var dismiss

    let currentDate = Date()
    let editionNumber = 24

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 10) {
                    masthead
                    editionMetadata
                    Divider()
                    newspaperGrid
                }
                .padding(.horizontal)
                .padding(.bottom, 24)
            }
            .background(Color(.systemBackground))
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .accessibilityLabel("Close")
                }


                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        // Add printing later
                    } label: {
                        Image(systemName: "printer")
                    }
                    .accessibilityLabel("Print")

                    ShareLink(item: "My Dayline morning edition") {
                        Image(systemName: "square.and.arrow.up")
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private var masthead: some View {
        VStack(spacing: 1) {
            Divider()

            Text("The Dayline")
                .font(
                    .system(
                        size: 45,
                        weight: .bold,
                        design: .serif
                    )
                )
                .minimumScaleFactor(0.8)
                .lineLimit(1)

            Text("A MORE INFORMED YOU")
                .font(.system(size: 10, weight: .medium, design: .serif))
                .tracking(5)
                .lineLimit(1)

            Divider()
        }
    }

    private var editionMetadata: some View {
        HStack {
            Text(
                currentDate.formatted(
                    .dateTime
                        .weekday(.wide)
                        .month(.wide)
                        .day()
                        .year()
                )
                .uppercased()
            )

            Spacer()

            Text("MORNING EDITION NO. \(editionNumber)")
        }
        .font(.system(size: 9, weight: .semibold, design: .serif))
        .lineLimit(1)
        .minimumScaleFactor(0.7)
    }

    // Keep your existing newspaperGrid,
    // horizontalRule and crosswordCard below.
}
    private var newspaperGrid: some View {
        Grid(horizontalSpacing: 14, verticalSpacing: 12) {
            GridRow(alignment: .top) {
                NewspaperArticleView(
                    title: "Your Day",
                    subtitle: "Big interview ahead",
                    bodyText: """
                    You have an interview today at 2:00 PM with Horizon Media. Here’s what to know and how to prepare.
                    """,
                    page: 1
                )
                .newspaperColumnDivider()

                VStack(alignment: .leading, spacing: 8) {
                    Image("skyline")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 120)
                        .frame(maxWidth: .infinity)
                        .clipped()

                    Text("“Preparation today creates tomorrow’s opportunities.”")
                        .font(.system(.title3, design: .serif))
                        .fontWeight(.semibold)
                }
            }

            horizontalRule

            GridRow(alignment: .top) {
                NewspaperArticleView(
                    title: "Inbox Intelligence",
                    bodyText: """
                    3 messages need your attention, including a reply from Christopher P.
                    """,
                    page: 2
                )
                .newspaperColumnDivider()

                NewspaperArticleView(
                    title: "Packages",
                    subtitle: "2 deliveries on the way",
                    bodyText: """
                    • MacBook case — arrives tomorrow
                    • Books — arrive Saturday
                    """,
                    page: 3
                )
            }

            horizontalRule

            GridRow(alignment: .top) {
                NewspaperArticleView(
                    title: "Your World",
                    subtitle: "AI tools are reshaping creative work",
                    bodyText: """
                    How professionals are using AI to move faster and create more meaningful work.
                    """,
                    page: 4
                )
                .newspaperColumnDivider()

                crosswordCard
            }
        }
    }

    private var horizontalRule: some View {
        Divider()
            .gridCellColumns(2)
    }

    private var crosswordCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Today’s Mini Crossword")
                .font(.system(.title3, design: .serif, weight: .bold))

            Image("mini-crossword")
                .resizable()
                .scaledToFit()

            Text("A quick puzzle to fuel your day.")
                .font(.system(.body, design: .serif))
        }
    }
extension View {
    func newspaperColumnDivider() -> some View {
        overlay(alignment: .trailing) {
            Rectangle()
                .fill(Color.secondary.opacity(0.25))
                .frame(width: 1)
                .padding(.trailing, -7)
        }
    }
}

#Preview {
    EditionDetailView()
}
