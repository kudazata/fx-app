# FX App
This is a simple currency coversion tool that allows a user to get the exchange rate between 2 selected currencies and if historical data is available it shows a graph displaying the changes over the last 30 days
It is built using a combination of UIKit and SwiftUI as well as MVVM architecture
It makes use of data from https://fxmarketapi.com/

## Preview
https://github.com/user-attachments/assets/bd643f23-c71f-497f-87e4-10244e49c927

## How to run the app
1. git clone https://github.com/kudazata/fx-app
2. Navigate to the project folder and open `Fx App.xcworkspace`
3. Create an account on https://fxmarketapi.com/ and obtain an API key
4. Locate the file `AppConfig.sample.xcconfig` and rename it to `AppConfig.xcconfig`
5. In `AppConfig.xcconfig` replace `<YOUR_API_KEY>` with the API key obtained above
6. Go to the project settings, select the **Info** tab, and assign `AppConfig.xcconfig` to the appropriate build configurations (e.g., Debug, Release).
7. Run the app on a simulator or device
