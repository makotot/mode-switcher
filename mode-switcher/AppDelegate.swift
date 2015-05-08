//
//  AppDelegate.swift
//  mode-switcher
//
//  Created by tateno on 2015/05/08.
//  Copyright (c) 2015 makotot. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    
    let statusBarItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    let menu = NSMenu()
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        
        self.statusBarItem.title = "Mode"
        self.statusBarItem.highlightMode = true
        self.statusBarItem.menu = menu
        
        var menuItem = NSMenuItem()
        
        menuItem.title = "Toggle Mode"
        menuItem.action = Selector("toggleMode:")
        menu.addItem(menuItem)
        
        menuItem = NSMenuItem()
        
        menuItem.title = "Quit"
        menuItem.action = Selector("quitApp:")
        menu.addItem(menuItem)
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

    func toggleMode (sender : AnyObject?) {
        var mode = NSUserDefaults.standardUserDefaults().stringForKey("AppleInterfaceStyle") ?? "Light"
        var nextMode : NSString = ""
        
        if (mode == "Light") {
            nextMode = "Dark"
        } else {
            nextMode = "Light"
        }
        println(mode)
        
        var notificationCenter : CFString! = "AppleInterfaceThemeChangeNotification" as NSString
        var notificationObject : UnsafePointer<Void> = nil
        var notificationUserInfo : CFDictionary! = nil
        var notificationImmidiately : Boolean = 1
        
        CFPreferencesSetValue("AppleInterfaceStyle", nextMode, kCFPreferencesAnyApplication, kCFPreferencesCurrentUser, kCFPreferencesCurrentHost)
        CFNotificationCenterPostNotification(CFNotificationCenterGetDistributedCenter(), notificationCenter, notificationObject, notificationUserInfo, notificationImmidiately)
    }
    
    func quitApp (sender : AnyObject?) {
        NSApplication.sharedApplication().terminate(self)
    }

}
