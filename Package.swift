// swift-tools-version:5.2

import PackageDescription

let package = Package(
	name: "nemid-keycard",
	products: [
		.library(
			name: "nemid-keycard",
			targets: ["nemid-keycard"]
		),
	],
	dependencies: [
	],
	targets: [
		.target(
			name: "nemid-keycard",
			dependencies: []
		),
		.testTarget(
			name: "nemid-keycardTests",
			dependencies: ["nemid-keycard"]
		),
	]
)
