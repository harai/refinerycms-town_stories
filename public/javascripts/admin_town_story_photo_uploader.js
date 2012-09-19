var init = function (url, form_authenticity_token) {
    var uploader = new plupload.Uploader({
        runtimes : 'html5',
        max_file_size : '10mb',
        url : url,
        filters : [ { title : "Image files", extensions : "jpg" } ],
        resize : { width : 1200, height : 1200, quality : 90 },
        multipart : true,
        multipart_params : {
            _http_accept : 'application/javascript',
            authenticity_token : form_authenticity_token
        },
        drop_element : "uploader",
        autostart : true,
    });

    uploader.bind('Init', function(up, params) {
        console.info("Plupload: Current runtime: " + params.runtime);
    });

    $('#uploadfiles').click(function(e) {
        uploader.start();
        e.preventDefault();
    });

    uploader.init();

    uploader.bind('FilesAdded', function(up, files) {
        $.each(files, function(i, file) {
            $('#filelist').append(
                '<div id="' + file.id + '">' +
                file.name + ' (' + plupload.formatSize(file.size) + ') <b></b>' +
            '</div>');
        });

        up.refresh(); // Reposition Flash/Silverlight
    });

    uploader.bind('UploadProgress', function(up, file) {
        $('#' + file.id + " b").html(file.percent + "%");
    });

    uploader.bind('Error', function(up, err) {
        $('#filelist').append("<div>Error: " + err.code +
            ", Message: " + err.message +
            (err.file ? ", File: " + err.file.name : "") +
            "</div>"
        );

        up.refresh(); // Reposition Flash/Silverlight
    });

    uploader.bind('FileUploaded', function(up, file) {
        $('#' + file.id + " b").html("100%");
    });
};
