//
//  AppDelegate.swift
//
//  Created by Tyler Hall on 3/12/20.
//  Copyright © 2020 Click On Tyler. All rights reserved.
//

import Cocoa


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    // Just a sample NSMenu for the status bar item
    @IBOutlet weak var statusBarMenu: NSMenu!

    // My apps almost always have both of these window controllers. Substitute with your own.
    lazy var mainWindowController: MainWindowController = { MainWindowController(windowNibName: String(describing: MainWindowController.self)) }()
    lazy var prefsWindowController: PrefsWindowController = { PrefsWindowController(windowNibName: String(describing: PrefsWindowController.self)) }()

    let statusItem = MenuBarStatusItem()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        registerDefaults()

        Constants.getHostname()

        NSApp.registerForRemoteNotifications(matching: .init(rawValue: 0))


        #if MAS
        setupForMASBuild()
        #endif

        // The menubar status item is enabled by default, but
        // it isn't visible until you set a title or image.
        // statusItem.setTitle("Hello!")
        // statusItem.setImageNamed("something")
        //
        // A menu can be set to appear when the item is clicked.
        // statusItem.setMenu(statusBarMenu)

        showMainWindow(nil)
    }

    // Perform any tasks that are specific to Mac App Store builds.
    func setupForMASBuild() {
        #if MAS

        #endif
    }

    // This is called when our Dock icon is clicked (among other cases).
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        showMainWindow(nil)
        return true
    }

    // Populates UserDefaults with the initial default settings for your app.
    // Those values will come from the Defaults.plist in the app bundle.
    func registerDefaults() {
        var defaults: [String: Any] = [:]

        if let defaultsPath = Bundle.main.path(forResource: "Defaults", ofType: "plist") {
            if let dict = NSDictionary(contentsOfFile: defaultsPath) as? [String: Any] {
                defaults.merge(dict: dict)
            }
        }

        // You can use this opportunity to insert any default values that need
        //  to be computed at runtime and thus can't be stored in Defaults.plist.
        let computedDefaults: [String: Any] = [:]
        defaults.merge(dict: computedDefaults)

        UserDefaults.standard.register(defaults: defaults)
    }

    // If your app receives push notifications or uses CloudKit, they'll arrive here.
    func application(_ application: NSApplication, didReceiveRemoteNotification userInfo: [String : Any]) {

    }
}

extension AppDelegate {

    @IBAction func showMainWindow(_ sender: AnyObject?) {
        mainWindowController.showWindow(sender)
    }

    @IBAction func showPrefs(_ sender: AnyObject?) {
        prefsWindowController.showWindow(sender)
    }
}

// Placeholders to be customized for each app...
extension AppDelegate: NSMenuDelegate, NSMenuItemValidation {

    func menu(_ menu: NSMenu, update item: NSMenuItem, at index: Int, shouldCancel: Bool) -> Bool {
        return true
    }

    func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
        return true
    }
}
