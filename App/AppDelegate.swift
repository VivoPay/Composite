//
//  AppDelegate.swift
//  SCE-Mac
//
//  Created by Ronald "Danger" Mannak on 8/1/18.
//  Copyright © 2018 A Puzzle A Day. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

//    var preferencesController: PreferencesWindowController? = nil

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        if UserDefaults.standard.bool(forKey: UserDefaultStrings.doNotShowDependencyWizard.rawValue) == false {
            showInstallWizard()
        } else {
            showChooseTemplate(self)
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    
//    @IBAction func showPreferences(_ sender: Any) {
//        
//        if preferencesController == nil {
//            let storyboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Preferences"), bundle: nil)
//            preferencesController = storyboard.instantiateInitialController() as? PreferencesWindowController
//        }
//        
//        if let preferencesController = preferencesController {
//            preferencesController.showWindow(sender)
//        }
//    }
    
    func showInstallWizard() {
        let installToolchainStoryboard = NSStoryboard(name: NSStoryboard.Name("InstallToolchain"), bundle: nil)
        let installWizard = installToolchainStoryboard.instantiateInitialController() as? NSWindowController
        installWizard?.showWindow(self)
    }
    
    @IBAction func showChooseTemplate(_ sender: Any) {
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Template"), bundle: nil)
        let templateController = storyboard.instantiateInitialController() as? NSWindowController
        templateController?.showWindow(sender)
    }
    
    
    override init() {
        
        // register default setting values
        let defaults = DefaultSettings.defaults.mapKeys { $0.rawValue }
        UserDefaults.standard.register(defaults: defaults)
        NSUserDefaultsController.shared.initialValues = defaults
        
        // instantiate DocumentController
        _ = DocumentController.shared
        
        // wake text finder up
        _ = TextFinder.shared
        
        // register transformers
        ValueTransformer.setValueTransformer(HexColorTransformer(), forName: HexColorTransformer.name)
        
        super.init()
    }
    
}

// CotEditor extension
extension AppDelegate {
    
    /// open a specific page in Help contents
    @IBAction func openHelpAnchor(_ sender: AnyObject) {
        
        guard let identifier = (sender as? NSUserInterfaceItemIdentification)?.identifier else { return assertionFailure() }
        
        NSHelpManager.shared.openHelpAnchor(identifier.rawValue, inBook: Bundle.main.helpBookName)
    }

    
    
}
