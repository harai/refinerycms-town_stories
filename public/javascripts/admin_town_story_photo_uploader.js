var init = function (args) {
    console.info(args);
    
    var dropArea = $("#dropping_area");

    var uploader = new plupload.Uploader({
        runtimes : 'html5',
        max_file_size : '10mb',
        url : args.url,
        filters : [ { title : "Image files", extensions : "jpg" } ],
        resize : { width : 1200, height : 1200, quality : 90 },
        multipart : true,
        multipart_params : {
            _http_accept : 'application/javascript',
            authenticity_token : args.auth,
        },
        drop_element : "dropping_area",
        autostart : true,
    });

    uploader.bind('Init', function (up, params) {
        console.info("Plupload: Current runtime: " + params.runtime);
    });

    uploader.init();

    uploader.bind('FilesAdded', function (up, files) {
        $.each(files, function (i, file) {
            console.debug("FilesAdded: " + file.id);
            console.debug(file);
            var upload = $('<span class="uploading">Uploading...</span>');
            var percent = $('<span class="percent">0%</span>');
            var progress = $('<div class="progress"></div>').append(upload, "<br />", percent);
            var frame = $('<div class="photoframe"></div>').attr("id", file.id);
            dropArea.before(frame.append(progress));
        });
        uploader.start();
    });

    var objectName = $("#town_story_article_photos").attr("object_name");

    var getFileElement = function (file) {
        return $("#" + file.id);
    };

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

    uploader.bind('UploadProgress', function (up, file) {
        console.debug("UploadProgress: " + file.id);
        getFileElement(file).find(".percent").html(file.percent + "%");
    });

    // uploader.bind('Error', function (up, err) {
        // $('#filelist').append("Error: " + err.code + ", Message: " + err.message +
            // (err.file ? ", File: " + err.file.name : ""));
    // });

    uploader.bind('FileUploaded', function (up, file, res) {
        var photo = $.parseJSON(res.response);
        setCompleted(getFileElement(file), photo.id, photo.thumb_url);
    });
    
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
