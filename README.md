# swift-nemid-keycard

A convenience CLI application and Swift library for managing test versions of NemID.

Note that this code should only be used with test versions of NemID. There are practically no security built in. For non-test versions, please use only the official NemID solutions.

## How to use the CLI tool

To install the binary, perform the following steps:

1. Clone the code or download the latest version from the GitHub releases page.
2. From the downloaded folder, do `make && make install`.

## How to import the library

1. Add the GitHub URL as a dependency:
	```swift
	Package(
	  name: "MyPackage",
	  products: [
	    .library(name: "MyPackage", targets: ["MyPackage"]),
	  ],
	  dependencies: [
	    .package(url: "https://github.com/fizker/swift-nemid-keycard.git", .upToNextMinor("0.1.0")),
	  ],
	  targets: [
	    .target(
	      name: "MyPackage",
	      dependencies: [
	        .product(name: "NemIDKeycard", package: "swift-nemid-keycard"),
	      ]
	    ),
	  ]
	)
	```
2. Import the package where needed:
	```swift
	import NemIDKeycard
	````
