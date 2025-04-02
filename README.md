# Latimove - Swift Location Manager Package

Latimove is a lightweight and customizable **Location Manager** package for Swift, designed to handle location updates efficiently while providing a simple API for developers. This package ensures smooth location tracking with background update support.

## Features
✅ Singleton instance for easy access  
✅ Customizable location accuracy & distance filter  
✅ Background location updates support
✅ Delegates & Closures for location updates, errors, and permission changes  
✅ Thread-safe with `DispatchQueue.main.async`  
✅ macOS compatibility checks  

## Installation

### Swift Package Manager (SPM)
1. Open **Xcode**.
2. Go to **File** > **Add Packages**.
3. Enter the repository URL:
   ```
   https://github.com/your-username/Latimove.git](https://github.com/vandana-7span/Latimove
   ```
4. Choose a version and click **Add Package**.

## Usage

### 1️⃣ Import the Package
```swift
import Latimove
```

### 2️⃣ Configure Latimove
```swift
Latimove.shared.configure(
    desiredAccuracy: kCLLocationAccuracyNearestTenMeters,
    distanceFilter: 50,
    requestAlwaysAuthorization: false
)
```

### 3️⃣ Request Permissions & Start Tracking
```swift
Latimove.shared.requestPermission()
Latimove.shared.startUpdatingLocation()
```

### 4️⃣ Handle Location Updates & Errors
```swift
Latimove.shared.onLocationUpdate = { location in
    print("Updated Location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
}

Latimove.shared.onError = { error in
    print("Location Error: \(error.localizedDescription)")
}

Latimove.shared.onPermissionChange = { status in
    print("Permission Status: \(status)")
}
```

## Delegate Implementation (Optional)
If you prefer **delegate-based** handling, implement the `LatimoveDelegate`:

```swift
class LocationHandler: LatimoveDelegate {
    func didUpdateLocation(_ location: CLLocation) {
        print("Delegate - Location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
    }
    
    func didFailWithError(_ error: Error) {
        print("Delegate - Error: \(error.localizedDescription)")
    }
    
    func didChangeAuthorization(status: CLAuthorizationStatus) {
        print("Delegate - Permission: \(status)")
    }
}

let handler = LocationHandler()
Latimove.shared.delegate = handler
```

## Compatibility
✅ **iOS 11.0+**  
❌ Not available for macOS (Excludes restricted APIs)

## License
Latimove is available under the **MIT License**. Feel free to use and modify it for your projects.

## Contributing
Contributions are welcome! Feel free to submit issues or pull requests to improve Latimove.

---

# Latimove
