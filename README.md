# Currency Converter

Currency converter from Ruble based on the Central Bank of Russia's API. Minimalist iOS application for tracking up-to-date currency exchange rates.

## 1. Design & UI/UX
The application features a custom interface with full support for both **Light and Dark modes**. The UI was designed in Figma, utilizing a structured color system, design tokens, and modern visual elements (such as liquid glass styling) to ensure a seamless visual experience across both theme transitions. 
* **[View Figma Design Mockup](https://www.figma.com/design/BzVQMXbPNZJaABuic6brRi/Currency-%D1%81onverter?node-id=0-1&t=geFylUHvQGRyjjZG-1)**

## 2. Tech Stack & Architecture
* **Hybrid Interface:** Built with SwiftUI and UIKit. Complex UI components (such as `UICollectionView` for the currency list and custom `UIView` elements) are written in UIKit and seamlessly integrated into SwiftUI using wrappers.
* **Architecture:** Implements the MVVM pattern utilizing the Combine framework (`@Published`, `ObservableObject`) for reactive data binding.

## 3. Concurrency & Networking
* **Multithreading:** Powered by modern Swift Concurrency using `async/await` and `Task` for asynchronous network requests. Safe UI updates are ensured by context inheritance, `@MainActor` isolation, and `DispatchQueue.main`.
* **API Integration:** Fetches live daily exchange rates from an open JSON API ([cbr-xml-daily.ru](https://www.cbr-xml-daily.ru/daily_json.js)). The raw JSON data is fetched via `URLSession` and safely parsed into strongly typed Swift models using the `Decodable` protocol and custom `CodingKeys`.

## 4. Roadmap
* Add micro-interactions and smooth UI animations.
* Implement a dedicated `DetailView` screen to display in-depth information for each selected currency.

## 5. Screenshots

### Dashboard & Conversion
| Main Dashboard (Light) | Main Dashboard (Dark) |
| :---: | :---: |
| <img width="1206" height="2622" alt="2" src="https://github.com/user-attachments/assets/e385fa72-29f6-4127-8a13-1f14a86f3df8" /> | <img width="1206" height="2622" alt="2d" src="https://github.com/user-attachments/assets/e1c77abf-2c6f-4f3c-9249-666cf4ffa1c9" /> |
| The main application screen featuring a user-friendly conversion interface and a list of popular currencies. | Seamless dark mode integration based on custom design tokens. |

| Selected Currency (Light) | Selected Currency (Dark) |
| :---: | :---: |
| <img width="1206" height="2622" alt="7" src="https://github.com/user-attachments/assets/fb690d67-42ad-4653-83df-71edeb07e2fd" /> | <img width="1206" height="2622" alt="7d" src="https://github.com/user-attachments/assets/1a9d8509-cd60-45af-9c29-ff8d58af8c05" /> |
| Visual emphasis on the selected base currency for quick navigation within the interface. | Crisp contrast of typography and color elements in dark mode. |

| Active Input (Light) | Active Input (Dark) |
| :---: | :---: |
| <img width="1206" height="2622" alt="8" src="https://github.com/user-attachments/assets/0564d7d1-978c-4657-bd70-b75c2b58527e" /> | <img width="1206" height="2622" alt="8d" src="https://github.com/user-attachments/assets/dc9d1901-ff85-47ee-a1d2-57d2a1cb57b4" /> |
| Instant, real-time exchange rate calculation directly while entering the amount via the keyboard. | Native adaptation of the system keyboard and input fields to the active theme. |

### Search & Navigation
| Currency Selection (Light) | Currency Selection (Dark) |
| :---: | :---: |
| <img width="1206" height="2622" alt="3" src="https://github.com/user-attachments/assets/bcef1c0d-2a82-4ae4-a9f7-28d94929aba0" /> | <img width="1206" height="2622" alt="3d" src="https://github.com/user-attachments/assets/48377308-c459-46a3-bd56-afb9fcd9bf03" /> |
| A convenient modal window displaying a complete list of available currencies, national flags, and country codes. | A well-thought-out element hierarchy that maintains readability on a dark background. |

| Search Activation (Light) | Search Activation (Dark) |
| :---: | :---: |
| <img width="1206" height="2622" alt="4" src="https://github.com/user-attachments/assets/56abd1e5-680a-408a-85c8-8f6dd2a78a64" /> | <img width="1206" height="2622" alt="4d" src="https://github.com/user-attachments/assets/f83ddfbb-77af-4606-b21a-93519c461f27" /> |
| Quick access to the search bar for navigating through dozens of available exchange rates. | Smooth animation of the input focus appearance. |

| Live Filtering "USA" (Light) | Live Filtering "USA" (Dark) |
| :---: | :---: |
| <img width="1206" height="2622" alt="5" src="https://github.com/user-attachments/assets/6aadddb0-e015-4f2b-bb00-64642f345227" /> | <img width="1206" height="2622" alt="5d" src="https://github.com/user-attachments/assets/e019def2-72c2-48f5-b573-6dd36152eff1" /> |
| Dynamic, on-the-fly filtering of results as the country name is typed. | Zero interface lag during search operations thanks to an optimized architecture. |

| Live Filtering "Eu" (Light) | Live Filtering "Eu" (Dark) |
| :---: | :---: |
| <img width="1206" height="2622" alt="6" src="https://github.com/user-attachments/assets/c233aeb2-158a-4fb2-a305-2882121b8dc9" /> | <img width="1206" height="2622" alt="6d" src="https://github.com/user-attachments/assets/f32780a6-5217-472d-a645-cb1d78c62da8" />/> |
| Intelligent search recognizing partial matches by names and currency tickers. | Instant updating of the results table. |

### Tab Navigation & Edge Cases
| All Currencies Tab (Light) | All Currencies Tab (Dark) |
| :---: | :---: |
| <img width="1206" height="2622" alt="9" src="https://github.com/user-attachments/assets/6e719680-6882-43d8-a08e-6f68e38129e0" /> | <img width="1206" height="2622" alt="9d" src="https://github.com/user-attachments/assets/5ca75f61-d3b5-4b45-8ac1-66a80cd51493" /> |
| A dedicated navigation tab for browsing the global list of all supported currencies. | Strict alignment of icons and text for a clean visual experience. |

| Network Error (Light) | Network Error (Dark) |
| :---: | :---: |
| <img width="1206" height="2622" alt="1" src="https://github.com/user-attachments/assets/20403047-9325-4ba3-97d2-fac07a68327e" /> | <img width="1206" height="2622" alt="1d" src="https://github.com/user-attachments/assets/997c5231-4fef-440a-8c51-346bca133585" /> |
| Elegant handling of network unavailability with a manual data reload button. | Preservation of the overall application aesthetics even in critical error states. |
