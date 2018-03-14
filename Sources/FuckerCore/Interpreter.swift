//
//  Parser.swift
//  FuckerCore
//
//  Created by Skylar Schipper on 3/7/18.
//

public class Interpreter {
    private let state: State
    private let program: Array<Command>
    private var cursor: Int = 0

    private init(_ program: Array<Command>) {
        self.program = program
        self.state = State()
    }

    public static func run(_ string: String) throws -> String {
        let rawInput = try Parser.parse(string)
        let program = try Parser.program(rawInput)
        let interpreter = Interpreter(program)
        try interpreter.run()
        return String(interpreter.state.output)
    }

    private func run() throws {
        while self.cursor < self.program.count {
            let command = self.program[self.cursor]
            switch command {
            case .incr:
                try self.state.increment()
                self.cursor += 1
            case .decr:
                try self.state.decrement()
                self.cursor += 1
            case .ptrIncr:
                try self.state.movr()
                self.cursor += 1
            case .ptrDec:
                try self.state.movl()
                self.cursor += 1
            case .input:
                fatalError("Fucker currently doesn't support input")
            case .output:
                try self.state.write()
                self.cursor += 1
            case .jmpOpen:
                if try self.state.read() == 0 {
                    self.jumpForward()
                } else {
                    self.cursor += 1
                }
            case .jmpClose:
                self.jumpBack()
            }
        }
    }

    private func jumpForward() {
        var tmp = self.cursor
        var offset = 0
        while tmp < self.program.count {
            tmp += 1
            let cmd = self.program[tmp]
            if cmd == .jmpOpen {
                offset += 1
            } else if cmd == .jmpClose {
                if offset == 0 {
                    self.cursor = tmp + 1
                    break
                } else {
                    offset -= 1
                }
            }
        }
    }

    private func jumpBack() {
        var tmp = self.cursor
        var offset = 0
        while tmp > 0 {
            tmp -= 1
            let cmd = self.program[tmp]
            if cmd == .jmpClose {
                offset += 1
            } else if cmd == .jmpOpen {
                if offset == 0 {
                    self.cursor = tmp
                    break
                } else {
                    offset -= 1
                }
            }
        }
    }
}

