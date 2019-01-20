//
//  Parser.swift
//  FuckerCore
//
//  Created by Maddie Schipper on 3/7/18.
//

internal final class Parser {
    private static let characters: Array<Character> = [">", "<", "+", "-", ".", ",", "[", "]"]

    internal static func parse(_ string: String) throws -> Array<Character> {
        var output: Array<Character> = []
        string.forEach { (char) in
            if Parser.characters.contains(char) {
                output.append(char)
            }
        }
        return output
    }

    internal static func program(_ characters: Array<Character>) throws -> Array<Command> {
        var program: Array<Command> = []
        for char in characters {
            let cmd = try Command(char)
            program.append(cmd)
        }
        return program
    }
}
