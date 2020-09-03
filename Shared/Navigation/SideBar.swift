//
//  SideBar.swift
//  DesignCodeCourse
//
//  Created by Sergey Kovalev on 8/25/20.
//

import SwiftUI

struct SideBar: View {
    @ViewBuilder
    var body: some View {
        NavigationView {
            
            #if os(iOS)
            component
                .navigationTitle("Learn")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {}, label: {
                            Image(systemName: "person.crop.circle")
                        })
                    }
                }
            #else
            component
                .frame(minWidth: 150, idealWidth: 200, maxWidth: 250)
                .toolbar {
                    ToolbarItem(placement: .automatic) {
                        Button(action: {}, label: {
                            Image(systemName: "person.crop.circle")
                        })
                    }
                }
            #endif
            
            CourseView()
        }
    }
    
    private var component: some View {
        List {
            
            NavigationLink(destination: CourseView()) {
                Label(
                    title: { Text("Courses") },
                    icon: { Image(systemName: "book.closed") }
                )
            }
            
            Label(
                title: { Text("Tutorials") },
                icon: { Image(systemName: "list.bullet.rectangle") }
            )
            Label(
                title: { Text("Live sessions") },
                icon: { Image(systemName: "tv") }
            )
            Label(
                title: { Text("Certificates") },
                icon: { Image(systemName: "mail.stack") }
            )
            Label(
                title: { Text("Search") },
                icon: { Image(systemName: "magnifyingglass.circle") }
            )
        }
        .listStyle(SidebarListStyle())
    }
}

struct SideBar_Previews: PreviewProvider {
    static var previews: some View {
        SideBar()
            .previewDevice("iPhone 11")
    }
}
