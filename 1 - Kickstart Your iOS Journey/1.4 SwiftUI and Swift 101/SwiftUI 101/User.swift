//
//  User.swift
//  SwiftUI 101
//
//  Created by Paul Solt on 12/26/24.
//


import SwiftUI

@Observable // Observation Framework
class User { // Object
    var name: String

    init(name: String) {
        self.name = name
    }
    
    func sayHello() -> String {
        return "Hi, I'm \(name)"
    }
}

struct ClassesView: View {
    @State private var user1 = User(name: "Alice")
    @State private var user2 = User(name: "Alice")

    var body: some View {
        VStack {
            Text(user1.sayHello())
            Text("User2: \(user2.sayHello())")
                .bold()
            Text("Are user1 and user2 the same? \(user1 === user2 ? "Yes" : "No")")
            Text("Are user1 and user2 the same value? \(user1.name == user2.name ? "Yes" : "No")")
            NameView(user: user2)
                .textFieldStyle(.roundedBorder)
        }
        .padding()
    }
}

struct NameView: View {
    @State var user: User

    var body: some View {
        TextField("Name", text: $user.name)
    }
}

#Preview("Classes (I)") {
    ClassesView()
}
