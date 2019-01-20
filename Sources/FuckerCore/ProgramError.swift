//
//  ProgramError.swift
//  FuckerCore
//
//  Created by Maddie Schipper on 3/7/18.
//


/// An error thrown by the interpreter.
public struct ProgramError : Error {
    public enum Severity : Int {
        case fatal       = 0
        case recoverable = 1
    }

    public let severity: Severity
    public let code: Int
    public let message: String

    internal init(_ message: String, code: Int = 0, severity: Severity = .fatal) {
        self.message = message
        self.code = code
        self.severity = severity
    }
}
