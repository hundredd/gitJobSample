//
//  ServerPathConstants.h
//  特种车调度
//
//  Created by 韩学鹏 on 16/4/25.
//
//

#ifndef ServerPathConstants_h
#define ServerPathConstants_h

//服务器地址(域名)
//#define kServerPath @"http://123.56.205.193:10000/"   //小办公室服务器
//#define kServerPath @"http://192.168.199.205:8080/"    //张老师
//#define kServerPath @"http://218.244.149.155:8080/"     //外网测试服务器
#define kServerPath @"http://113.57.155.226:9631/"  //源锦汇接口测试
//百度LBS云
//附近
#define k_BaiduLBS_Nearby @"http://api.map.baidu.com/geosearch/v3/nearby"
//查找指定POI
#define k_BaiduLBS_Local @"http://api.map.baidu.com/geosearch/v3/local"

//网络请求超时时间
#define k_HttpTimeout 30.0f

//车主端更新poi信息间隔时间
#define k_OwnerUpdatePOI_TimeInterval 30.0f

//接口地址宏定义

//#define kInterfacePath @"specialVehicles2/resources/"
#define kImagePath @"specialVehicles2"
#define kInterfacePath @"api/"

//商城
#define GCB_ @"http://112.74.216.44/gcbwx/gcb_login.jsp"
//检查版本升级
#define App_CheckVersion @"app/store/checkVersion"
//接口
//获取验证码
#define k_ObtainVCode @"app/obtainVCode"
//检查验证码
#define k_CheckVCode @"app/checkVCode"
//找回密码
#define k_FindBackPassword @"app/member/findBackPassword"
//注册
#define k_Register @"app/register"
//登陆
#define  k_Login @"app/login"
//获取单页
#define  k_GetSinglePageByType @"app/getSinglePageByType"
//获取广告列表
#define k_FindAdList @"app/message/findAdList"
//获取消息列表
#define k_GetMySentLogs @"app/message/getMySentLogs"
//获取公告列表
#define k_GetAnnouncements @"app/message/getAnnouncements"
//删除一条公告
#define k_DeleteAnnouncement @"announcement/delete.htm"
//获取分享内容
#define k_ShareContent @"app/placeManager/shareContent"

/**
 *  找回钱包密码
 */
#define k_findBackSureCode @"app/finance/findBackSureCode"
//--- 首页
//获取首页信息
#define k_GetHomeInfo @"app/order/getHomeInfo"
//--- 我的钱包 ----
//获取我的钱包信息
#define k_GetWalletInfo @"app/finance/getWalletInfo"
//获取我的银行
#define k_GetMyBank @"app/finance/bank/getMyBank"
//绑定银行卡
#define k_BindBand @"app/finance/bank/add"
//解除绑定银行卡
#define k_DeleteBank @"app/finance/bank/delete"
//获取ping++支付信息json
#define k_GetPayCharge @"app/finance/getPayCharge"
//ping++支付失败上报
#define k_PingErrorHook @"app/finance/pingErrorHook"
//提现
#define k_SubmitApply @"app/finance/submitApply"
//验证钱包密码
#define k_CheckSureCode  @"app/finance/checkSureCode"
//设置钱包密码
#define k_SetSureCode  @"app/finance/setSureCode"
//更新钱包密码
#define k_UpdateSureCode  @"app/finance/updateSureCode"

//----- 个人中心
//获取个人中心信息
#define k_GetOwnerOrDispatcherById @"app/member/getOwnerOrDispatcherById"
//绑定社交帐号
#define k_BindSocialContact @"app/member/bindSocialContact"
//设置名字
#define k_UpdateName @"app/member/updateName"
//设置电话
#define k_UpdatePhone @"app/member/updatePhone"
//修改密码
#define k_UpdatePassword @"app/member/updatePassword"
//发单方－获取所有站点列表
#define k_GetAllStations @"app/member/getAllStations"


//发单方－获取车型价格列表
#define k_GetTruckStyle1PriceList @"app/order/getTruckStyle1PriceList"

//发单方－选择站点
#define k_ChooseStation @"app/member/chooseStation"


//接单方－获取公司列表
#define k_GetAllCompanies @"app/member/getAllCompanies"

//接单方－绑定公司
#define k_ChooseCompany @"app/member/chooseCompany"


//--------  设置

//意见反馈
#define k_FeedbackAdd @"app/message/feedBack"

//获取客服信息
#define k_GetServiceHotline @"app/member/getServiceHotline"

//注销
#define k_Logout @"app/logout"



//--- 订单  -----

//创建订单
#define k_CreateOrder @"app/order/createOrder"


//站点端-取消订单－罚款提示
#define k_WarnToCancelOrderByDispatcher @"app/order/warnToCancleOrderByDispatcher"

//站点端-取消订单
#define k_CancelOrderByDispatcher @"app/order/cancleOrderByDispatcher"

//站点端-获取订单列表
#define k_GetDispatcherOrderlist @"app/order/getDispatcherOrderList"

//站点端-获取订单详情
#define k_GetDispatcherOrderDetail @"app/order/getDispatcherOrderDetail"

//站点端-获取抢单车主详情
#define k_GetDispatcherOrderCarDtail @"app/order/getDispatcherOrderCarDetail"

//站点端－派单
#define k_SendOrders @"app/order/sendOrders"

//站点端－确认支付
#define k_SettlementServiceLogs @"app/order/settlementServiceLogs"


//

//车主端－获取待接订单列表
#define k_GetWaitOrders @"app/order/getWaitOrders"


//车主端－获取我的订单列表
#define k_GetMyOrders @"app/order/getMyOrders"


#define k_CommitSettlement @"app/order/commitSettlement"


//车主端－获取订单详情
#define k_GetOrderById @"getOrderById.htm"

//获取支付给车主的金额
#define k_QueryOrderRealPrice @"app/order/queryOrderRealPrice"

//订单评价
#define k_AddFeedback @"app/order/addFeedback"


//获取已评价信息
#define k_GetFeedback  @"app/order/getFeedback"


//获取评价项列表 
#define k_GetAssessmentTitle @"app/order/getAssessmentTitle"


//推荐-分享
#define k_AppShare @"app/placeManager/share"


//获取未读消息数量
#define k_getNotSentLogCount @"app/message/getNotSentLogCount"


//清空消息
#define k_deleteAllSentlog  @"app/message/deleteAllSentlog"


//删除一条消息
#define k_deleteSentlog  @"app/message/deleteSentlog"


//将消息置为已读
#define k_readSentlog  @"app/message/readSentlog"

/**
 *  获取账单列表
 */
#define k_getBills @"app/finance/getBills"

/**
 *  获取账单详情
 */
#define k_getBillDetail  @"app/finance/getBillDetail"

/**
 *  获取提现记录列表
 */
#define k_queryWithdrawRecord @"app/finance/queryWithdrawRecord"

/**
 *  获取充值记录列表
 */
#define k_queryChargeRecord @"app/finance/queryChargeRecord"

#endif /* ServerPathConstants_h */
