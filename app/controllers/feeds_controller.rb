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

    p query
    p feeds
  end

  def show_params
    @show_params ||= JSON.parse params[:json]
  end
end
