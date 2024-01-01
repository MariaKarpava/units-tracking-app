//
//  Experiments.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 30/12/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var isEditing = false

    var body: some View {
        CustomEditableView(isEditing: $isEditing)
    }
}


struct CustomEditableView: View {
    @State private var items = ["Item 1", "Item 2", "Item 3"]
    @Environment(\.editMode) var editMode
    @Binding var isEditing: Bool

    var body: some View {
        VStack {
            ForEach(items, id: \.self) { item in
                HStack {
                    Text(item)
                    Spacer()

                    if editMode?.wrappedValue == .active {
                        Button(action: {
                            // Handle deletion
                            if let index = items.firstIndex(of: item) {
                                items.remove(at: index)
                            }
                        }) {
                            Image(systemName: "trash.circle.fill")
                                .foregroundColor(.red)
                        }
                    }
                }
                .padding()
            }

            Button(action: {
                withAnimation {
                    self.editMode?.toggle
                }
            }) {
                Text(editMode?.wrappedValue == .active ? "Done" : "Edit")
                    .padding()
            }
        }
    }
}



#Preview {
    CustomEditableView()
}
