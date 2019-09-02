$( document ).on('turbolinks:load', function() {
    $('table#homes_table').dataTable({
        "columnDefs": [
            { "orderable": false, "targets": [3] }
        ]
    });
});