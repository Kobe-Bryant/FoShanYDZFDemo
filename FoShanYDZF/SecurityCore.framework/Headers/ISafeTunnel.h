//
//  ISafeTunnel.h
//  test
//
//  Created by yangli on 11-11-5.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISafeTunnel : NSObject{

    
}
/*初始化安全通道启动配置*/
-(long)initSafeTunnel:(int)intSafeTunnelType;

/*启动安全通道*/
-(void)startSafeTunnel;

/*关闭安全通道*/
-(void)stopSafeTunnel;

/*获取安全通道状态*/
-(int)getSafeTunnelStatus;

/*设置安全通道状态*/
-(long)setSafeTunnelStatus:(int)intStatus;

@end
