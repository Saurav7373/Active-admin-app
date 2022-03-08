//= require active_admin/base
//= require select2-full
//= require active_admin/select2


/* for inseting panel in index for post */
(function($) {
    $(document).ready(function() {
        $("#get_lower").insertAfter(".index_table");
    });
})(jQuery);