// 0.账户相关
#define MWAppKey @"3337096979"
#define MWAppSecret @"d6a9fe07e7cc5876ac1ef6e67c64394c"
#define MWRedirectURL @"http://www.baidu.com"

#define MWAuthorize [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@", MWAppKey, MWRedirectURL]
// 1.判断是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

// 2.获得RGB颜色
#define MWColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 3.自定义Log
#ifdef DEBUG
#define MALog(...) NSLog(__VA_ARGS__)
#else
#define MALog(...)
#endif

// cellFrame的宏

// titleButton图片的宽度
#define MWTitleButtonImageW 20

/** 视图间的间距 */
#define MWStatusTableBorder 5

/** Cell间的间距 */
#define MWStatusCellBorder 5

/**昵称字体*/
#define MWHomeCellNameFont [UIFont systemFontOfSize:12]


/**时间字体*/
#define MWHomeCellTimeFont MWHomeCellNameFont
/**来源字体*/
#define MWHomeCellSourceFont MWHomeCellNameFont

/**正文字体*/
#define MWHomeCellContentFont MWHomeCellNameFont

/**转发微博的昵称字体*/
#define MWHomeReweetStatuseNameFont [UIFont systemFontOfSize:12]
/**转发微博的正文字体*/
#define MWHomeReweetStatuseContentFont [UIFont systemFontOfSize:12]