// document.addEventListener('load', url_creator_setup);
function url_convert_setup(query_class, feeds_class, created_url_class) {
    var $inputs = $(query_class + ' , ' + feeds_class);

    function view_url(event) {
        var query = $(query_class).val();
        var feeds = $(feeds_class).val().split('\n');
        document.querySelector(created_url_class).value = create(query, feeds);
    }
    $inputs.on('change', view_url);
    $inputs.on('keydown', view_url);
}

function create(query, feeds) {
    var url = location.host + '/feeds';
    var param = 'q=' + encodeURIComponent(query) + '&feeds=';
    for (var i = 0; i < feeds.length; i++) {
        feeds[i] = encodeURIComponent(feeds[i]);
    }
    param += feeds.join(',');
    return url + '?' + param;
}