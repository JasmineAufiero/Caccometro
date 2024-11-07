//
//  AddButtonView.swift
//  BonVoyage
//
//  Created by Jasmine Aufiero on 19/10/24.
//

import SwiftUI

struct AddButtonView: View {
    var action: ()->()
    @State var isSelected = false
        var body: some View {
            
            Image(systemName: "plus.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 30.0, height: 30.0, alignment: .trailing)
                .foregroundColor(isSelected ? .black : .white)
                .onTapGesture {
                    withAnimation {
                        isSelected.toggle()
                        action()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            isSelected.toggle()
                        }
                    }
                }
        }
}

#Preview {
    AddButtonView(action: {
        print("Hello, World!")
    })
}
