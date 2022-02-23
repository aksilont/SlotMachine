//
//  MainView.swift
//  SlotMachine
//
//  Created by Aksilont on 18.02.2022.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var gameViewModel = GameViewModel()
    
    var body: some View {
        VStack {
            Text("SLOT MACHINE")
                .padding()
                .font(.largeTitle)
            
            Spacer().frame(height: 50)
            
            Button {
                gameViewModel.running.toggle()
            } label: {
                Text(gameViewModel.running ? "Стоп" : "Крутить")
                    .font(.largeTitle)
            }
            
            ZStack {
                GeometryReader { geometry in
                    let midHeight = geometry.size.height / 2
                    let midWidht = geometry.size.width / 2
                    RoundedRectangle(cornerRadius: 50).stroke()
                        .frame(width: geometry.size.width * 5/6, height: geometry.size.width * 5/6)
                        .position(x: midWidht, y: midHeight)
                    Rectangle()
                        .frame(width: geometry.size.width * 5/6, height: 1)
                        .position(x: midWidht, y: midHeight)
                        .opacity(0.3)
                }
                
                HStack {
                    showLine(line: gameViewModel.leftLine)
                    showLine(line: gameViewModel.middleLine)
                    showLine(line: gameViewModel.rightLine)
                }
                
                if gameViewModel.winer {
                    Text("W  I  N")
                    .background(Color.white)
                    .opacity(0.7)
                    .foregroundColor(.green)
                    .font(.system(size: 80))
                }
            }
        }
    }
    
    func showLine(line: [Pick]) -> some View {
        return VStack {
            ForEach(line) { item in
                Text(item.value).font(.largeTitle).padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
