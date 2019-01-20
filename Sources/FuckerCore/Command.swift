//
//  Command.swift
//  FuckerCore
//
//  Created by Maddie Schipper on 3/7/18.
//

import Foundation

/// The internal representation of the commands
internal enum Command {
    
    /// Increase the current pointer (<)
    case ptrIncr
    
    /// Decrease the current pointer (>)
    case ptrDec
    
    /// Increment the current value (+)
    case incr
    
    /// Decrement the current value (-)
    case decr
    
    /// Print the current pointer value to the output buffer (.)
    case output
    
    /// Ask for input (,) (Currently unsupported)
    case input
    
    /// Open a jump location ([)
    case jmpOpen
    
    /// Close a jump location (])
    case jmpClose

    
    /// Create a Command from the passed character.
    ///
    /// - Parameters:
    ///   - character: The Character for the command.
    /// - Throws: ProgramError if the command character is unknown.
    init(_ character: Character) throws {
        switch character {
        case "<":
            self = .ptrDec
        case ">":
            self = .ptrIncr
        case "+":
            self = .incr
        case "-":
            self = .decr
        case ".":
            self = .output
        case ",":
            self = .input
        case "[":
            self = .jmpOpen
        case "]":
            self = .jmpClose
        default:
            throw ProgramError("Unknown command \(character)", severity: .recoverable)
        }
    }
}
