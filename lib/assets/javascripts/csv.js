function parseCsv(str) {
    var processing = str;

    var parseCellWithQuote = function () {
        var m = processing.match(/^[ \t]*"(([^"]|"")*)"/);
        processing = RegExp.rightContext;
        return m[1].replace(/""/g, '"');
    };

    var parseCellWithoutQuote = function () {
        var m = processing.match(/^(.*?)(?=[,\n]|$)/);
        processing = RegExp.rightContext;
        return m[1].replace(/""/g, '"');
    };

    var parseCell = function () {
        var parser = (/^[ \t]*"/).test(processing) ? parseCellWithQuote : parseCellWithoutQuote;
        return parser(); 
    };

    var parseRow = function () {
        var cells = [];
        do {
            var cell = parseCell();
            cells.push(cell);
            if (processing.match(/^[ \t]*,/)) {
                processing = RegExp.rightContext;
            } else {
                break;
            }
        } while (true);
        return cells;
    };

    var parseTable = function () {
        var rows = [];
        do {
            var row = parseRow();
            rows.push(row);
            if (processing.match(/^[ \t]*\n/)) {
                processing = RegExp.rightContext;
            } else {
                break;
            }
        } while (true);
        return rows;
    };
    
    var normalizeNewline = function () {
        processing = processing.replace(/\r\n|\r/g, "\n");
    };
    
    var trimTheLastLine = function () {
        if (processing.substr(-1, 1) != "\n")
            return ;
        
        processing = processing.substr(0, processing.length - 1);
    };

    normalizeNewline();
    trimTheLastLine();
    
    return parseTable();
}
