//
//  ContentView.swift
//  SwiftUITallColorPillars
//
//  Created by Isaac Raval on 6/12/20.
//  Copyright © 2020 Isaac Raval. All rights reserved.
//

import SwiftUI
import DynamicColor
import ExyteGrid

struct ContentView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            VStack {
                MyView()
            }
            .frame(minWidth: 3000, maxWidth: .infinity, minHeight: 900, idealHeight: 900, maxHeight: 2000, alignment: .center)
        }
    }
}

struct MyView: View {
    @State var colors: [Color] = [
        Color(hex: 0x7FB3D5), Color(hex: 0x512E5F), Color(hex: 0x45B39D), Color(hex: 0xF4D03F), Color(hex: 0x3498db),
        
        Color(hex: 0x7FB3D5), Color(hex: 0x512E5F), Color(hex: 0x45B39D), Color(hex: 0xF4D03F), Color(hex: 0x3498db),
        
        Color(hex: 0x7FB3D5), Color(hex: 0x512E5F), Color(hex: 0x45B39D), Color(hex: 0xF4D03F), Color(hex: 0x3498db),
    ]
    @State var tracks_ = [GridTrack.pt(100),GridTrack.pt(100),GridTrack.pt(100)]
    @State var tappedLoaction: Int = -1
    @State var tapped:Bool = false
    var body: some View {
        
        Grid(0..<colors.count, tracks: tracks_) {idx in
            VStack {
                SingleItem(idx: idx, colors: self.$colors, tapped: self.$tapped)
            }
            .rotationEffect(.degrees(self.tapped ? 0 : 8))
            .rotation3DEffect(Angle(degrees: self.tapped ? 0 : -40), axis: (x: self.tapped ? 0 : 0, y: self.tapped ? 0 : 5, z: self.tapped ? 0 : 2))
            .offset(y: (self.tappedLoaction != idx && self.tapped) ? 1700 : 0)
            .onTapGesture {
                self.tappedLoaction = (self.tappedLoaction != idx)  ? idx : -1
                self.tapped.toggle()
            }
            .animation(.interpolatingSpring(mass: 0.01, stiffness: 0.1, damping: 0.1, initialVelocity: 0.1))
        }
            
        .onAppear() {
            self.tracks_ = [GridTrack](repeating: GridTrack.pt(150), count: self.colors.count)
        }
    }
}

struct SingleItem: View {
    var idx: Int
    @Binding var colors: [Color]
    @Binding var tapped:Bool
    
    //    @State private var dragPos = CGPoint(x: 50, y: 50)
    
    var body: some View {
        Group {
            Circle()
                .fill(self.colors[idx])
                .frame(width: tapped ? 600 : 100, height: 100, alignment: .leading)
            Text(self.colors[idx].description)
            self.colors[idx]
        }
    //        Enable free-form drag:
    //        .position(dragPos)
    //        .gesture(DragGesture().onChanged({ value in
    //            self.dragPos = value.location
    //        }))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
