RssFilter::Application.routes.draw do
  root "generate#index"
  get "feeds" => "feeds#show"
end
