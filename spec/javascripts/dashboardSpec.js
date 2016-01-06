describe('dashboard', function () {
  describe('githubLink', function() {
    it('returns a Github link', function() {
      json = {"source-url": "https://github.com/pikesley/snake-data/blob/master/feeds.csv"}
      expect(githubLink(json)).toEqual('<a href="https://github.com/pikesley/snake-data/blob/master/feeds.csv">Source</a>')
    })
  })
})
