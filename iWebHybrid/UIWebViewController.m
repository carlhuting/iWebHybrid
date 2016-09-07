//
//  ViewController.m
//  iWebHybrid
//
//  Created by lkeg on 16/9/2.
//  Copyright © 2016年 com.lemontree.muzhi. All rights reserved.
//

#import "UIWebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "WebActionHandler.h"


@interface UIWebViewController () <UIWebViewDelegate>
@property (nonatomic, strong) JSContext *jsctx;
@property (nonatomic, strong)  UIWebView *webView;
@end

@implementation UIWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass([self class]);
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"html"];
    self.webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    self.webView.delegate = self;
    
    [self.view addSubview:self.webView];
    self.webView.frame = self.view.frame;
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"..." style:UIBarButtonItemStylePlain target:self action:@selector(itemtapped:)];
    
    self.navigationItem.rightBarButtonItems = @[item];
}

- (void)itemtapped:(UIBarButtonItem *)sender {
    [self.webView stringByEvaluatingJavaScriptFromString:@"showTitle()"];
}

#pragma mark - UIWebView

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"iOS" withExtension:@"js"];
    NSString *js = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    [webView stringByEvaluatingJavaScriptFromString:js];
    self.jsctx =  [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    self.jsctx[@"objc_log"] = ^(NSString *msg) {
        NSLog(msg);
    };
    
    self.jsctx[@"objc_sendMsg"] = ^(NSArray *msg) {
        NSLog(@"sendMsg %@", msg);
    };
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL *url  = request.URL;
    if ([[WebActionHandler shareHandler] handleURL:url]) {
        return NO;
    }
    return YES;
}


#pragma mark - dealloc

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
