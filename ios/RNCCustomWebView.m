//
//  RCTCustomWebView.m
//  WebviewWithCert
//
//  Created by Maxim Vasin on 08.03.2023.
//  Copyright © 2023 Facebook. All rights reserved.
//

#import "RNCCustomWebView.h"
#import "RNCWebView+Custom.h"

@interface RNCCustomWebView ()

@end

@implementation RNCCustomWebView { }

- (void)                    webView:(WKWebView *)webView
  didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
                  completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable))completionHandler
{

    if (challenge.protectionSpace.serverTrust != nil) {
        NSBundle *bundle = [NSBundle mainBundle];
        
        NSMutableDictionary* certMap = [NSMutableDictionary new];

        NSData *rootCertData = [NSData dataWithContentsOfFile:[bundle pathForResource:@"certificate" ofType:@"der"]];

        SecTrustSetAnchorCertificates(challenge.protectionSpace.serverTrust, (CFDataRef) rootCertData);
        SecTrustSetAnchorCertificatesOnly(challenge.protectionSpace.serverTrust, true);
        
        SecTrustRef trust = [[challenge protectionSpace] serverTrust];
        NSURLCredential *useCredential = [NSURLCredential credentialForTrust:trust];
        completionHandler(NSURLSessionAuthChallengeUseCredential, useCredential);
    } else {
        return completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
    }
    
    
    BOOL chellangessss = true;
}

//- (void)webView:(__unused UIWebView *)webView didReceive:(URLAuthenticationChallenge *)chelange
// navigationType:(UIWebViewNavigationType)navigationType
//{
//  BOOL allowed = [super webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
//
//  return allowed;
//}

@end

