//
//  RCTCustomWebViewManager.m
//  WebviewWithCert
//
//  Created by Maxim Vasin on 08.03.2023.
//  Copyright © 2023 Facebook. All rights reserved.
//

#import "RNCCustomWebViewManager.h"
#import "RNCCustomWebView.h"

@interface RNCCustomWebViewManager () <RNCWebViewDelegate>

@end

@implementation RNCCustomWebViewManager { }

RCT_EXPORT_MODULE()

- (UIView *)view
{   
    RNCCustomWebView *webView = [RNCCustomWebView new];
    webView.delegate = self;

    return webView;
}

- (void)                    webView:(WKWebView *)webView
  didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
                  completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable))completionHandler
{
    BOOL chellangessssuer = true;
}

@end
