require "cnblog2jekyll/version"
require 'open-uri'
require 'nokogiri'
require 'watir-webdriver'
require 'headless'
require 'stringex'

module Cnblog2jekyll
  class << self
    attr_accessor :username

    # generate methods :archive_links and :articles_links
    # which content is like this:
    # @archive_links ? @archive_links : get_archive_links
    [:archive_links, :article_links].each do |method_name|
      define_method method_name do
        instance_value = instance_variable_get(("@" + method_name.to_s).to_sym)
        instance_value ? instance_value : send("get_" + method_name.to_s)
      end
    end

    def get_article_links
      @article_links = archive_links.map do |al|
        html = Nokogiri::HTML(open(al))
        html.css('a.entrylistItemTitle').map { |css_a| css_a['href'] }
      end.flatten

      # generate article_id_html methods
      # generate generate_markdown_article_id_html methods
      @article_links.each do |al|
        al_string = al.split(/[\/.]/).last(2).join("_")

        article_method = ["article", al_string].join("_")
        send(:define_singleton_method, article_method) { article(al) }

        generate_markdown_method = ["generate_markdown", al_string].join("_")
        send(:define_singleton_method, generate_markdown_method) { generate_markdown(al) }
      end
    end

    def generate_markdown_all
      article_links.each { |al| generate_markdown(al) }
    end


    private
    def get_archive_links
      headless = Headless.new
      headless.start

      browser = Watir::Browser.start 'cnblogs.com/' + @username
      html = Nokogiri::HTML.parse(browser.html)
      @archive_links = []; html.css('div#blog-sidecolumn a').each do |e| 
        @archive_links << e['href'] if e['href'] =~ /archive/
      end

      browser.close
      headless.destroy

      @archive_links
    end

    def article(al)
      headless = Headless.new
      headless.start

      browser = Watir::Browser.start al
      html = Nokogiri::HTML.parse(browser.html)

      title = html.css('a#cb_post_title_url').text.gsub("\"","")
      date = html.css('span#post-date').text
      content = html.css('div#cnblogs_post_body').to_s.each_line.to_a[1...-1].join("\n").gsub(/\r\n/, "\n")
      category = []; 
      html.css('div#BlogPostCategory a').each do |e| 
        category << e.text.downcase
        category << e.text.to_url if e.text =~ /\p{Han}+/
      end

      browser.close
      headless.destroy

      { title: title, date: date, category: category, content: content }
    end

    def generate_markdown(al)
      art = article(al)
      
      filename = art[:date].match(/....-..-../).to_s + "-" + art[:title].scan(/[a-zA-Z0-9\p{Han}]+/).join("-") + ".markdown"
      content = <<-EOF.gsub(/^\s+/, "")
      ---
      layout: post
      title: "#{art[:title]}"
      date: "#{art[:date]} +0800"
      comments: true
      categories: [ #{art[:category].join(", ")} ]
      ---
      #{art[:content]}
      EOF

      dirname = File.join(Dir.home, "_posts/cnblogs") 
      FileUtils.mkdir_p(dirname) unless Dir.exist?(dirname)

      if File.open(dirname + "/" + filename, 'w') { |f| f.write(content) }
        puts <<-EOF
        article links:    #{al}
        generate file:    #{dirname}/#{filename}
        EOF
      end
    end
    
  end
end

