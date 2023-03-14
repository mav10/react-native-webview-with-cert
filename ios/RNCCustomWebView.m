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
    SecTrustRef serverTrust = [[challenge protectionSpace] serverTrust];
    if (serverTrust == nil) {
        // Default handling
        return completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
    }

    bool localCheck = [self checkValidity:serverTrust];
    if (localCheck) {
        // Allow custom certificate
        NSURLCredential *useCredential = [NSURLCredential credentialForTrust:serverTrust];
        completionHandler(NSURLSessionAuthChallengeUseCredential, useCredential);
    } else {
        // Default handling
        return completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
    }
}

- (BOOL) checkValidity:(SecTrustRef)serverTrust {
    CFArrayRef certificates = [self prepareCertificates];

    SecTrustSetAnchorCertificates(serverTrust, certificates);
    SecTrustSetAnchorCertificatesOnly(serverTrust, true);

    CFErrorRef *error = nil;
    if (@available(iOS 12.0, *)) {
        bool isTrusted = SecTrustEvaluateWithError(serverTrust, error);
        
        return isTrusted;
    } else {
        // Fallback on earlier versions
        return false;
    }
}

- (CFArrayRef) prepareCertificates {
    CFArrayRef anchorCerts = CFArrayCreateMutable(NULL, 2, &kCFTypeArrayCallBacks);
    
    @try {
        SecCertificateRef _Nullable rootCa = [self loadCertificate:@"certificate"];
        CFArrayAppendValue(anchorCerts, rootCa);
    } @catch (NSException *exception) {
        NSLog(@"Root certifcate was not found");
    }
    
    @try {
        SecCertificateRef _Nullable subCa = [self loadCertificate:@"certificate_sub"];
        CFArrayAppendValue(anchorCerts, subCa);
    } @catch (NSException *exception) {
        NSLog(@"Sub certifcate was not found");
    }

    return anchorCerts;
}

- (SecCertificateRef __nullable) loadCertificate:(NSString*)name {
    @try {
        NSString * caDerFilePath = [[NSBundle mainBundle] pathForResource:name ofType:@"der"];
        NSData *derCA = [NSData dataWithContentsOfFile:caDerFilePath];
        
        if (!derCA) {
            return nil;
        }
        
        
        SecCertificateRef caRef = SecCertificateCreateWithData(NULL, (__bridge CFDataRef)derCA);
        return caRef;
    } @catch (NSException *exception) {
        return nil;
    }
}

@end

