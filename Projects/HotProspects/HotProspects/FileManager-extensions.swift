//
//  FileManager-getDocumentsDirectory.swift
//  HotProspects
//
//  Created by Geoffrie Maiden Mueller on 12/22/21.
//

import Foundation

extension FileManager {
    /**
     * Returns location of the file-system documents folder for the app. This directory is generated
     * by the device and is not guaranteed to be the same path on two different devices.
     */
    func getDocumentsDirectory() -> URL {
        let paths = self.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
