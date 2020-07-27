import Foundation

@available(OSX 10.13, *)
struct TestProcess {
	/// Returns path to the built products directory.
	static var productsDirectory: URL {
		#if os(macOS)
		guard let bundle = Bundle.allBundles.first(where: { $0.bundlePath.hasSuffix(".xctest") })
		else { fatalError("couldn't find the products directory") }
		return bundle.bundleURL.deletingLastPathComponent()
		#else
		return Bundle.main.bundleURL
		#endif
	}

	/// The current working directory to use for the process
	var currentWorkingDirectory: URL = productsDirectory

	func execute(_ executable: String = "nemid-keycard", arguments: [String]? = nil) throws -> (exitCode: Int32, stdout: String?, stderr: String?) {
		let binary = Self.productsDirectory.appendingPathComponent(executable)

		let process = Process()
		process.currentDirectoryURL = currentWorkingDirectory
		process.executableURL = binary
		process.arguments = arguments

		let stdout = Pipe()
		process.standardOutput = stdout

		let stderr = Pipe()
		process.standardError = stderr

		try process.run()
		process.waitUntilExit()

		return (process.terminationStatus, read(stdout), read(stderr))
	}

	private func read(_ pipe: Pipe) -> String? {
		let data = pipe.fileHandleForReading.readDataToEndOfFile()
		return String(data: data, encoding: .utf8)
	}
}
