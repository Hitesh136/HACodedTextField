//
//  ViewController.m
//  HACodedTextField
//
//  Created by Hitesh Agarwal on 27/03/18.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - UITextField delegates
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    //if string must contains digits
    //Detect if Backspace was pressed
    const char * _char = [string cStringUsingEncoding:NSUTF8StringEncoding];
    int isBackSpace = strcmp(_char, "\b");
    
    if ( [string rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]].location != NSNotFound || isBackSpace == -8 ) {
        
        NSString* oldString = [_txtFieldOTP text];
        
        //check if backspace pressed
        if ( isBackSpace == -8 ) {
            NSInteger index = [oldString rangeOfString: @" _"].location;
            NSString *subString = @"";
            NSString *dashedString = @"";
            if ( oldString.length < index ) {
                subString = [oldString substringToIndex: oldString.length - 1];
            }
            else {
                subString = [oldString substringToIndex: index - 1];
                dashedString = [oldString substringFromIndex: index];
            }
            NSString* newString = [NSString stringWithFormat:@"%@_%@", subString, dashedString];
            _txtFieldOTP.text = newString;
        }
        else {
            NSInteger index = [oldString rangeOfString: @"_"].location;
            if ( oldString.length < index ) {
                return false;
            }
            NSString* subString = [oldString substringFromIndex: index+1];
            NSString* oldSubString = [oldString substringToIndex:index];
            NSString* newString = [NSString stringWithFormat:@"%@%@%@",oldSubString, string, subString];
            _txtFieldOTP.text = newString;
        }
    }
    
    return false;
}
@end
