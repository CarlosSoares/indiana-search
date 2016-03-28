
$(document).ready(onLoadProject);
$(document).on("page:load", onLoadProject);
$(document).on("page:after-remove", onLoadProject);

function onLoadProject() {
  var articlesResult = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: {
      url: window.location.pathname + '/search/%QUERY.json',
      wildcard: '%QUERY',
      filter: function (parsedResponse) {
        return parsedResponse.results || [];
      }
    }
  });

  $('#data-search input').typeahead({
    menu: $('#results'),
  }, {
    hint: true,
    highlight: true,
    minLength: 1,
    menu: '#results',
    display: 'name',
    source: articlesResult,

    templates: {
      suggestion: function(data) {
        var html = [];
        for (var key in data) {
          if (key !== '_query')
            html.push('<dt>' + key + ':</dt><dd>' + data[key] + '</dd>');
        }
        return "<li>" + html.join('') + "</li>";
      }
    }
  });

}
