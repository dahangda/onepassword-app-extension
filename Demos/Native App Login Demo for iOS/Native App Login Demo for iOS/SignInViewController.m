//
//  SignInViewController.m
//  1Password Extension Demo
//
//  Created by Rad on 2014-07-14.
//  Copyright (c) 2014 AgileBits. All rights reserved.
//

#import "SignInViewController.h"
#import "OnePasswordExtension.h"

@interface SignInViewController ()

@property (weak, nonatomic) IBOutlet UIButton *onepasswordSigninButton;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation SignInViewController

-(void)viewDidLoad {
	[self.onepasswordSigninButton setHidden:![[OnePasswordExtension sharedExtension] isAppExtensionAvailable]];
}

#pragma mark - Actions

- (IBAction)findLoginFrom1Password:(id)sender {
	__weak typeof (self) miniMe = self;
	[[OnePasswordExtension sharedExtension] findLoginForURLString:@"https://www.acme.com" forViewController:self completion:^(NSDictionary *loginDict, NSError *error) {
		if (!loginDict) {
			NSLog(@"Error invoking 1Password App Extension for find login: %@", error);
			return;
		}
		
		__strong typeof(self) strongMe = miniMe;
		strongMe.usernameTextField.text = loginDict[AppExtensionUsernameKey];
		strongMe.passwordTextField.text = loginDict[AppExtensionPasswordKey];
	}];
}

@end
