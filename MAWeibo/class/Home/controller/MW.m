//
//  MW.m
//  MAWeibo
//
//  Created by admin on 14-10-28.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import "MW.h"

@implementation MW

//{
//    "attitudes_count" = 1;
//    "comments_count" = 5;
//    "created_at" = "Tue Oct 28 00:27:20 +0800 2014";
//    "darwin_tags" =         (
//    );
//    favorited = 0;
//    geo = "<null>";
//    id = 3770443481889608;
//    idstr = 3770443481889608;
//    "in_reply_to_screen_name" = "";
//    "in_reply_to_status_id" = "";
//    "in_reply_to_user_id" = "";
//    mid = 3770443481889608;
//    mlevel = 0;
//    "pic_urls" =         (
//    );
//    "reposts_count" = 0;
//    "retweeted_status" =         {
//        annotations =             (
//                                   {
//                                       "client_mblogid" = "iPhone-19057386-0174-4533-BF67-2378BFC9A570";
//                                       shooting = 1;
//                                   }
//                                   );
//        "attitudes_count" = 0;
//        "comments_count" = 2;
//        "created_at" = "Tue Oct 28 00:25:40 +0800 2014";
//        "darwin_tags" =             (
//        );
//        favorited = 0;
//        geo = "<null>";
//        id = 3770443062558653;
//        idstr = 3770443062558653;
//        "in_reply_to_screen_name" = "";
//        "in_reply_to_status_id" = "";
//        "in_reply_to_user_id" = "";
//        mid = 3770443062558653;
//        mlevel = 0;
//        "pic_urls" =             (
//        );
//        "reposts_count" = 1;
//        source = "<a href=\"http://app.weibo.com/t/feed/9ksdit\" rel=\"nofollow\">iPhone\U5ba2\U6237\U7aef</a>";
//        "source_type" = 1;
//        text = "\U7279\U65af\U5854";
//        truncated = 0;
//        user =             {
//            "ability_tags" = "\U5185\U5bb9\U8d44\U8baf";
//            "allow_all_act_msg" = 1;
//            "allow_all_comment" = 1;
//            "avatar_hd" = "http://tp1.sinaimg.cn/1494720324/180/40022326405/1";
//            "avatar_large" = "http://tp1.sinaimg.cn/1494720324/180/40022326405/1";
//            "bi_followers_count" = 1067;
//            "block_app" = 1;
//            "block_word" = 0;
//            city = 5;
//            class = 1;
//            "created_at" = "Fri Aug 28 16:34:28 +0800 2009";
//            "credit_score" = 80;
//            description = "\U738b\U5cfb\U6d9b\U3002\U7535\U5546\U4e1a\U8005\Uff0c6688.com\Uff1b\U8bf7\U540c\U65f6\U5173\U6ce8@\U8001\U6995\U638c\U67dc";
//            domain = laorong;
//            "favourites_count" = 23;
//            "follow_me" = 0;
//            "followers_count" = 927767;
//            following = 1;
//            "friends_count" = 1628;
//            gender = m;
//            "geo_enabled" = 1;
//            id = 1494720324;
//            idstr = 1494720324;
//            lang = "zh-cn";
//            location = "\U5317\U4eac \U671d\U9633\U533a";
//            mbrank = 5;
//            mbtype = 13;
//            name = "\U8001\U6995";
//            "online_status" = 0;
//            "pagefriends_count" = 0;
//            "profile_image_url" = "http://tp1.sinaimg.cn/1494720324/50/40022326405/1";
//            "profile_url" = laorong;
//            province = 11;
//            ptype = 0;
//            remark = "";
//            "screen_name" = "\U8001\U6995";
//            star = 0;
//            "statuses_count" = 79406;
//            url = "http://blog.sina.com.cn/laorong";
//            verified = 1;
//            "verified_contact_email" = "";
//            "verified_contact_mobile" = "";
//            "verified_contact_name" = "";
//            "verified_level" = 2;
//            "verified_reason" = "6688.com\U7f51\U7ad9\U521b\U59cb\U4eba";
//            "verified_reason_modified" = "";
//            "verified_reason_url" = "";
//            "verified_source" = "";
//            "verified_source_url" = "";
//            "verified_state" = 0;
//            "verified_trade" = "";
//            "verified_type" = 0;
//            weihao = "";
//        };
//        visible =             {
//            "list_id" = 0;
//            type = 0;
//        };
//    };
//    rid = "0_2666870478378713380";
//    source = "<a href=\"http://app.weibo.com/t/feed/9ksdit\" rel=\"nofollow\">iPhone\U5ba2\U6237\U7aef</a>";
//    "source_type" = 1;
//    text = "\U6211\U4e3a\U6bdb\U5728\U7535\U8111\U4e0a\U4e00\U53d1\U5e16\U5c31\U7b49\U554a\U7b49\U554a\U534a\U5929\U53d1\U4e0d\U51fa\U6765\U3002\U8fd9\U65b0\U7248\U5413\U6b7b\U4eba\U4e86";
//    truncated = 0;
//    user =         {
//        "ability_tags" = "\U5185\U5bb9\U8d44\U8baf";
//        "allow_all_act_msg" = 1;
//        "allow_all_comment" = 1;
//        "avatar_hd" = "http://tp1.sinaimg.cn/1494720324/180/40022326405/1";
//        "avatar_large" = "http://tp1.sinaimg.cn/1494720324/180/40022326405/1";
//        "bi_followers_count" = 1067;
//        "block_app" = 1;
//        "block_word" = 0;
//        city = 5;
//        class = 1;
//        "created_at" = "Fri Aug 28 16:34:28 +0800 2009";
//        "credit_score" = 80;
//        description = "\U738b\U5cfb\U6d9b\U3002\U7535\U5546\U4e1a\U8005\Uff0c6688.com\Uff1b\U8bf7\U540c\U65f6\U5173\U6ce8@\U8001\U6995\U638c\U67dc";
//        domain = laorong;
//        "favourites_count" = 23;
//        "follow_me" = 0;
//        "followers_count" = 927767;
//        following = 1;
//        "friends_count" = 1628;
//        gender = m;
//        "geo_enabled" = 1;
//        id = 1494720324;
//        idstr = 1494720324;
//        lang = "zh-cn";
//        location = "\U5317\U4eac \U671d\U9633\U533a";
//        mbrank = 5;
//        mbtype = 13;
//        name = "\U8001\U6995";
//        "online_status" = 0;
//        "pagefriends_count" = 0;
//        "profile_image_url" = "http://tp1.sinaimg.cn/1494720324/50/40022326405/1";
//        "profile_url" = laorong;
//        province = 11;
//        ptype = 0;
//        remark = "";
//        "screen_name" = "\U8001\U6995";
//        star = 0;
//        "statuses_count" = 79406;
//        url = "http://blog.sina.com.cn/laorong";
//        verified = 1;
//        "verified_contact_email" = "";
//        "verified_contact_mobile" = "";
//        "verified_contact_name" = "";
//        "verified_level" = 2;
//        "verified_reason" = "6688.com\U7f51\U7ad9\U521b\U59cb\U4eba";
//        "verified_reason_modified" = "";
//        "verified_reason_url" = "";
//        "verified_source" = "";
//        "verified_source_url" = "";
//        "verified_state" = 0;
//        "verified_trade" = "";
//        "verified_type" = 0;
//        weihao = "";
//    };
//    visible =         {
//        "list_id" = 0;
//        type = 0;
//    };
//}
@end
