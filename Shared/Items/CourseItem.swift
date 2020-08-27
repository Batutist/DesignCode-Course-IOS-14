//
//  CourseItem.swift
//  DesignCodeCourse
//
//  Created by Sergey Kovalev on 8/26/20.
//

import SwiftUI

struct CourseItem: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            Spacer()
            
            HStack {
                Spacer()
                Image("Illustration 1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Spacer()
            }
            
            Text("SwiftUI for IOS 14")
                .fontWeight(.bold)
            Text("20 sections")
                .font(.footnote)
        }
        .padding(.all)
        .background(Color.blue)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}

struct CourseItem_Previews: PreviewProvider {
    static var previews: some View {
        CourseItem()
    }
}
