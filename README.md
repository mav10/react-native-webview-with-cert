# react-native-webview-with-cert

It is custom WebView that support providing custom certificats to requests. E.g. if you need to use another root cert as trusted and need open resources under that certs. Common WebView will not open it, that one - can.

## Installation

```sh
npm install react-native-webview-with-cert
```

## Usage

```js
import { WebviewWithCertView } from "react-native-webview-with-cert";

// ...

<WebviewWithCertView color="tomato" />
```

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT

---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)
