import OpenAPIURLSession

public struct ChannelsDataSource {
    public init() {
        //
    }

    public func channels() async throws -> [Channel] {
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )

        let response = try await client.getChannels(query: .init(format: .json))
        let channelsResponse = try response.ok.body.json
        return channelsResponse.channels.map { dto in
            Channel(id: dto.id, name: dto.name)
        }
    }
}
