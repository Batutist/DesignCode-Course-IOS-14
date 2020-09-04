//
//  CoursesView.swift
//  DesignCodeCourse
//
//  Created by Sergey Kovalev on 8/25/20.
//

import SwiftUI

struct CoursesView: View {
    
    @State var isShow = false
    @State var selectedCourse: Course? = nil
    @State var isCourseDisabled = false
    @Namespace var namespace
    
    var body: some View {
        ZStack {
            #if os(iOS)
            content
                .navigationBarHidden(true)
            fullContent
                .background(VisualEffectBlur().edgesIgnoringSafeArea(.all))
                .navigationBarHidden(true)
            
            #else
            content
            fullContent
                .background(VisualEffectBlur().edgesIgnoringSafeArea(.all))
                .navigationTitle("Courses")
            #endif
        }
    }
    
    @ViewBuilder
    var content: some View {
        ScrollView {
            
            VStack {
                Text("Courses")
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 50, leading: 16, bottom: 0, trailing: 0))
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 16)], spacing: 16) {
                    ForEach(courses) { course in
                        VStack {
                            CourseItem(course: course)
                                .matchedGeometryEffect(id: course.id, in: namespace, isSource: !isShow)
                                .frame(height: 200)
                                .onTapGesture {
                                    withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                                        isShow.toggle()
                                        selectedCourse = course
                                        isCourseDisabled = true
                                    }
                                }
                                .disabled(isCourseDisabled)
                        }
                        .matchedGeometryEffect(id: "container\(course.id)", in: namespace, isSource: !isShow)
                    }
                }
                .padding(16)
                .frame(maxWidth: .infinity)
                
                Text("Latest sections")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 16)
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 240))]) {
                    ForEach(courseSections) { courseSection in
                        CourseRow(courseSection: courseSection)
                    }
                }
                .padding(.horizontal, 16)
            }
            
            
        }
        .zIndex(1)
    }
    
    @ViewBuilder
    var fullContent: some View {
        if selectedCourse != nil {
            ZStack(alignment: .topTrailing) {
                
                CourseDetail(course: selectedCourse!, namespace: namespace)
                
                CloseButton()
                    .onTapGesture {
                        withAnimation(.spring()) {
                            isShow.toggle()
                            selectedCourse = nil
                            
                            // Can't tap to another course during animation
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                isCourseDisabled = false
                            }
                        }
                    }
                    .padding(16)
            }
            .zIndex(2)
            .frame(maxWidth: 712)
            .frame(maxWidth: .infinity)
        }
    }
}

struct CourseView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
            .previewDevice("iPhone 11")
    }
}
