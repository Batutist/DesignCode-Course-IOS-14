//
//  CourseView.swift
//  DesignCodeCourse
//
//  Created by Sergey Kovalev on 8/25/20.
//

import SwiftUI
import UIKit

struct CourseView: View {
    
    @State var isShow = false
    @State var selectedCourse: Course? = nil
    @State var isCourseDisabled = false
    @Namespace var namespace
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(courses) { course in
                        CourseItem(course: course)
                            .matchedGeometryEffect(id: course.id, in: namespace, isSource: !isShow)
                            .frame(width: 380, height: 250)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    isShow.toggle()
                                    selectedCourse = course
                                    isCourseDisabled = true
                                }
                            }
                            .disabled(isCourseDisabled)
                    }
                }
                .frame(maxWidth: .infinity)
            }
            
            if selectedCourse != nil {
                ScrollView {
                    
                    CourseItem(course: selectedCourse!)
                        .matchedGeometryEffect(id: selectedCourse!.id, in: namespace)
                        .frame(height: 300)
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
                    
                    VStack {
                        ForEach(0 ..< 20) { item in
                            CourseRow()
                        }
                    }
                    .padding()
                }
                .background(Color.themeBackgroundColor1)
                .transition(
                    .asymmetric(
                        insertion: AnyTransition
                            .opacity
                            .animation(
                                Animation.spring().delay(0.3)),
                        removal: AnyTransition
                            .opacity
                            .animation(.spring())
                    )
                )
                .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

struct CourseView_Previews: PreviewProvider {
    static var previews: some View {
        CourseView()
            .previewDevice("iPhone 11")
    }
}
