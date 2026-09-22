//
//  TopThreeSectionView.swift
//  Dayline
//
//  Created by Jibryll Brinkley on 9/18/26.
//

import SwiftUI

struct TopThreeSectionView: View {

    @State private var tasks = [
        DailyTask(
            title: "Work on portfolio"
        ),
        DailyTask(
            title: "HW for Math"
        ),
        DailyTask(
            title: "Workout with Coach"
        )
    ]

    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 8
        ) {
            HStack {
                Text("Top 3")
                    .font(.title3)
                    .fontWeight(.semibold)

                Spacer()

                Button("See all") {
                    print("See all tasks")
                }
                .font(.subheadline)
            }

            VStack(spacing: 0) {
                ForEach(tasks.indices, id: \.self) { index in

                    TopThreeRow(
                        task: $tasks[index]
                    )

                    if index < tasks.count - 1 {
                        Divider()
                            .padding(.leading, 44)
                    }
                }
            }
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.background)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(
                        .gray.opacity(0.25),
                        lineWidth: 1
                    )
            }
        }
    }
}



struct TopThreeRow: View {

    @Binding var task: DailyTask

    var body: some View {
        Button {
            task.isCompleted.toggle()
        } label: {
            HStack(spacing: 12) {
                Image(
                    systemName: task.isCompleted
                        ? "checkmark.square.fill"
                        : "square"
                )
                .font(.system(size: 20))
                .foregroundStyle(
                    task.isCompleted
                        ? .blue
                        : .secondary
                )

                Text(task.title)
                    .font(.subheadline)
                    .foregroundStyle(
                        task.isCompleted
                            ? .secondary
                            : .primary
                    )
                    .strikethrough(
                        task.isCompleted
                    )

                Spacer()
            }
            .padding(.horizontal, 12)
            .frame(height: 44)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    TopThreeSectionView()
        .padding()
}



#Preview {
    TopThreeSectionView()
}
