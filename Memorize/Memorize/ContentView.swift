//
//  ContentView.swift
//  Memorize
//
//  Created by sei on 2023/02/08.
//

import SwiftUI

struct ContentView: View {
    @State var emojis = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🏍", "🛵", "🛴", "🚲", "🚄", "🚃", "🚠", "✈️", "🚂", "🚀", "🛰", "🚁", "🛸", "⛵️", "🛳", "🛥", "🎠"]
    @State var emojiCount = 4

    var body: some View {
        VStack {
            HStack {
                ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                    CardView(content: emoji)
                }
            }
            Spacer()
            HStack {
                remove
                Spacer()
                shuffle
                Spacer()
                add
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)
        .foregroundColor(.orange)
    }

    var remove: some View {
        Button {
            if emojiCount > 1 {
                emojiCount -= 1
            }
        } label: {
            Image(systemName: "minus.circle")

        }
    }

    var shuffle: some View {
        Button {
            emojis.shuffle()
        } label: {
            Text("Shuffle")
        }
    }

    var add: some View {
        Button {
            if emojiCount < emojis.count {
                emojiCount += 1
            }
        } label: {
            Image(systemName: "plus.circle")
        }
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true

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
