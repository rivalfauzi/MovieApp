# 🎬 MovieApp

A simple iOS application built with Swift that displays movie information using TMDB API. The app supports YouTube trailer playback, reviews, localization, and handles offline scenarios gracefully.

## ✨ Features

1. **Get List of Currently Showing Movies**  
   Fetch and display the list of movies that are currently playing in theaters.

2. **Get List of Upcoming Movies**  
   Discover upcoming movies that will soon be released.

3. **Primary Detail Movie**  
   View detailed information about each movie including title, overview, rating, and production companies.

4. **Movie Reviews**  
   Read user-submitted reviews from the TMDB community.

5. **In-App YouTube Trailer**  
   Watch official trailers directly within the app using embedded YouTube player.

6. **No Connection Handling**  
   Alert and fallback when there is no internet connection. Users are notified and returned safely to the previous screen.

7. **Localized Based on System Language**  
   The app automatically adapts to the user's device language (e.g., English, Indonesian, etc.).

8. **Reactive Programming with RxSwift**  
   All asynchronous operations are managed using **RxSwift** to promote a clean and responsive UI.

---

## ⚖️ RxSwift vs Combine

| Feature                            | RxSwift                                          | Combine                                        |
|------------------------------------|--------------------------------------------------|------------------------------------------------|
| Platform Support                   | iOS 9+ (broad compatibility)                     | iOS 13+ (only newer devices)                   |
| Community and Maturity             | Mature with a large community and resources      | Newer, still growing                           |
| Operator Richness                  | Extensive set of operators                       | Still catching up on certain operators         |
| Integration with Third-party libs  | Wide integration (e.g., Moya, Alamofire, etc.)   | Still limited                                  |
| Learning Curve                     | Steeper due to complexity                        | Easier for newcomers familiar with Apple APIs  |

While RxSwift is still widely used in production apps and offers powerful capabilities, **Combine** is a great choice for new apps that target **iOS 13+** and want to stick with Apple's native frameworks. If your project supports only newer iOS versions, **Combine may be preferable** for tighter system integration.

---

## 🛠 Technologies

- Swift
- RxSwift
- UIKit
- Alamofire
- YouTube iFrame Player API
- TMDB API

---

## 🧪 Requirements

- iOS 13.0+
- Xcode 14+

---

## 📦 Installation

### ✅ Swift Package Manager (SPM)

MovieApp uses [Swift Package Manager](https://swift.org/package-manager/) for dependency management.

#### Add Dependencies

In Xcode:

1. Open your project.
2. Go to **File > Add Packages…**
3. Add the following package URLs:

   - **RxSwift**  
     ```
     https://github.com/ReactiveX/RxSwift.git
     ```
   - **Alamofire**  
     ```
     https://github.com/Alamofire/Alamofire.git
     ```

4. Choose the latest version or set specific version ranges.
5. Click **Add Package**.

---

## 📷 Screenshots

*(Add screenshots of the main features here)*

---

## 🌐 Localization

Currently supports:
- English 🇺🇸
- Bahasa Indonesia 🇮🇩

---

## 📄 License

MIT License. See `LICENSE` file for details.
