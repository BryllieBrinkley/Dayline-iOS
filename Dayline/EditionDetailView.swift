import SwiftUI
import EventKit
import WeatherKit

struct EditionDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = EditionViewModel()
    @State private var quote: Quote?
    @State private var news: NewsArticle?
    @State private var todayEvents: [EKEvent] = []
    private let calendarService = DayCalendarService()
    private let weatherManager = WeatherManager()
    
    let currentDate = Date()
    let editionNumber = 24
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 10) {
                    editionHeader
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
        .task {
            do {
                news = try await viewModel.fetchNews()
                print("Loaded news:", news?.title ?? "No title")
            } catch {
                print("News fetch failed:", error)
            }
            do {
                todayEvents = try await calendarService.fetchEvents()
                print("Events found:", todayEvents.count)
                for event in todayEvents {
                    print(event.title ?? "Untitled", event.startDate ?? "Untitled start date")
                }
            } catch {
                print("Calendar fetch failed:", error)
            }
            
            do {
                try await weatherManager.fetchCurrentWeather()
            } catch {
                print("Wether fetch failed:", error)
            }
            
        }
        
    }
    
    private var editionHeader: some View {
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
                .padding(.bottom, 5)
            
            
            Divider()
            
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
            .font(.system(size: 8, weight: .semibold, design: .serif))
            .lineLimit(1)
            .padding(.horizontal)
            .padding(.top, 5)
            
        }
    }
    private var newspaperGrid: some View {
        Grid(horizontalSpacing: 14, verticalSpacing: 12) {
            GridRow(alignment: .top) {
                weatherView
                    .newspaperColumnDivider()
                VStack(alignment: .leading, spacing: 8) {
                    Image("skyline")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 120)
                        .frame(maxWidth: .infinity)
                        .clipped()
                    
                    Text(quote?.q ?? "Preperation today creates tommorw's opportunites.")
                        .font(.system(.title3, design: .serif))
                        .fontWeight(.semibold)
                    
                    Text(quote?.a ?? "Charlie Chaplin")
                        .font(.system(.headline, design: .serif))
                        .fontWeight(.semibold)
                    
                }
            }
            
            horizontalRule
            
            GridRow(alignment: .top) {
                yourWorldSection
                    .newspaperColumnDivider()
                dailyEventsSection
                
            }
            
            horizontalRule
            
            GridRow(alignment: .top) {
                crosswordCard
                    .newspaperColumnDivider()
                TopThreeSectionView()
            }
        }
        
        .onAppear(perform: {
            Task {
                do {
                    quote = try await viewModel.fetchQuotes()
                } catch QuoteError.invalidURL {
                    print("invalid URL")
                } catch QuoteError.invalidResponse {
                    print("invalid Resposne")
                } catch QuoteError.invalidData {
                    print("invalid Data")
                } catch {
                    print("Error")
                }
            }
        })
    }
    
    private var todaysSchedule: String {
        guard !todayEvents.isEmpty else {
            return "No events scheduled today."
        }
        
        let lines: [String] = todayEvents.map { event in
            let time = event.isAllDay
            ? "All day"
            : event.startDate.formatted(date: .omitted, time: .shortened)
            
            print("\(time) — \(event.title ?? "Untitled event")")
            return "\(time) — \(event.title ?? "Untitled event")"
            
        }
        
        return lines.joined(separator: "\n")
    }
    
    private var dailyEventsSection: some View {
        NewspaperArticleView(
            title: "Your Day",
            subtitle: "\(todayEvents.count) events today",
            bodyText: todaysSchedule,
            page: 1
        )
    }
    
    
    private var horizontalRule: some View {
        Divider()
            .gridCellColumns(2)
            .gridCellUnsizedAxes(.horizontal)
    }
    
    private var yourWorldSection: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Your World")
                .font(.system(.title2, design: .serif, weight: .bold))
            
            // Article image
            AsyncImage(url: news?.image.flatMap(URL.init(string:))) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Image("newspaper")
                    .resizable()
                    .scaledToFill()
            }
            .frame(width: 140, height: 120)
            .clipped()
            
            if let title = news?.title {
                if let urlString = news?.url, let url = URL(string: urlString) {
                    Link(destination: url) {
                        Text(title)
                            .font(.system(.headline, design: .serif))
                            .foregroundStyle(.primary)
                    }
                    .buttonStyle(.plain)
                } else {
                    Text(title)
                        .font(.system(.headline, design: .serif))
                }
            } else {
                Text("Loading today's news...")
                    .font(.system(.headline, design: .serif))
                    .redacted(reason: .placeholder)
            }
            
            // Description / summary
            if let description = news?.description, description.isEmpty == false {
                Text(description)
                    .foregroundStyle(.secondary)
            }
        }
    }
    
    private var crosswordCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Today’s Mini Crossword")
                .font(.system(.title3, design: .serif, weight: .bold))
            
            Image("mini-crossword")
                .resizable()
                .scaledToFit()
                .frame(width: 140)
            
            Text("A quick puzzle to fuel your day.")
                .font(.system(.body, design: .serif))
        }
    }
    
    private var weatherView: some View {
        VStack(alignment: .leading, spacing: 2) {
            
            if let currentWeather = weatherManager.currentWeather {
                
                Text(weatherManager.cityName ?? "Weather")
                    .font(.caption)
                    .fontWeight(.semibold)
                
                HStack(spacing: 5) {
                    Image(systemName: currentWeather.symbolName)
                        .symbolRenderingMode(.multicolor)
                    
                    Text(
                        currentWeather.temperature.formatted(
                            .measurement(
                                width: .abbreviated,
                                usage: .weather,
                                numberFormatStyle: .number
                                    .precision(.fractionLength(0))
                            )
                        )
                    )
                    .fontWeight(.semibold)
                }
                
                Text(currentWeather.condition.description)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                
            } else if weatherManager.isLoading {
                
                ProgressView()
                
            } else if let errorMessage = weatherManager.errorMessage {
                
                Text(errorMessage)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .font(.largeTitle)
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
