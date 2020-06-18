// swift-tools-version:5.2

import PackageDescription

let package = Package(
	name: "swift-nemid-keycard",
	products: [
		.library(
			name: "NemIDKeycard",
			targets: ["NemIDKeycard"]
		),
		.executable(
			name: "nemid-keycard",
			targets: ["nemid-keycard"]
		),
	],
	dependencies: [
		.package(url: "https://github.com/apple/swift-argument-parser.git", .upToNextMinor(from: "0.1.0")),
	],
	targets: [
		.target(
			name: "nemid-keycard",
			dependencies: [ "CLI" ]
		),
		.target(
			name: "CLI",
			dependencies: [
				"NemIDKeycard",
				.product(name: "ArgumentParser", package: "swift-argument-parser"),
			]
		),
		.target(
			name: "NemIDKeycard",
			dependencies: []
		),

		.testTarget(
			name: "nemid-keycardTests",
			dependencies: [
				"nemid-keycard",
			]
		),
		.testTarget(
			name: "CLITests",
			dependencies: ["CLI"]
		),
		.testTarget(
			name: "NemIDKeycardTests",
			dependencies: ["NemIDKeycard"]
		),
	]
)
