//
//  GridView.swift
//  UI
//
//  Created by Maciek on 19/10/2020.
//

import SwiftUI

struct GridView<Content>: View where Content: View {
    let columnWidth: CGFloat
    
    let content: () -> Content
    
    var body: some View {
        GeometryReader { g in
            VStack {
                ScrollView {
                    let content = self.content().frame(width: columnWidth)
                    #if targetEnvironment(macCatalyst)
                    List {
                        content
                    }
                    #else
                    LazyVGrid(
                        columns: (1 ... Int(g.size.width / columnWidth))
                            .map { _ in GridItem.init(.flexible()) },
                        spacing: 10
                    ) {
                        content
                    }
                    #endif
                }
            }
        }
    }
}

struct GridView_Previews: PreviewProvider {
    
    static var previews: some View {
        HStack {
            GridView(columnWidth: 140) {
                ForEach(0 ..< 20000000) { _ in
                    Rectangle()
                        .foregroundColor(.red)
                        .aspectRatio(1, contentMode: .fit)
                }
            }
        }
    }
}
