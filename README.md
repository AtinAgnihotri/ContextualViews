# Contextual Views

My experiment with showing a dynamic list of view that is rendered using json from an API.

The belle of the ball here is ContextView which is a resuable component that you can plug and play anywhere.

It uses the response fetched from an API to dynamically create and display a list of cards, the idea being, to used this to dynamically card list / homepage for a user.

The App is implemented in MVVM-C pattern

### 🍎 Tech Used:

- 🍎 SwiftUI
- 💾 User Defaults (for Persistence)
- 🌐 URLSession (Webservice)
- 📜 Codable (Serielization/Deserielization)

### Third Party Libraies Used:

- 🗃️ CachedAsyncImage: A Custom implementation on AsyncImage that supports caching. Check out it's github <a href="https://github.com/lorenzofiamingo/SwiftUI-CachedAsyncImage">here</a>

### Known Issues:

- There's an issue with the custom Roboto font not getting correctly to the build phase targets, thus not behaving correctly with fontWeights, The workaround I've gone for now is a fallback to system font, specially in cards where there's a need for ajbect difference in font weight.
