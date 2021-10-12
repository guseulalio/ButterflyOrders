//
//  CapsuleButton.swift
//  ButterflyOrders
//
//  Created by Gustavo E M Cabral on 12/10/21.
//

import SwiftUI

struct CapsuleButton: View {
	var title: String
	var action: () -> Void
	var backgroundColor: Color
	var width: CGFloat?
	
    var body: some View {
		Button(action: action) {
			Text(title)
				.frame(minWidth: width==nil ? width! : 0)
				.padding(.horizontal, 12).padding(.vertical, 6)
				.background(backgroundColor).foregroundColor(.white)
				.clipShape(Capsule())
		}
    }
}

struct CapsuleButton_Previews: PreviewProvider {
    static var previews: some View {
		CapsuleButton(title: "Show me", action: {}, backgroundColor: .yellow, width: 100)
    }
}
