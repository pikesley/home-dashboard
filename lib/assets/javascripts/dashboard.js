function cellContent(id, data) {
  fixedDate = moment(data, 'YYYY-MM-DD').format('dddd Do MMMM')
  subject = id.replace('-', ' ')

  content = '<p>Last ' + subject + ' was on</p><h2>' + fixedDate + '</h2>'

  return "<div class='col-md-4' id='#" + id + "'>" + content + "</div>"
}
