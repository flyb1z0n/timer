//
//  timerApp.swift
//  timer
//
//  Created by Kostiantyn Shavrukov on 10.07.2022.
//

import SwiftUI

@main
struct timerApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        WindowGroup {
            EmptyView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
    
    private var statusItem: NSStatusItem!
    private var timer: Timer!
    private var count: Int = 0
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        if let window = NSApplication.shared.windows.first {
            window.close()
        }
        
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        updateRemainingTime(remainsSec: -1)
        setupMenus()
    }
    
    func setupMenus() {
        // 1
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "50:00", action: #selector(start50minTimer) , keyEquivalent: "1"))
        
        menu.addItem(NSMenuItem(title: "10:00", action: #selector(start10minTimer) , keyEquivalent: "2"))
        
        menu.addItem(NSMenuItem.separator())
        
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        statusItem.menu = menu
    }
    
    private func changeStatusBarButton(number: Int) {
        if let button = statusItem.button {
            
            button.image = NSImage(systemSymbolName: "\(number).circle", accessibilityDescription: number.description)
        }
    }
    
    @objc func start50minTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
    }
    
    @objc func start10minTimer() {
        
    }
    
    func updateRemainingTime(remainsSec: Int) {
        if let button = statusItem.button {
            if (remainsSec < 0) {
                button.title = "--:--"
                return;
            }
            button.title = "\(remainsSec)"
        }
    }
    
    
    // must be internal or public.
    @objc func update() {
        // Something cool
        print(self.count)
        updateRemainingTime(remainsSec: count)
        self.count += 1
    }
    
    func playFinishNotification() {
        NSSound(named: NSSound.Name("Glass"))?.play()
    }
}

