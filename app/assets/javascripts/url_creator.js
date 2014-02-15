
// document.addEventListener('load', url_creator_setup);
function url_convert_setup(created_url_class, feeds_class, query_class) {
  var query_input = document.querySelector(query_class);
  var feed_inputs = document.querySelectorAll(feeds_class);

  function view_url(event) {
    var query = query_input.value;
    var feeds = [];
    for (var i = 0; i < feed_inputs.length; i++) {
      feeds.push(feed_inputs[i].value)
    }
    document.querySelector(created_url_class).value = create(query, feeds);
  }

  query_input.addEventListener('change', view_url)
  for (var i = 0 ; i < feed_inputs.length; i++) {
      feed_inputs[i].addEventListener('change', view_url)
  }
}

function create(query, feeds) {
  var url = location.host + (location.port ? ':' + location.port : '') + '/feeds';
  var param = 'q=' + encodeURIComponent(query) + '&feeds=';
  for (var i = 0; i < feeds.length; i++) {
      feeds[i] = encodeURIComponent(feeds[i]);
  }
  param += feeds.join(',');
  return url + '?' + param;
}