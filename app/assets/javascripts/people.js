$( document ).on('turbolinks:load', function() {
    $('table#people_table').dataTable({
        "order": [[ 1, "asc" ]],
        "columnDefs": [
            { "orderable": false, "targets": [4] }
        ]
    });
});