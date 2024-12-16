# iPhone Apps 101

Demo code and final code for the lessons from iPhone Apps 101 (SwiftUI + REST APIs)

```swift
func fetchWeatherData() {
    guard let url = URL(string: "https://api.example.com/weather/today") else { return }
    URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data, error == nil else { return }
        // <ins>Decode the JSON data into our Weather struct</ins>
        // <del>Just print out the raw JSON for now</del>
        do {
            let weather = try JSONDecoder().decode(Weather.self, from: data)
            print(weather)
        } catch {
            print("Failed to decode JSON:", error)
        }
    }.resume()
}
```
