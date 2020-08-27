//
//  CourseList.swift
//  DesignCodeCourse
//
//  Created by Sergey Kovalev on 8/26/20.
//

import SwiftUI

struct CourseList: View {
    @ViewBuilder
    var body: some View {
        #if os(iOS)
        component
            .listStyle(InsetGroupedListStyle())
        #else
        component
            .frame(minWidth: 800, minHeight: 600)
        #endif
    }
    
    private var component: some View {
        List(0 ..< 20) { item in
            CourseRow()
        }
        .navigationTitle("Courses")
    }
}

struct CourseList_Previews: PreviewProvider {
    static var previews: some View {
        CourseList()
    }
}
