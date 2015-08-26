//
//  EventViewController.m
//  The Knights Club
//
//  Created by 姚远 on 8/1/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import "EventViewController.h"

@interface EventViewController (){
    CGRect screenRect;
    NSURLRequest * homeRequest;
    
    UIActivityIndicatorView * progressView;
}

@end

@implementation EventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initAllVars];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)hitMenu:(id)sender {
    [self performSegueWithIdentifier:@"eventToMenu" sender:self];
}
- (IBAction)hitCart:(id)sender {
    [self performSegueWithIdentifier:@"eventToCart" sender:self];
}
- (IBAction)hitMe:(id)sender {
    [self performSegueWithIdentifier:@"eventToMe" sender:self];
}
- (IBAction)hitHome:(id)sender {
    NSLog(@"URL:%@", _contentWebView.request.URL);
    [_contentWebView loadRequest:homeRequest];
}
- (IBAction)hitBack:(id)sender {
    [_contentWebView goBack];
}

-(void) configToolBar{
    CGFloat buttonWidth = screenRect.size.width/4;
    CGFloat buttonHeight = 60;
    
    
    
    _menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, buttonHeight)];
    [_menuButton addTarget:self action:@selector(hitMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_menuButton setBackgroundImage: [UIImage imageNamed:@"kc_menu_tbi"] forState:UIControlStateNormal];
    [_toolBarView addSubview:_menuButton];
    
    _cartButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonWidth, 0, buttonWidth, buttonHeight)];
    [_cartButton addTarget:self action:@selector(hitCart:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([KCItemListHandler cartIsEmpty] ==YES) {
        [_cartButton setBackgroundImage: [UIImage imageNamed:@"kc_cart_tbi"] forState:UIControlStateNormal];
    }else{
        [_cartButton setBackgroundImage: [UIImage imageNamed:@"kc_fcart_tbi"] forState:UIControlStateNormal];
    }
    
    [_toolBarView addSubview:_cartButton];
    
    
    ///////----------------------------
    _eventButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonWidth *2, 0, buttonWidth, buttonHeight)];
    [_eventButton addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    
    
    [_eventButton setBackgroundImage: [UIImage imageNamed:@"kc_event_sel"] forState:UIControlStateNormal];
    [_toolBarView addSubview:_eventButton];
    
    ///////----------------------------
    
    _meButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonWidth*3, 0, buttonWidth, buttonHeight)];
    [_meButton addTarget:self action:@selector(hitMe:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_meButton setBackgroundImage: [UIImage imageNamed:@"kc_me_tbi"] forState:UIControlStateNormal];
    [_toolBarView addSubview:_meButton];
    
    
    
}


-(void) closeFatherController{
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void) initAllVars{
    if (_dismissFatherViewDelegate) {
        [_dismissFatherViewDelegate closeFatherController];
    }
    homeRequest =[[NSURLRequest alloc] initWithURL: [NSURL URLWithString: @"https://www.facebook.com/TheKnightClubGU?_rdr=p"] cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    [_contentWebView loadRequest:homeRequest];
    
    screenRect = [[UIScreen mainScreen] bounds];
    
    
    progressView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];

    [progressView setCenter:CGPointMake(screenRect.size.width/2.0, screenRect.size.height/2.0)]; // I do this because I'm in landscape mode
    [self.view addSubview:progressView];
    [progressView startAnimating];
    
    [self configToolBar];
    
    
    
    UIImageView * backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    backgroundImageView.image = [UIImage imageNamed:@"Background"];
    [self.view insertSubview:backgroundImageView atIndex:0];

    
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [progressView stopAnimating];
    
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"eventToMenu"]) {
        MenuViewController * mvc = (MenuViewController *) [segue destinationViewController];
        mvc.closeControllerDelegate =self;
    }else if ([segue.identifier isEqualToString:@"eventToCart"]){
        CartViewController * cvc = (CartViewController *) [segue destinationViewController];
        cvc.dismisViewDelegate = self;
    }else if ([segue.identifier isEqualToString:@"eventToMe"]){
        CustomerViewController *ctvc = (CustomerViewController *) [segue destinationViewController];
        ctvc.dismisViewDelegate = self;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
