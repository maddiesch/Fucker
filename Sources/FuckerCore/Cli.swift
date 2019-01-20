//
//  Cli.swift
//  FuckerPackageDescription
//
//  Created by Maddie Schipper on 3/13/18.
//

import Foundation

/// Simple Cli parser for parsing Fucker's arguments
public class Cli {
    
    /// The container for the arguments
    public struct Arguments {
        
        /// An array of all unnamed arguments found.
        public let unnamed: Array<String>
        
        /// A dictionary of all the named arguments found
        public let named: Dictionary<String, String>
        
        fileprivate init(_ unnamed: Array<String>, _ named: Dictionary<String, String>) {
            self.unnamed = unnamed
            self.named = named
        }
    }

    /// Perform parsing of the arguments array
    ///
    /// - Parameters:
    ///   - args: The array of argument strings to be parsed.
    /// - Returns: Arguments
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
