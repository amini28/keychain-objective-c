//
//  ViewController.m
//  KeychainTest
//
//  Created by Amini on 25/10/24.
//

#import "ViewController.h"
#import "KeychainHelper.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *keyTextfield;
@property (weak, nonatomic) IBOutlet UITextField *valueTextField;
@property (weak, nonatomic) IBOutlet UILabel *statusLalbel;
@property (weak, nonatomic) IBOutlet UILabel *returnLabel;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@property (weak, nonatomic) IBOutlet UILabel *getLabel;
@property (weak, nonatomic) IBOutlet UIButton *getButton;
@property (weak, nonatomic) IBOutlet UITextField *keyToGet;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_saveButton addTarget:self action:@selector(actionSave) forControlEvents:UIControlEventTouchUpInside];
    [_deleteButton addTarget:self action:@selector(actionDelete) forControlEvents:UIControlEventTouchUpInside];
    [_getButton addTarget:self action:@selector(actionGet) forControlEvents:UIControlEventTouchUpInside];
}

- (void) actionSave {
    BOOL state = [[KeychainHelper shared]saveObject:_valueTextField.text forKey:_keyTextfield.text];
    NSString * result = state ? @"success" : @"failed";
    _statusLalbel.text = [NSString stringWithFormat:@"saving status : %@", result];
}

- (void) actionDelete {
    BOOL state = [[KeychainHelper shared]deleteObjectForKey:_keyToGet.text];
    NSString * result = state ? @"success" : @"failed";
    _statusLalbel.text = [NSString stringWithFormat:@"deletion status : %@", result];
}

- (void) actionGet {
    NSString* value = [[KeychainHelper shared]loadObjectForKey:_keyToGet.text];
    _getLabel.text = [NSString stringWithFormat:@"result get : %@", value];
    
}



@end
