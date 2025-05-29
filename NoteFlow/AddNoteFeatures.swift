//
//  AddNoteFeatures.swift
//  NoteFlow
//
//  Created by Kushvinth Madhavan on 26/05/25.
//

import SwiftUI

struct AddNoteFeatures: View {
    var title: String
    var symbolName: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.clear)
                .background(Material.regular)
                .frame(minWidth: 0, maxWidth: .infinity,
                       minHeight: 0, maxHeight: .infinity,
                       alignment: .center)
                .aspectRatio(40/10, contentMode: .fit)
                .clipped()
                .mask {
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .padding(.horizontal)
                }
            
            HStack {
                Image(systemName: symbolName)
                    .padding()
                    .background {
                        Circle()
                            .fill(Color(.tertiaryLabel))
                    }
                    .padding(.leading)
                
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.callout)
                        .bold()
                        .foregroundStyle(.white)
                }
                
                Spacer()
            }
            .padding(.all)
        }
    }
}
