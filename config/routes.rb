RssFilter::Application.routes.draw do
  get "feeds" => "feeds#show"
end
