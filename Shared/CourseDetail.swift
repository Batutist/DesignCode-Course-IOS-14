//
//  CourseDetail.swift
//  DesignCodeCourse
//
//  Created by Sergey Kovalev on 9/2/20.
//

import SwiftUI


struct CourseDetail: View {
    var course: Course = courses[0]
    var namespace: Namespace.ID
    
    #if os(iOS)
    let cornerRadius: CGFloat = 10
    #else
    let cornerRadius: CGFloat = 0
    #endif
    @State var isShowModal = false
    
    var body: some View {
        #if os(iOS)
        content
            .edgesIgnoringSafeArea(.all)
        #else
        content
        #endif
    }
    
    var content: some View {
        VStack {
            ScrollView {
                CourseItem(course: course, cornerRadius: 0)
                    .matchedGeometryEffect(id: course.id, in: namespace)
                    .frame(height: 300)
                VStack {
                    ForEach(courseSections) { courseSection in
                        CourseRow(courseSection: courseSection)
                            .sheet(isPresented: $isShowModal, content: {
                                CourseSectionDetail()
                            })
                            .onTapGesture {
                                isShowModal.toggle()
                            }
                        Divider()
                    }
                }
                .padding()
            }
        }
        .background(Color.themeBackgroundColor1)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        .matchedGeometryEffect(id: "container\(course.id)", in: namespace)
    }
}

struct CourseDetail_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        CourseDetail(namespace: namespace)
    }
}
