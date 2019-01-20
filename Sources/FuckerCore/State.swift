//
//  State.swift
//  FuckerCore
//
//  Created by Maddie Schipper on 3/7/18.
//

fileprivate let MaxPointer = 255

internal class State {
    private var ptr: Int = 0
    internal private(set) var output: Array<Character> = []
    private var buffer: Array<UInt8> = Array(repeating: 0, count: MaxPointer + 1)

    func increment() throws {
        if self.buffer[self.ptr] == UInt8.max {
            self.buffer[self.ptr] = 0
        } else {
            self.buffer[self.ptr] += 1
        }
    }

    func decrement() throws {
        if self.buffer[self.ptr] > 0 {
            self.buffer[self.ptr] -= 1
        } else {
            self.buffer[self.ptr] = UInt8.max
        }
    }

    func movr() throws {
        self.ptr += 1
        guard self.ptr <= MaxPointer else {
            throw ProgramError("OOB: Tried to increase the pointer past it's maximum \(MaxPointer)")
        }
    }

    func movl() throws {
        self.ptr -= 1
        guard self.ptr >= 0 else {
            throw ProgramError("OOB: Tried to decrement the pointer past 0")
        }
    }

    func write() throws {
        let char = Character(UnicodeScalar(self.buffer[self.ptr]))
        self.output.append(char)
    }

    func read() throws -> UInt8 {
        return self.buffer[self.ptr]
    }
    
    func dump(_ offset: Int) {
        let padding = Array(repeating: " ", count: offset).joined(separator: "")
        var line = 0
        var cur = 0
        var buffered = ""
        var values: Array<Character> = []
        
        print("\(padding)pointer: \(self.ptr)")
        
        let prt: () -> Void = {
            let lineNum = String(format: "%02d", line)
            print("\(padding)\(lineNum): \(buffered)    [\(String(values).literalized())]")
        }
        
        while (cur <= MaxPointer) {
            if (cur % 16 == 0 && cur != 0) {
                prt()
                buffered = ""
                values = []
                line += 1
            }
            let value = self.buffer[cur]
            if value == 0 {
                values.append(".")
            } else {
                let char = Character(UnicodeScalar(value))
                values.append(char)
            }
            buffered += String(format: "%02X ", value)
            cur += 1
        }
        prt()
    }
}


fileprivate extension String {
    static let escapeSequences = [
        (original: "\0", escaped: "\\0"),
        (original: "\\", escaped: "\\\\"),
        (original: "\t", escaped: "\\t"),
        (original: "\n", escaped: "\\n"),
        (original: "\r", escaped: "\\r"),
        (original: "\"", escaped: "\\\""),
        (original: "\'", escaped: "\\'"),
    ]
    func literalized() -> String {
        return String.escapeSequences.reduce(self) { string, seq in
            string.replacingOccurrences(of: seq.original, with: seq.escaped)
        }
    }
}
