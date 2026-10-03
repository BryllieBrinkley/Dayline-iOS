import SwiftUI
import EventKit
import WeatherKit
import SwiftData

struct EditionDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = EditionViewModel()
    @State private var saveError: String?
    private let weatherManager = WeatherManager()
    @Environment(\.modelContext) private var modelContext
    private let comicURL = URL(string: "https://imgs.xkcd.com/comics/barrel_cropped_(1).jpg")
    
    
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
                        // print func
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
            await viewModel.load()
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
                Text("MORNING EDITION NO. \(editionNumber)")
                
                Spacer()
                
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
                
                CurrentWeatherView()
                
                Spacer()
            }
            .font(.system(size: 8, weight: .semibold, design: .serif))
            .lineLimit(1)
            .padding(.horizontal)
            .padding(.top, 5)
            
            
        }
    }
    private var newspaperGrid: some View {
        VStack(alignment: .center, spacing: 25) {
            ScheduleSectionView()
            TopThreeSectionView()
            quoteSection
            yourWorldSection
            
            
            horizontalRule
            comicSection
        }
    }
    
    private var quoteSection: some View {
        VStack(alignment: .center, spacing: 8) {
            AsyncImage(url: dailyPhotoURL) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Color.gray.opacity(0.15)
            }
            .clipped()
            
            Text(viewModel.quote?.q ?? "Preperation today creates tommorw's opportunites.")
                .font(.system(size: 10, design: .serif))
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .lineLimit(5)
            
            Text("- \(viewModel.quote?.a ?? "Charlie Chaplin")")
                .font(.system(.subheadline, design: .serif))
                .fontWeight(.semibold)
            
        }
        .frame(maxWidth: .infinity)
    }
    
    private var todaysSchedule: String {
        guard !viewModel.events.isEmpty else {
            return "No events scheduled today."
        }
        
        let lines: [String] = viewModel.events.map { event in
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
            subtitle: "\(viewModel.events.count) events today",
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
        VStack(alignment: .center, spacing: 12) {

            Text("Your World")
                .font(.system(.largeTitle, design: .serif, weight: .bold))
                .fontWidth(.expanded)

            ForEach(viewModel.articles) { article in

                VStack(spacing: 8) {

                    AsyncImage(
                        url: article.image.flatMap(URL.init(string:))
                    ) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Image("newspaper")
                            .resizable()
                            .scaledToFill()
                    }
                    .frame(height: 180)
                    .clipped()

                    if let title = article.title {

                        if let urlString = article.url,
                           let url = URL(string: urlString) {

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

                    if let description = article.description,
                       !description.isEmpty {

                        Text(description)
                            .lineLimit(3)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                }

                Divider()
            }
        }
    }
    
    private var dailyPhotoURL: URL? {
        let date = Calendar.current.dateComponents(
            [.year, .month, .day],
            from: currentDate
        )
        let seed = "\(date.year!)-\(date.month!)-\(date.day!)"
        
        return URL(
            string: "https://picsum.photos/seed/dayline-\(seed)/800/600"
        )
    }
    
    private var crosswordCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Today’s Crossword")
                .font(.system(.subheadline, design: .serif, weight: .bold))
                .lineLimit(1)
            Spacer()
            Image("mini-crossword")
                .resizable()
                .scaledToFit()
                .frame(width: 140)
            
            Text("A quick puzzle to fuel your day.")
                .font(.system(.body, design: .serif))
        }
    }
    
    private var weatherView: some View {
        VStack(alignment: .center, spacing: 10) {
            
            if let currentWeather = weatherManager.currentWeather {
                
                Text(weatherManager.cityName ?? "Weather")
                
                
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
                
                
                Text(currentWeather.condition.description)
                
                    .foregroundStyle(.secondary)
                
            } else if weatherManager.isLoading {
                
                ProgressView()
                
            } else if let errorMessage = weatherManager.errorMessage {
                
                Text(errorMessage)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .font(.largeTitle)
        .fontWeight(.semibold)
        .fontDesign(.serif)
    }
    
    private func saveEdition(news: NewsArticle, quote: Quote) {
        let edition = SavedEdition(
            headline: news.title ?? "",
            articleSummary: news.description ?? "",
            articleURL: news.url,
            quoteText: quote.q,
            quoteAuthor: quote.a
        )
        
        modelContext.insert(edition)
        
        do {
            try modelContext.save()
        } catch {
            modelContext.delete(edition)
            saveError = error.localizedDescription
        }
    }
    
    
    
    private var comicSection: some View {
        VStack {
            Text("Comic of the Day")
                .font(.largeTitle)
                .fontDesign(.serif)
            AsyncImage(url: comicURL) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
        }
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

