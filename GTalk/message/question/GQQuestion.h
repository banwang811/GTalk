//
//  GQQuestion.h
//  Investment
//
//  Created by mac on 15/7/29.
//
//

#import <Foundation/Foundation.h>

@interface GQQuestion : NSObject

@property (nonatomic, assign) NSInteger                                                     questionId;
@property (nonatomic, strong) NSString                                                      *content;
@property (nonatomic, strong) NSString                                                      *createTime;
@property (nonatomic, strong) NSString                                                      *createUserId;
@property (nonatomic, strong) NSString                                                      *isDel;
@property (nonatomic, strong) NSString                                                      *isUsed;
@property (nonatomic, strong) NSString                                                      *modifyTime;
@property (nonatomic, strong) NSString                                                      *modifyUserId;
@property (nonatomic, strong) NSString                                                      *title;

@end
