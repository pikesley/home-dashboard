function dateFixer(date) {
  return '3rd December'
}

function getCSV(url, id) {
  fullURL = 'https://raw.githubusercontent.com/' + url

  $.get(fullURL, function(data) {
    $('#catface-data').append(
      cellContent(id, data)
    )
  })
}
