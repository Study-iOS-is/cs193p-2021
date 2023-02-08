//
//  ContentView.swift
//  Memorize
//
//  Created by sei on 2023/02/08.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 3)
            Text("Hello, world!").foregroundColor(.red)
        }
        .padding([.top, .bottom])
        .foregroundColor(.green)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
