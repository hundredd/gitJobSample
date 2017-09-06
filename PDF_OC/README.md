# 基于Webview实现打开pdf的方法

make_by_hundred:hundredb

## 基本的实现原理

1. 使用webView打开本地文件
2. 可以实现自己webView直接打开现在的网站

3. 本套代码主要布局是基于masory


## 实现的代码




### 创建webView

```

-(UIWebView *)webView
{
if (!_webView)
{
UIWebView *webView = [UIWebView new];
webView.scalesPageToFit = YES;//实现放大!
[self.view addSubview:webView];
[webView mas_makeConstraints:^(MASConstraintMaker *make)
{
make.edges.equalTo(self.view);
}];

_webView = webView;
}
return _webView;
}

```

### 分别实现加载在线的页面和本地文件

```
-(void)loadWebData
{
if (_urlStr)
{
NSURL *url = [NSURL URLWithString:_urlStr];
NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
[self.webView loadRequest:request];
}else
{
NSString *path = [[NSBundle mainBundle] pathForResource:@"Reader" ofType:@"pdf"];
NSURL *url = [NSURL fileURLWithPath:path];
NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
[self.webView loadRequest:request];
}
}


```
