import Foundation
import FuckerCore

let args = Cli.parseArguments(ProcessInfo.processInfo.arguments)

var program = args.named["--program"]

if program == nil {
    guard args.unnamed.count >= 2 else {
        print("No program input")
        exit(EXIT_FAILURE)
    }

    let input = args.unnamed.last!

    if let url = URL(string: input) {
        guard url.isFileURL else {
            print("Found a valid URL that doesn't point to a file")
            exit(EXIT_FAILURE)
        }
        let abs = URL(fileURLWithPath: "\(url.host ?? "")\(url.path)")
        do {
            program = try String(contentsOf: abs)
        } catch {
            print("Failed to find input file \(error.localizedDescription)")
            exit(EXIT_FAILURE)
        }
    } else {
        program = input
    }
}


guard let prog = program else {
    print("Failed to load program")
    exit(EXIT_FAILURE)
}

do {
    let output = try Interpreter.run(prog)
    print(output)
    exit(EXIT_SUCCESS)
} catch {
    print(error)
    exit(EXIT_FAILURE)
}
