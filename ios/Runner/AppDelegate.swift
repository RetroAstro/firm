import UIKit
import Flutter
import LeanCloud

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    do {
        LCApplication.logLevel = .all
        try LCApplication.default.set(
            id: "1cIw2YEkzc9XnGewUjk8IWFs-gzGzoHsz",
            key: "dVv2tRIqPRRgObkWp0wbuQuu",
            serverURL: "https://1ciw2yek.lc-cn-n1-shared.com")
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    } catch {
        fatalError("\(error)")
    }
  }
}
