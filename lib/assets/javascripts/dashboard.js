function githubLink(json) {
  return '<a href="' + json['source-url'] + '">Source</a>'
}

function cellContent(id, content) {
  return "<div class='col-md-12' id='#" + id + "'>" + content + "</div>"
}
