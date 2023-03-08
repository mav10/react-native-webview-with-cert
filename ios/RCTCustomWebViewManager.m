//
//  RCTCustomWebViewManager.m
//  WebviewWithCert
//
//  Created by Maxim Vasin on 08.03.2023.
//  Copyright © 2023 Facebook. All rights reserved.
//

#import "RCTCustomWebViewManager.h"
#import "RCTCustomWebView.h"

@interface RCTCustomWebViewManager () <RNCWebViewDelegate>

@end

@implementation RCTCustomWebViewManager { }

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
  RCTCustomWebView *webView = [RCTCustomWebView new];
  webView.delegate = self;
  
    NSBundle *bundle = [NSBundle mainBundle];
    
    NSMutableDictionary* certMap = [NSMutableDictionary new];

    NSData *rootCertData = [NSData dataWithContentsOfFile:[bundle pathForResource:@"certificate" ofType:@"der"]];

    SecCertificateRef certificate = SecCertificateCreateWithData(NULL, (CFDataRef) rootCertData);
     
    OSStatus err = SecItemAdd((CFDictionaryRef) [NSDictionary dictionaryWithObjectsAndKeys:(id) kSecClassCertificate, kSecClass, certificate, kSecValueRef, nil], NULL);
    
    [certMap setObject:(__bridge id _Nonnull)(certificate) forKey:@"sberbank.ru"];
    [certMap setObject:(__bridge id _Nonnull)(certificate) forKey:@"www.sberbank.ru"];
    
    [RCTCustomWebView setCustomCertificatesForHost:certMap];
    [RNCWebView setCustomCertificatesForHost:certMap];
    
    return webView;
}

@end
