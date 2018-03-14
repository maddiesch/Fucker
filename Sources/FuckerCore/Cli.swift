//
//  Cli.swift
//  FuckerPackageDescription
//
//  Created by Skylar Schipper on 3/13/18.
//

import Foundation

public class Cli {
    public struct Arguments {
        public let unnamed: Array<String>
        public let named: Dictionary<String, String>

        fileprivate init(_ unnamed: Array<String>, _ named: Dictionary<String, String>) {
            self.unnamed = unnamed
            self.named = named
        }
    }

    
    public static func parseArguments(_ args: Array<String>) -> Arguments {
        var unnamed: Array<String> = []
        var named: Dictionary<String, String> = [:]

        var name: String? = nil

        for arg in args {
            if let last = name {
                named[last] = arg
                name = nil
            } else if arg.hasPrefix("-") {
                name = arg
            } else {
                unnamed.append(arg)
            }
        }

        return Arguments(unnamed, named)
    }
}
