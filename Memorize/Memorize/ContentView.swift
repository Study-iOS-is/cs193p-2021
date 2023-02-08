//
//  ContentView.swift
//  Memorize
//
//  Created by sei on 2023/02/08.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            CardView()
            CardView()
            CardView()
            CardView()
        }
        .padding([.top, .bottom])
        .foregroundColor(.green)
    }
}

struct CardView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 3)
            Text("🍎")
                .foregroundColor(.red)
                .font(.largeTitle)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
