# Cnblog2jekyll
Export cnblog's posts to jekyll(把博客园的文章导入到Jekyll)


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cnblog2jekyll'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cnblog2jekyll


## 使用说明


### 该脚本的作用

* 该脚本适用于想要把个人博客从cnblog迁移到jekyll的用户. 
* 该脚本可以抓取cnblog的博客文章然后转化成jekyll可读取的格式。
* 新生成的文件在用户home目录的_posts/cnblog下。
     


### 注意

* 如果文章设置了访问密码, 导出时请暂时取消密码, 否则无法导入相关随笔.
* 个人博客不同的主题导致了html/css树结构的不同，使用此RubyGem前，请先切换到elf主题，然后等待数分钟生效。
* 转换后的随笔分类名字统一为小写字母。
* 如果分类名字为中文的, 请尽量在转换前将分类名字更换为英文, 并且等待10分钟左右使页面生效.否则, 转换后的分类标签将额外附加提供一个"汉语拼音"的分类名字。



### 系统运行环境

* 使用此RubyGem的系统环境是Linux系统（因为该Gem是基于Ubuntu系统而写的，亦只在Ubuntu下面做过测试）。
* Ubuntu系统安装依赖, 请执行如下命令:
```shell
aptitude install xvfb firefox
 ```


### 使用方法
 ```shell
gem install cnblog2jekyll
pry    # 或者 irb
require 'cnblog2jekyll'
```
或者
```shell
git clone https://github.com/yanyingwang/cnblog2jekyll.git
cd cnblog2jekyll
./bin/console
```


**配置用户名**

`Cnblog2jekyll.username = 'yywang'`

这里的yywang应该替换成你自己的博客园的用户名，也就是你的博客园主页链接http://cnblogs.com/username处的用户名。




**抓取全部文章并且在生成ekyll兼容文章写入本地**

`Cnblog2jekyll.generate_markdown_all`

命令输出结果示例：
```shell
[3] pry(main)> Cnblog2jekyll.generate_markdown_all
        article links:    http://www.cnblogs.com/5211sss1/p/42519.html
        generate file:    /home/yanying/_posts/cnblogs/2015-04-05-测试.markdown
```




**article_links方法**

`Cnblog2jekyll.article_links`

此方法会输出所有文章的链接，同时亦会生成抓取每一个文章的方法，和生成本地jekyll兼容文件的方法。
命令输出结果示例：
```shell
[2] pry(main)> Cnblog2jekyll.article_links
["http://www.cnblogs.com/yywang/articles/4427313.html"]
```



**查看抓取文章的方法**

`Cnblog2jekyll.methods.grep /^article/`

 命令输出结果示例：
 ```shell
 [4] pry(main)> Cnblog2jekyll.methods.grep /^article/
 => [:article_links,
  :article_4394519_html,
  :article_4276132_html,
  :article_4183562_html,
  :article_4145271_html,
  :article_4119997_html,
  :article_4116020_html,
  :article_4114471_html,
  :article_4093537_html,
  :article_4068008_html,
  :article_4060830_html,
  :article_4058168_html]
```


**抓取单个文章**

`Cnblog2jekyll.article_4427313_html`

根据上面得到的抓取文章的方法，调用相应方法抓取需要的文章。

命令输出结果示例：
```shell
[3] pry(main)> Cnblog2jekyll.article_4427313_html
=> {:title=>"这是一篇测试文章", :date=>"2015-04-14 23:33", :category=>[], :content=>"<p>这是一篇测试用的文章。</p>\n\n<p>line1</p>\n\n<p>line2</p>\n"}
```



**查看生成本地jekyll兼容文章的调用方法**

`Cnblog2jekyll.methods.grep /^generate/`



**生成jekyll单个文件写入本地的方法**

`Cnblog2jekyll.generate_markdown_4427313_html`

根据上面得到的抓取文章的方法，调用相应方法抓取需要的文章。





## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/cnblog2jekyll/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
