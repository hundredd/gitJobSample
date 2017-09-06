//
//  EnumHeader.h
//  特种车调度
//
//  Created by 韩学鹏 on 16/5/16.
//
//

#ifndef EnumHeader_h
#define EnumHeader_h

#define kNotifyDispatchType_OwnerRushOrder @"kNotifyDispatchType_OwnerRushOrder"
#define kNotifyDispatchType_OwnerRevokeOrder @"kNotifyDispatchType_OwnerRevokeOrder"
#define kNotifyDispatchType_OwnerOrderStart @"kNotifyDispatchType_OwnerOrderStart"
#define kNotifyDispatchType_OwnerReachSite  @"kNotifyDispatchType_OwnerReachSite"
#define kNotifyDispatchType_DispatcherRevokeOrder   @"kNotifyDispatchType_DispatcherRevokeOrder"
#define kNotifyDispatchType_DispatcherStartOrder    @"kNotifyDispatchType_DispatcherStartOrder"
#define kNotifyDispatchType_Cash    @"kNotifyDispatchType_Cash"
#define kNotifyDispatchType_ReviewCarSuccess    @"kNotifyDispatchType_ReviewCarSuccess"
#define kNotifyDispatchType_ReviewCarFailt  @"kNotifyDispatchType_ReviewCarFailt"
#define kNotifyDispatchType_DispatcherRushOrder @"kNotifyDispatchType_DispatcherRushOrder"
#define kNotifyDispatchType_SendOrder   @"kNotifyDispatchType_SendOrder"
#define kNotifyDispatchType_SitePushOrder   @"kNotifyDispatchType_SitePushOrder"
#define kNotifyDispatchType_SitePay     @"kNotifyDispatchType_SitePay"
#define kNotifyDispatchType_OwnerRequestPay     @"NotifyDispatchType_OwnerRequestPay"


#define kNearby_distance 90000

typedef enum : NSUInteger {
    NotifyDispatchType_OwnerRushOrder = 1,   //司机抢单提醒 1
    NotifyDispatchType_OwnerRevokeOrder = 2,        //司机取消订单提醒 2
    NotifyDispatchType_OwnerOrderStart = 3,              //订单开始提醒 3
    NotifyDispatchType_OwnerReachSite = 4,               //司机到站提醒 4
    NotifyDispatchType_DispatcherRevokeOrder = 6,       //站点撤销订单 6
    NotifyDispatchType_DispatcherStartOrder = 7,        //订单开始提醒 7
    NotifyDispatchType_Cash = 8,                        //提现成功 8
    NotifyDispatchType_ReviewCarSuccess = 9,               //车辆审核通过 9
    NotifyDispatchType_ReviewCarFailt = 10,              //车辆审核失败 10
    NotifyDispatchType_DispatcherRushOrder = 13,         //站点抢单提醒 13
    NotifyDispatchType_SendOrder = 14,                   //企业派单 14
    NotifyDispatchType_SitePushOrder =15,               //站点派单 15
    NotifyDispatchType_SitePay = 16,                        //站点支付提醒 16
    NotifyDispatchType_OwnerRequestPay = 17                  //司机请求结算提醒  17
    
} NotifyDispatchType;

#endif /* EnumHeader_h */
