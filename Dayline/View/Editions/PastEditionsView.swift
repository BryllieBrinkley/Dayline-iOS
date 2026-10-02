import SwiftUI

struct PastEditionsView: View {
    
    @State private var selectedDate = Date.now
    @State private var isSaved = false
    @State private var selectedEdition: Edition?
    
    private let editions = Edition.sampleEditions
    
    var body: some View {
        VStack() {
            headerView
            
            monthView
            
            weekPicker
            
            Divider()
            
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(editions) { edition in
                        EditionCardView(edition: edition) {
                            selectedEdition = edition
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 16)
                .padding(.bottom, 24)
            }
            .scrollIndicators(.hidden)
        }
        .sheet(item: $selectedEdition) { edition in
            EditionDetailView()
        }
    }
    
    private var headerView: some View {
        HStack {
            Text("Past Editions")
                .font(.system(size: 34, weight: .bold, design: .serif))
            
            Spacer()
            
            Button {
                print("Search editions")
            } label: {
                Image(systemName: "magnifyingglass")
                    .font(.title2)
            }
            
            Button {
                print("Filter editions")
            } label: {
                Image(systemName: "line.3.horizontal.decrease")
                    .font(.title2)
            }
        }
        .foregroundStyle(.primary)
        .padding(.horizontal)
        .padding(.top, 12)
    }
    
    private var monthView: some View {
        Text(
            selectedDate.formatted(
                .dateTime
                    .month(.abbreviated)
                    .year()
            )
        )
        .font(.headline)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        .padding(.top, 20)
    }
    
    private var weekPicker: some View {
        HStack {
            ForEach(weekDates, id: \.self) { date in
                Button {
                    selectedDate = date
                } label: {
                    VStack(spacing: 8) {
                        Text(
                            date.formatted(
                                .dateTime.day()
                            )
                        )
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(width: 38, height: 38)
                        .background {
                            if Calendar.current.isDate(
                                date,
                                inSameDayAs: selectedDate
                            ) {
                                Circle()
                                    .fill(.blue)
                            }
                        }
                        .foregroundStyle(
                            Calendar.current.isDate(
                                date,
                                inSameDayAs: selectedDate
                            )
                            ? .white
                            : .secondary
                        )
                        
                        Text(
                            date.formatted(
                                .dateTime.weekday(.narrow)
                            )
                        )
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    }
                }
                .buttonStyle(.plain)
                
                if date != weekDates.last {
                    Spacer()
                }
            }
        }
        .padding(.horizontal)
        .padding(.top, 10)
        
    }
    private var weekDates: [Date] {
        let calendar = Calendar.current
        
        guard let week = calendar.dateInterval(
            of: .weekOfYear,
            for: selectedDate
        ) else {
            return []
        }
        
        return (0..<7).compactMap { day in
            calendar.date(
                byAdding: .day,
                value: day,
                to: week.start
            )
        }
    }
}

#Preview {
    PastEditionsView()
}
