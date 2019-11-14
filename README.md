# azurlane-swift
Wrapper for the unofficial azur lane json api in Swift

## Install
Import the library into your Package.swift \
`.package(url: "https://github.com/azurlane-api/azurlane-swift.git", from: "<latest-tag>")`

## Example
```swift
import Foundation
import AzurLane

let azurlane = AzurLane()

azurlane.getShips(from: .RARITY, with: "Super Rare") { (result: Result<ShipsResponse, AzurLaneAPIError>) in
    switch result {
    case .failure(let error):
        print(error)
    case .success(let response):
        for ship in response.ships {
            print("[\(ship.id)]: (\(ship.name))")
        }
    }
}

RunLoop.main.run()
```

## Support
![discord](https://discordapp.com/api/v6/guilds/240059867744698368/widget.png?style=banner2)
