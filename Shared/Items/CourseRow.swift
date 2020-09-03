//
//  CourseRow.swift
//  DesignCodeCourse
//
//  Created by Sergey Kovalev on 8/25/20.
//

import SwiftUI

struct CourseRow: View {
    var courseSection: CourseSection = courseSections[0]
    
    var body: some View {
        
        HStack(alignment: .top) {
            
            Image(courseSection.logo)
                .imageScale(.large)
                .frame(width: 48, height: 48)
                .background(courseSection.color)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(courseSection.title)
                    .font(.subheadline)
                    .bold()
                Text(courseSection.subtitle)
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
