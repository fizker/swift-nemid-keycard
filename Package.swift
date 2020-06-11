// swift-tools-version:5.2

import PackageDescription

let package = Package(
	name: "nemid-keycard",
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
	],
	targets: [
		.target(
			name: "nemid-keycard",
			dependencies: ["NemIDKeycard"]
		),
		.target(
			name: "NemIDKeycard",
			dependencies: []
		),
		.testTarget(
			name: "NemIDKeycardTests",
			dependencies: ["NemIDKeycard"]
		),
	]
)
