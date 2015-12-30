//
//  BackgroundViewController.swift
//  PhotoWatch
//
//  Created by Leah Culver on 5/17/15.
//  Copyright (c) 2015 Dropbox. All rights reserved.
//

import UIKit
import SwiftyDropbox

class BackgroundViewController: UIViewController {
    
    @IBAction func logoutButtonPressed(sender: AnyObject) {

        // Clear the app group of all files
        if let containerURL = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier("group.com.Dropbox.DropboxPhotoWatch") {
            
            // Fetch all files in the app group
            do {
                let fileURLArray = try NSFileManager.defaultManager().contentsOfDirectoryAtURL(containerURL, includingPropertiesForKeys: [NSURLNameKey], options: [])
                
                for fileURL in fileURLArray {
                    // Check that file is a photo (by file extension)
                    if fileURL.absoluteString.hasSuffix(".jpg") || fileURL.absoluteString.hasSuffix(".png") {
                        
                        do {
                            // Delete the photo from the app group
                            try NSFileManager.defaultManager().removeItemAtURL(fileURL)
                        } catch _ as NSError {
                            // Do nothing with the error
                        }
                    }
                }
            } catch _ as NSError {
                // Do nothing with the error
            }
        }
        
        // Unlink from Dropbox
        Dropbox.unlinkClient()
        
        // Dismiss view controller to show login screen
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}