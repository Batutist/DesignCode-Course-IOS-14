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
    @Namespace var courseDetailNamespace
    #if os(iOS)
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    #endif
    
    
    var body: some View {
        ZStack {
            #if os(iOS)
            if horizontalSizeClass == .compact {
                tabBar
            } else {
                sideBar
            }
            fullContent
                .background(VisualEffectBlur().edgesIgnoringSafeArea(.all))
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
                        #if os(iOS)
                        NavigationLink(destination: CourseDetail(namespace: courseDetailNamespace)) {
                            CourseRow(courseSection: courseSection)
                        }
                        #else
                        CourseRow(courseSection: courseSection)
                        #endif
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .zIndex(1)
        .navigationTitle("Courses")
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
    
    var tabBar: some View {
        TabView {
            NavigationView {
                content
            }
            .tabItem {
                Image(systemName: "book.closed")
                Text("Courses")
            }
            
            NavigationView {
                CourseList()
            }
            .tabItem {
                Image(systemName: "list.bullet.rectangle")
                Text("Turtorials")
            }
            
            NavigationView {
                CoursesView()
            }
            .tabItem {
                Image(systemName: "tv")
                Text("Livestreams")
            }
            
            NavigationView {
                CoursesView()
            }
            .tabItem {
                Image(systemName: "mail.stack")
                Text("Certificates")
            }
            
            NavigationView {
                CoursesView()
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
            
        }
    }
    
    @ViewBuilder
    var sideBar: some View {
        #if os(iOS)
        NavigationView {
            List {
                NavigationLink(destination: CoursesView()) {
                    Label("Courses", systemImage: "book.closed")
                }
                Label("Tutorials", systemImage: "list.bullet.rectangle")
                Label("Live sessions", systemImage: "tv")
                Label("Certificates", systemImage: "mail.stack")
                Label("Search", systemImage: "magnifyingglass.circle")
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Learn")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}, label: {
                        Image(systemName: "person.crop.circle")
                    })
                }
            }
            content
        }
        #endif
    }
}

struct CourseView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
            .previewDevice("iPhone 11")
    }
}
