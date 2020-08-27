//
//  CourseRow.swift
//  DesignCodeCourse
//
//  Created by Sergey Kovalev on 8/25/20.
//

import SwiftUI

struct CourseRow: View {
    var body: some View {
        HStack(alignment: .top) {
            
            Image(systemName: "paperplane.circle.fill")
                .imageScale(.large)
                .frame(width: 48, height: 48)
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text("SwiftUI")
                    .font(.subheadline)
                    .bold()
                Text("Description")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
    }
}

struct CourseRow_Previews: PreviewProvider {
    static var previews: some View {
        CourseRow()
    }
}
