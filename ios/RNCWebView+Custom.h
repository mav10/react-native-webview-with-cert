//
//  RNCWebView+Custom.h
//  WebviewWithCert
//
//  Created by Maxim Vasin on 12.03.2023.
//  Copyright © 2023 Facebook. All rights reserved.
//

#import <react-native-webview/RNCWebView.h>

@interface RNCWebView (Custom)
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void(^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable))completionHandler;
- (NSMutableDictionary<NSString *, id> *)baseEvent;
@end
