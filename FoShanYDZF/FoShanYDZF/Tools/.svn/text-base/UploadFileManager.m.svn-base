//
//  UploadFileManager.m
//  BoandaProject
//
//  Created by 张仁松 on 13-10-16.
//  Copyright (c) 2013年 szboanda. All rights reserved.
//

#import "UploadFileManager.h"
#import "ServiceUrlString.h"
#import "ASIFormDataRequest.h"

@interface UploadFileManager()
@property(nonatomic,retain) ASIFormDataRequest * request;
@end

@implementation UploadFileManager
@synthesize fileFields,filePath,serviceType,delegate,request,myProgressView;

-(id)init{
    self = [super init];
    if(self){
        self.serviceType = @"UPLOAD_FILE";
        
    }
    return self;
}

-(void)commitFile{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setObject:serviceType forKey:@"service"];
    NSString *strUrl = [ServiceUrlString generateUrlByParameters:params];
    
    NSURL *url =[ NSURL URLWithString :strUrl];
    //NSURL *url =[ NSURL URLWithString : @"http://localhost:8080/test/UploadServlet" ];
    self.request = [ ASIFormDataRequest requestWithURL : url ];

   // NSStringEncoding enc= CFStringConvertEncodingToNSStringEncoding ( kCFStringEncodingMacChineseSimp );
   // [ request setStringEncoding :enc];
    

    [ request setPostValue :fileFields forKey : @"FILE_FIELDS" ];
   
    [ request setFile :filePath forKey :[filePath lastPathComponent] ];
    
    [ request setDelegate : self ];
    [request setUploadProgressDelegate:myProgressView];
    [ request setDidFinishSelector : @selector ( responseComplete )];
    [ request setDidFailSelector : @selector (responseFailed)];
    
    
    
    
    [ request startSynchronous ];
}

-( void )responseComplete{
  
    [delegate uploadFileSuccess:YES];

}

-( void )respnoseFailed{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [delegate uploadFileSuccess:NO];
}
@end
