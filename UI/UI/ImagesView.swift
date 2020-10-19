//
//  ImagesView.swift
//  UI
//
//  Created by Maciek on 19/10/2020.
//

import SwiftUI

public class ImagesBuilder {
    public static func buildView() -> some View {
        ImagesView()
    }
}

struct ImagesView: View {
    @State private var columnWidth: CGFloat = 100
    
    var body: some View {
        GeometryReader { g in
            VStack {
                Slider(value: $columnWidth, in: 50 ... g.size.width / 2)
                GridView(columnWidth: columnWidth) {
                    ForEach(0 ..< 200) { _ in
                        Rectangle().foregroundColor(.blue)
                            .aspectRatio(1, contentMode: .fill)
                    }
                }
            }
        }
    }
}

struct ImagesView_Previews: PreviewProvider {
    static var previews: some View {
        ImagesView()
    }
}
