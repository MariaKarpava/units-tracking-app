//
//  ExperimentsWithEditing.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 01/01/2024.
//

import SwiftUI

struct ExperimentsWithEditing: View {
    @Environment(\.editMode) private var editMode
    @State var mode: EditMode = .inactive
    var numbers = [1,2,3,4,5]
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVStack(alignment: .center, spacing: 15) {
                    ForEach(numbers, id: \.self) { number in
                        Text("Number: \(number)")
                    }
                }
            }
        }.toolbar {
            EditButton()
        }
        .environment(\.editMode, $mode)
    }
}

#Preview {
    ExperimentsWithEditing()
}
