var init = function (args) {
    var map = function (fn, arr) { return $(arr).map(function (i, e) { return fn(e, i); }); };
    var each = function (fn, arr) { $(arr).each(function (i, e) { fn(e, i); }); return arr; };
    var grep = function (fn, arr) { return $.grep(arr, fn); };
    
    var objectName = $("#town_story_article_photos").attr("object_name");

    var setCompleted = function (photoframe, id, url) {
        photoframe.html("");
        var input = $('<input type="hidden" />').attr("value", id).attr("name", objectName + "[]");
        var img = $('<img class="photo_thumb" alt="uploaded photo" />').attr("src", url);
        photoframe.append(input, img);

        var button = $('<div class="photo_remove_button">X</div>').css("display", "none");
        photoframe.prepend(button);
        photoframe.mouseenter(function () {
            button.css("display", "");
        });
        photoframe.mouseleave(function () {
            button.css("display", "none");
        });
        button.click(function (e) {
            e.preventDefault();
            photoframe.fadeOut("slow", function () {
                photoframe.remove();
            });
        });

        return photoframe;
    };

    var count = (function () {
        var i = 0;
        
        return function () {
            return ++i;
        };
    })();

    $('#dropping_area').fileupload({
        formData: {
            _http_accept : 'application/javascript',
            authenticity_token : args.auth
        },
        process: [
            {
                action: 'load',
                fileTypes: /^image\/jpeg$/,
                maxFileSize: 20000000 // 20MB
            },
            {
                action: 'resize',
                maxWidth: 1200,
                maxHeight: 1200
            },
            {
                action: 'save'
            }
        ],
        add: function (e, data) {
            var file = data.files[0];
            
            if (! /\.jpg$/i.test(file.name)) {
                return ;
            }

            var id = "__fileupload_item_" + count();
            var upload = $('<span class="uploading">Uploading...</span>');
            var percent = $('<span class="percent">0%</span>');
            var progress = $('<div class="progress"></div>').append(upload, "<br />", percent);
            var frame = $('<div class="photoframe"></div>').attr("id", id);
            dropArea.before(frame.append(progress));
            data.context = id;

            data.submit();
        },
        progress: function (e, data) {
            var id = data.context;
            var progress = parseInt(data.loaded / data.total * 100, 10);
            $('#' + id).find(".percent").html(progress + "%");
        },
        done: function (e, data) {
            var id = data.context;
            var photo = data.result;
            setCompleted($('#' + id), photo.id, photo.thumb_url);
        },
        paramName: 'file'
    });
    
    var dropArea = $("#dropping_area");

    dropArea.bind("dragover", function (e) {
        e.preventDefault();
        $(this).addClass('hover');
    });

    dropArea.bind("dragexit dragleave drop", function (e) {
        e.preventDefault();
        $(this).removeClass('hover');
    });

    (function () {
        $.each(args.photos, function (i, p) {
            dropArea.before(setCompleted($('<div class="photoframe" />'), p.id, p.url));
        });
    })();
};
