import SwiftUI

import SwiftUI

struct CustomizeView: View {
    @StateObject private var viewModel = CustomizeViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Spacer()
            headerView
            Spacer()
            sectionList
            Spacer()
            saveButton

            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 12)
    }

    private var headerView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Customize Tomorrow")
                .font(
                    .system(
                        size: 30,
                        weight: .bold,
                        design: .serif
                    )
                )
                .lineLimit(1)

            Text("Choose what appears in your daily edition.")
                .font(.system(size: 16))
                .foregroundStyle(.secondary)
        }
    }

    private var sectionList: some View {
            VStack {
                List {
                    ForEach($viewModel.sections) { $section in
                        CustomizeSectionRow(section: $section)
                            .font(.body)
                    }
                    .padding()
                    Button {
                        print("addSectionButton pressed")
                    } label: {
                        HStack(spacing: 10) {
                            Spacer()
                            Image(systemName: "plus")
                            Text("Add a section")
                                .fontWeight(.medium)
                            
                            Spacer()
                        }
                        .foregroundStyle(.blue)
                        .frame(maxWidth: .infinity)
                        .frame(height: 30)
                    }
                    .buttonStyle(.bordered)
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
            .frame(height: 500)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.systemBackground))
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray.opacity(0.25), lineWidth: 1)
            }
        
    }

    private var saveButton: some View {
        Button {
            print("Button pressed to save preferences")
        } label: {
            Text("Save preferences")
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 46)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.blue)
                }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    CustomizeView()
}
