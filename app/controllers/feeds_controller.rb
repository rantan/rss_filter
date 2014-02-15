require 'net/http'
require 'uri'
require 'rss'
class FeedsController < ApplicationController
  # URLのサンプル
  # /feeds?json=%7B"q"%3A"hoge"%2C"feeds"%3A%5B"http%3A%2F%2Fhoge.com"%2C"http%3A%2F%2Ffuga.com"%5D%7D
  #
  # q - フィルターの条件
  # feeds - RSSフィードのリスト
  #
  def show
    query = show_params['q']
    feeds = show_params['feeds']
    #feeds = ['https://www.ruby-lang.org/ja/feeds/news.rss', 'http://feeds.gizmodo.jp/rss/gizmodo/index.xml', 'http://matome.naver.jp/feed/news']

    new_rss = RSS::Maker.make("2.0") do |rss|
      rss.channel.title = "sample"
      rss.channel.description = "feed sample"
      rss.channel.link = 'http://example.com'
      #rss.channel.about = 'http://example.com'
      each_items(feeds) do |item|
        maker_item  = rss.items.new_item
        copy_item(maker_item, item)
      end
    end

    render xml: new_rss.to_s
  end

  def copy_item(maker, channel)
    maker.title = channel.title
    maker.description = channel.description
    maker.link = channel.link
    maker.pubDate = channel.pubDate
    #maker.category = channel.category
  end

  def show_params
    @show_params ||= JSON.parse params[:json]
  end

  def each_items(feeds)
    feeds.each do |feed|
      resstr = Net::HTTP.get(URI.parse(feed))
      rssobj = RSS::Parser.parse(resstr)
      rssobj.items.each do |item|
        yield item
      end
    end
  end
end
