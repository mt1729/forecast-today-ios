# forecast-today-ios

### Internal dependencies
  - Env vars
    - `.xcconfig`
  - Networking
    - Foundation (`URLSession`) - iOS 7.0+
  - Concurrency
    - Combine (`Publisher / Subscriber / Future`) - iOS 13.0 + 
    - Foundation (`DispatchQueue`) - iOS 8.0+
  - Dependency injection
    - SwiftUI (`@StateObject`) - iOS 14.0+
    - SwiftUI (`@EnvironmentObject`) - iOS 13.0+
  - Memory analysis / leaks
    - Xcode (`Debug Memory Graph`) 
    - Instruments (`Allocations / Leaks / Zombies`)

### External dependencies (may need updates)
  - Package manager
    - CocoaPods
  - Static analysis / linting
    - SwiftLint

### TODO
  - (`async` / `await` / `actor`) - Swift 5.5+