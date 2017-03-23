Array.prototype.unique = function() {
    var a = this.concat();
    for(var i=0; i<a.length; ++i) {
        for(var j=i+1; j<a.length; ++j) {
            if(a[i] === a[j])
                a.splice(j--, 1);
        }
    }
    return a;
};

function rich_snippet_filter(filter, app_types=[]) {
  var types = ['Event', 'Offer', 'PostalAddress', 'Person', 'Organization', 'Product', 'Recipe', 'CreativeWork', 'JobPosting'].concat(app_types).unique();

  if(filter == undefined) {
    return rich_snippet_all_options(types);
  }
  else {
    return {
      '_obj_class': {
        'field': '_obj_class',
        'options': rich_snippet_all_options(filter == 'all' ? types : filter.concat(app_types).unique())
      }
    }
  }
}

function rich_snippet_all_options(types) {
  var h = {}
  types.forEach(function(e) {
    h[e] = {
      'value': "RichSnippet::" + e,
      'enable_create': true,
      'title': e,
      'preset': {
        '_obj_class': "RichSnippet::" + e
      }
    }
  });
  return h;
}
