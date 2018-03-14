//
//  Command.swift
//  FuckerCore
//
//  Created by Skylar Schipper on 3/7/18.
//

import Foundation

internal enum Command {
    case ptrIncr
    case ptrDec
    case incr
    case decr
    case output
    case input
    case jmpOpen
    case jmpClose

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
