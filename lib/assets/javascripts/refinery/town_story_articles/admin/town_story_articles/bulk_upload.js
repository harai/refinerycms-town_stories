var init = function (post_url) {
    var map = function (fn, arr) { return $(arr).map(function (i, e) { return fn(e, i); }); };
    var each = function (fn, arr) { $(arr).each(function (i, e) { fn(e, i); }); return arr; };
    var grep = function (fn, arr) { return $.grep(arr, fn); };
    
    var dropArea = $("#bulk_drop");

    dropArea.on("dragover", function (e) {
        e.preventDefault();
        $(this).addClass('hover');
    });

    dropArea.on("dragexit dragleave drop", function (e) {
        e.preventDefault();
        $(this).removeClass('hover');
    });

    dropArea.on("drop", function (e) {
        e.preventDefault();
        var files = e.originalEvent.dataTransfer.files;
        each(function (f) {
            var reader = new FileReader();
            reader.onerror = function (e) {
                console.log('error', e.target.error.code);
            }
            reader.onload = function (e) {
                sendJson(e.target.result);
            };
            reader.readAsText(f);
        }, files); 
    });
    
    // http://tm.root-n.com/programming:javascript:etc:trim
    var trim = function (str) {
        return str.replace(/^[\s　]+|[\s　]+$/g, '');
    };

    var csvToHashes = function (csv) {
        var records = parseCsv(csv);
        var colNames = records.shift();
        colNames = map(function (str) {
            str = str.trim().toLowerCase();
            return str == "" ? null : str;
        }, colNames);

        var items = map(function (cells) {
            var item = {};
            for (var i = 0; i < colNames.length; i++) {
                if (colNames[i] === null) {
                    continue;
                }
                if (!(i in cells)) {
                    continue;
                }
                var cell = trim(cells[i]);
                if (cell === "") {
                    continue;
                }
                item[colNames[i]] = cell;
            }
            return item;
        }, records);

        return items;
    };

    var sanitizeAndTrimHashes = function (hashes) {
        return grep(function (h) {
            return h !== null;
        }, map(function (hash) {
            if (!("title" in hash)) {
                return null;
            }
            var h = { title: hash.title };
            each(function (field) {
                if (field in hash) {
                    h[field] = hash[field];
                }
            }, ["text", "note", "address"]);
            return h;
        }, hashes));
    };

    var sendJson = function (text) {
        var items = sanitizeAndTrimHashes(csvToHashes(text));
        $.ajax({
            url: post_url,
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(items),
            dataType: "json",
        }).done(function (data, textStatus, jqXHR) {
            if ("n" in data) {
                $("#result").prepend(
                    $('<div class="success" />').append(data.n + " articles inserted."));
            } else {
                $("#result").prepend(
                    $('<div class="error" />').append(textStatus + " " + data.error));
            }
        }).fail(function (jqXHR, textStatus, errorThrown) {
            $("#result").prepend(
                $('<div class="error" />').append(textStatus + " " + errorThrown));
        });
    };
};
