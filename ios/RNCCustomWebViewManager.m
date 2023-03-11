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

RCT_EXPORT_VIEW_PROPERTY(customUrl, NSString)
RCT_EXPORT_MODULE()

-(void)installCerts {
    // Get the bundle where the certificates in DER format are present.
      NSBundle *bundle = [NSBundle mainBundle];
      
      NSMutableDictionary* certMap = [NSMutableDictionary new];

      NSData *rootCertData = [NSData dataWithContentsOfFile:[bundle pathForResource:@"certificate" ofType:@"der"]];

      SecCertificateRef certificate = SecCertificateCreateWithData(NULL, (CFDataRef) rootCertData);
       
      OSStatus err = SecItemAdd((CFDictionaryRef) [NSDictionary dictionaryWithObjectsAndKeys:(id) kSecClassCertificate, kSecClass, certificate, kSecValueRef, nil], NULL);
      
      [certMap setObject:(__bridge id _Nonnull)(certificate) forKey:@"sberbank.com"];

      [RNCWebView setCustomCertificatesForHost:certMap];
}

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
