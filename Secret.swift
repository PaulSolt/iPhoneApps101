//
//  Secret.swift
//  Created by Paul Solt on 1/23/25.
//

/// ## Secret.swift Instructions
/// This file is designed to be copied and renamed "Secret.swift". If this file or Secret.swift is missing you will
/// have a build issue because there is a build step that will copy this file template if it is missing.
/// `Secret.swift` is ignored by the .gitignore file, so that you can set your API key without accidentally
/// sharing credentials.
///
/// ## Why?
/// This code is in a public repository (iPhone Apps 101 Course Code), so I do not want to accidentally share
/// my API key with the world. If you have a private repository you do not need to do this, unless you plan to
/// make it open source. Other nefarious "actors" or bots can steal your API key if it's in the open and use the
/// key to access services. This could rack up a huge bill if it isn't a "Free Trial" key.
///
/// ## How?
/// The project is using a Buildable folder to automatically add a code file to the build system. In prior versions
/// of Xcode you always had to manage all the files in the project, but new in Xcode 16 you can have a folder
/// where any code added will get compiled and included with your app target. This is useful, and allows the
/// script to either copy the file automatically, or you to copy it.

// MARK: - OpenWeather API Key
// Create an OpenWeather account and enter your API Key here
// 1. Create an account: https://home.openweathermap.org/users/sign_up
// 2. Copy your key from: https://home.openweathermap.org/api_keys
// 3. Don't post this publically on Github

let weatherAPIKey = "CHANGE_ME"
