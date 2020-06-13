import ArgumentParser

public struct Program: ParsableCommand {
	public static var configuration = CommandConfiguration(
		commandName: "nemid-keycard",
		abstract: "A utility for working with NemID keycards",
		subcommands: [
			CreateDummyData.self,
			CreateKeycard.self,
			ListIdentities.self,
			ListKeycards.self,
			PollKeycard.self,
		],
		defaultSubcommand: PollKeycard.self
	)

	public init() {
	}
}
