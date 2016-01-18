describe('dashboard', function () {
  describe('githubLink', function() {
    it('returns a Github link', function() {
      json = {"source-url": "https://github.com/pikesley/snake-data/blob/master/feeds.csv"}
      expect(githubLink(json)).
        toEqual("<a href='https://github.com/pikesley/snake-data/blob/master/feeds.csv'>Source</a>")
    })
  })

  describe('cellContent', function() {
    it('creates cell content', function() {
      expect(cellContent('some-id', 'Hello World')).
        toEqual("<div class='col-md-12' id='#some-id'>Hello World</div>")
    })
  })

  describe('graphing', function() {
    var json = {"title":"Weight","name":"weight.csv","id":"weight","date-field":"Date","type":"graph","source-url":"https://github.com/pikesley/snake-data/blob/master/weight.csv","data":[{"Date":"2014-10-23","Mass in g":"18.3"},{"Date":"2014-10-31","Mass in g":"19"},{"Date":"2014-11-05","Mass in g":"22"},{"Date":"2014-11-11","Mass in g":"22.8"},{"Date":"2014-12-02","Mass in g":"24"},{"Date":"2014-12-09","Mass in g":"28.5"},{"Date":"2014-12-16","Mass in g":"28"},{"Date":"2014-12-23","Mass in g":"34.2"},{"Date":"2015-01-04","Mass in g":"32.3"},{"Date":"2015-01-13","Mass in g":"35.3"},{"Date":"2015-01-20","Mass in g":"40.4"},{"Date":"2015-01-28","Mass in g":"36.4"},{"Date":"2015-02-08","Mass in g":"33.7"},{"Date":"2015-02-11","Mass in g":"41.3"},{"Date":"2015-02-18","Mass in g":"43.2"},{"Date":"2015-02-25","Mass in g":"49.2"},{"Date":"2015-03-10","Mass in g":"54.7"},{"Date":"2015-03-12","Mass in g":"50.6"},{"Date":"2015-03-19","Mass in g":"53.3"},{"Date":"2015-03-24","Mass in g":"63.3"},{"Date":"2015-04-02","Mass in g":"65.6"},{"Date":"2015-04-16","Mass in g":"84"},{"Date":"2015-04-23","Mass in g":"85.1"},{"Date":"2015-05-14","Mass in g":"103.3"},{"Date":"2015-05-17","Mass in g":"97.8"},{"Date":"2015-05-26","Mass in g":"118.7"},{"Date":"2015-06-10","Mass in g":"136.7"},{"Date":"2015-07-01","Mass in g":"154"},{"Date":"2015-07-14","Mass in g":"176.8"},{"Date":"2015-08-19","Mass in g":"205.0"},{"Date":"2016-01-02","Mass in g":"311.1"}]}
    describe('getPoints', function () {
      it('extracts the x field', function() {
        expect(ecks(json)).toEqual('Date')
      })

      it('extracts the y field', function() {
        expect(why(json)).toEqual('Mass in g')
      })

      it('gets a series of points', function () {
        expect(points(json)).toEqual({ x: [ '2014-10-23', '2014-10-31', '2014-11-05', '2014-11-11', '2014-12-02', '2014-12-09', '2014-12-16', '2014-12-23', '2015-01-04', '2015-01-13', '2015-01-20', '2015-01-28', '2015-02-08', '2015-02-11', '2015-02-18', '2015-02-25', '2015-03-10', '2015-03-12', '2015-03-19', '2015-03-24', '2015-04-02', '2015-04-16', '2015-04-23', '2015-05-14', '2015-05-17', '2015-05-26', '2015-06-10', '2015-07-01', '2015-07-14', '2015-08-19', '2016-01-02' ], y: [ '18.3', '19', '22', '22.8', '24', '28.5', '28', '34.2', '32.3', '35.3', '40.4', '36.4', '33.7', '41.3', '43.2', '49.2', '54.7', '50.6', '53.3', '63.3', '65.6', '84', '85.1', '103.3', '97.8', '118.7', '136.7', '154', '176.8', '205.0', '311.1' ] } )
      })
    })
  })

  describe('latestCell', function() {
    it('generates a cell with the latest value', function() {
      pending()
      expect(latestCell(json)).toEqual()
    })
  })
})
