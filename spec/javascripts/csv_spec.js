//= require csv

describe("csv", function() {
  it("parses csv with quotation", function() {
      var str = '"a","b","c"\n"d","e","f"';
      parseCsv(str).should.eql([['a','b','c'],['d','e','f']]);
  });

  it("parses csv without quotation", function() {
      var str = 'a,b,c\nd,e,f';
      parseCsv(str).should.eql([['a','b','c'],['d','e','f']]);
  });

  it("parses mixed cells csv", function() {
      var str = 'a,"b"\n"c",d';
      parseCsv(str).should.eql([['a','b'],['c','d']]);
  });

  it("parses csv with redundant spaces", function() {
      var str = ' a , "b" \n "c" , d ';
      parseCsv(str).should.eql([[' a ','b'],['c',' d ']]);
  });

  it("parses csv with a newline in a cell", function() {
      var str = 'a,"b\nc",d';
      parseCsv(str).should.eql([['a','b\nc','d']]);
  });

  it("parses csv with CR", function() {
      var str = 'a,b\r\nc,d\re,f\ng,h\n\rj,k';
      parseCsv(str).should.eql([['a','b'],['c','d'],['e','f'],['g','h'],[''],['j','k']]);
  });

  it("trims the blank last line", function() {
      var str = 'a,b\nc,d\n';
      parseCsv(str).should.eql([['a','b'],['c','d']]);
  });

  it("parses quotes in a cell", function() {
      var str = 'a,b\n"he said ""hello!""",d';
      parseCsv(str).should.eql([['a','b'],['he said "hello!"','d']]);
  });
});
