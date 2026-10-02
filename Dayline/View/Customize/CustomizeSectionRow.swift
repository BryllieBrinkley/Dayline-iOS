import SwiftUI

struct CustomizeSectionRow: View {

    @Binding var section: DailySection
    
    var body: some View {
        HStack {
            Spacer()
            Toggle(isOn: $section.isEnabled) {
                Label(section.title, systemImage: section.iconName)
            }
            .toggleStyle(.switch)
            .foregroundStyle(.black)
        }
    }
}
