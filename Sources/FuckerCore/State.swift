fileprivate let MaxPointer = 255

internal class State {
    private var ptr: Int = 0
    internal private(set) var output: Array<Character> = []
    private var buffer: Array<UInt8> = Array(repeating: 0, count: MaxPointer)

    func increment() throws {
        guard self.buffer[self.ptr] < UInt8.max else {
            throw ProgramError("OOB: Tried to increment the pointer at \(self.ptr)")
        }
        self.buffer[self.ptr] += 1
    }

    func decrement() throws {
        guard self.buffer[self.ptr] > 0 else {
            throw ProgramError("OOB: Tried to decrement the value at \(self.ptr) below 0")
        }
        self.buffer[self.ptr] -= 1
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
}
