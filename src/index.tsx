import React, { Component } from 'react';
import { NativeModules, requireNativeComponent } from 'react-native';
import WebView from 'react-native-webview';

const { CustomWebViewManager } = NativeModules;

export default class CustomWebView extends Component {
  render() {
    return (
      <WebView
        {...this.props}
        nativeConfig={{
          component: RCTCustomWebView,
          viewManager: CustomWebViewManager,
        }}
      />
    );
  }
}

const RCTCustomWebView = requireNativeComponent<any>('RNCCustomWebView') as any;
