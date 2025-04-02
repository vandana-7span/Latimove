// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import CoreLocation

#if os(iOS) // Ensure this package only runs on iOS
import UIKit
#endif

public protocol LatimoveDelegate: AnyObject {
    func didUpdateLocation(_ location: CLLocation)
    func didFailWithError(_ error: Error)
    func didChangeAuthorization(status: CLAuthorizationStatus)
}

public final class Latimove: NSObject, CLLocationManagerDelegate, @unchecked Sendable {
    public static let shared = Latimove()

    private let locationManager = CLLocationManager()
    public weak var delegate: LatimoveDelegate?

    public var desiredAccuracy: CLLocationAccuracy = kCLLocationAccuracyBest
    public var distanceFilter: CLLocationDistance = kCLDistanceFilterNone
    public var requestAlwaysAuthorization: Bool = false

    public var onLocationUpdate: ((CLLocation) -> Void)?
    public var onError: ((Error) -> Void)?
    public var onPermissionChange: ((CLAuthorizationStatus) -> Void)?

    private override init() {
        super.init()
        locationManager.delegate = self
    }

    #if os(iOS) // Ensure background updates are set only in iOS
    public var allowsBackgroundUpdates: Bool = false {
        didSet {
            locationManager.allowsBackgroundLocationUpdates = allowsBackgroundUpdates
        }
    }
    #endif

    public func configure(
        desiredAccuracy: CLLocationAccuracy,
        distanceFilter: CLLocationDistance,
        requestAlwaysAuthorization: Bool
    ) {
        self.desiredAccuracy = desiredAccuracy
        self.distanceFilter = distanceFilter
        self.requestAlwaysAuthorization = requestAlwaysAuthorization
    }

    public func requestPermission() {
          DispatchQueue.main.async {
              #if os(iOS) // Ensure these methods are only called on iOS
              if self.requestAlwaysAuthorization {
                  self.locationManager.requestAlwaysAuthorization()
              } else {
                  self.locationManager.requestWhenInUseAuthorization()
              }
              #endif
          }
      }

    public func startUpdatingLocation() {
        DispatchQueue.main.async {
            self.locationManager.desiredAccuracy = self.desiredAccuracy
            self.locationManager.distanceFilter = self.distanceFilter
            self.locationManager.startUpdatingLocation()
        }
    }

    public func stopUpdatingLocation() {
        DispatchQueue.main.async {
            self.locationManager.stopUpdatingLocation()
        }
    }

    // MARK: - CLLocationManagerDelegate

    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        DispatchQueue.main.async {
            self.delegate?.didUpdateLocation(location)
            self.onLocationUpdate?(location)
        }
    }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        DispatchQueue.main.async {
            self.delegate?.didFailWithError(error)
            self.onError?(error)
        }
    }

    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        DispatchQueue.main.async {
            self.delegate?.didChangeAuthorization(status: status)
            self.onPermissionChange?(status)
        }
    }
}
