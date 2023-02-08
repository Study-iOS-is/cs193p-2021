//
//  ContentView.swift
//  Memorize
//
//  Created by sei on 2023/02/08.
//

import SwiftUI

struct ContentView: View {
    var emojis = ["🍎", "🍬", "😈", "👻"]

    var body: some View {
        HStack {
            ForEach(emojis, id: \.self) { emoji in
                CardView(content: emoji)
            }
        }
        .padding([.top, .bottom])
        .foregroundColor(.orange)
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = false

    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill(.white)
                shape.stroke(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
            .preferredColorScheme(.light)
    }
}
