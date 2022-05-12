//
//  TopInfoView.swift
//  Ghala
//
//  Created by mroot on 12/05/2022.
//

import SwiftUI

struct TopInfoView: View {
    
    @State var title: String
    @State var description: String
    var body: some View {
        
        VStack(alignment: .center, spacing: 5) {
            Image("logo")
                .resizable()
                .frame(width: 130, height: 120)
                    
            Text(title)
                .font(.title)
                .bold()
                .padding(.top, 30)
                .padding(.bottom, 5)
                    
            Text(description)
                .fontWeight(.light)
                .font(.system(size: 12))
                
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.yellow)
    
    }
}

struct TopInfoView_Previews: PreviewProvider {
    static var previews: some View {
        TopInfoView(title: "Mobile Number", description: "We need to send an OTP to authenticate your number")
    }
}
