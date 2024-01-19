import Data

public struct ChannelsDataSourceMock: ChannelsDataSource {
    public func channels() async throws -> [Channel] {
        return []
    }
}
