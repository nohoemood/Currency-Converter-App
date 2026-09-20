# Currency Converter

A minimalist iOS application for tracking up-to-date currency exchange rates.

## Tech Stack & UI
* **Hybrid Interface:** Built with SwiftUI and UIKit. Complex UI components (such as `UICollectionView` for the currency list and custom `UIView` elements) are written in UIKit and seamlessly integrated into SwiftUI using wrappers.
* **Architecture:** Implements the MVVM pattern utilizing the Combine framework (`@Published`, `ObservableObject`) for reactive data binding.

## Concurrency & Networking
* **Multithreading:** Powered by modern Swift Concurrency using `async/await` and `Task` for asynchronous network requests. Safe UI updates are ensured by context inheritance, `@MainActor` isolation, and `DispatchQueue.main`.
* **API Integration:** Fetches live daily exchange rates from an open JSON API ([cbr-xml-daily.ru](https://www.cbr-xml-daily.ru/daily_json.js)). The raw JSON data is fetched via `URLSession` and safely parsed into strongly typed Swift models using the `Decodable` protocol and custom `CodingKeys`.

## Roadmap
* Add micro-interactions and smooth UI animations.
* Implement a dedicated `DetailView` screen to display in-depth information for each selected currency.
