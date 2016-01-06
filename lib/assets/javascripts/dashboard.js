function githubLink(json) {
  return "<a href='" + json['source-url'] + "'>Source</a>"
}

function cellContent(id, content) {
  return "<div class='col-md-12' id='#" + id + "'>" + content + "</div>"
}

function getGraphField(json, index) {
  return Object.keys(json['data'][0])[index]
}

function ecks(json) {
  return getGraphField(json, 0)
}

function why(json) {
  return getGraphField(json, 1)
}

function mapPoints(json, axis) {
  return json['data'].map(function(item){ return item[axis(json)] })
}

function points(json) {
  return {
    x: mapPoints(json, ecks),
    y: mapPoints(json, why)
  }
}

function graph(json) {
  var p = [
    points(json)
  ]
  p[0]['type'] = 'scatter'

  var layout = {
    title: json['title'] + ' (' + githubLink(json) + ')',
    xaxis: {
      tickformat: "%b %Y",
      tickangle: 90
    },
    yaxis: {
      title: why(json),
      titlefont: {
        size: 14,
        color: '#7f7f7f'
      }
    },
    margin: {
     l: 50, r: 10
    }
  }

  $('#data').html("<div id='" + json['id'] + "' class='col-md-12' style='height: 400px'></div>")
  Plotly.newPlot(json['id'], p, layout)
}

function latestCell(json) {
  d = json['data'][json['data'].length -1][json['date-field']]
  fixedDate = moment(d, 'YYYY-MM-DD').format('Do MMMM')
  age = moment(d, 'YYYY-MM-DD').fromNow()
  content = '<h1><small>Last</small> '
  content += json['title'] + ':</h1>'
  if(json['special_fields']) {
    content += '<h4>'

    json['special_fields'].forEach(function(field) {
      content += json['data'][json['data'].length -1][field]
      content += ' '
    })

    content += '</h4>'
  }
  content += '<h2>' + fixedDate + '</h2>'
  content += '<h3>(' + age + ')</h3>'
  content += githubLink(json)

  return cellContent(json['id'], content)
}
