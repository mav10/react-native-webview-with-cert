import * as React from 'react';

import { StyleSheet, Text, View } from 'react-native';
import CustomWebView from 'react-native-webview-with-cert';
import WebView from 'react-native-webview';

const url = 'https://www.sberbank.ru';

export default function App() {
  return (
    <View style={styles.container}>
      <Text style={styles.text}>Custom WebView</Text>
      <CustomWebView source={{ uri: url }} />
      <Text style={styles.text}>Basic WebView</Text>
      <WebView source={{ uri: url }} />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    paddingVertical: 20,
    flex: 1,
    borderWidth: 1,
    alignItems: 'stretch',
    justifyContent: 'center',
  },
  text: {
    fontSize: 28,
    fontWeight: 'bold',
    backgroundColor: 'grey',
  },
});
