// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$( document ).on('turbolinks:load', function() {
    $('table#incomes_table').dataTable({
        "order": [[ 3, "desc" ]],
        "columnDefs": [
            { "orderable": false, "targets": [4] }
        ]
    });
});