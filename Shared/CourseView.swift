//
//  CourseView.swift
//  DesignCodeCourse
//
//  Created by Sergey Kovalev on 8/25/20.
//

import SwiftUI

struct CourseView: View {
    
    @State var isShow = false
    @Namespace var namespace
    
    private let cardID = "Card"
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(courses) { course in
                        CourseItem(course: course)
                            .matchedGeometryEffect(id: course.id, in: namespace, isSource: !isShow)
                            .frame(width: 380, height: 250)
                    }
                }
                .frame(maxWidth: .infinity)
            }
            
            if isShow {
                ScrollView {
                    
                    CourseItem()
                        .matchedGeometryEffect(id: courses[3].id, in: namespace)
                        .frame(height: 300)
                    
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
        .onTapGesture {
            withAnimation(.spring()) {
                isShow.toggle()
            }
        }
    }
}

struct CourseView_Previews: PreviewProvider {
    static var previews: some View {
        CourseView()
            .previewDevice("iPhone SE (2nd generation)")
    }
}
