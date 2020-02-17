$(function () {
    $(document).on('click', "[data-form-prepend]", function (e) {
        var obj = $($(this).attr("data-form-prepend"));
        obj.find("input, select, textarea").each(function () {
            $(this).attr("name", function () {
                return $(this)
                    .attr("name")
                    .replace("new_record", new Date().getTime());
            });
        });
        obj.insertBefore(this);
        return false;
    });

    $(document).on('click', '[data-form-remove]', function (e) {
        var name = $(this).attr('data-form-remove');
        var target = $(this).data('target') || '.fields';
        $(this).closest(target).hide();
        var destroyInput = $('<input type="hidden">').attr('name', name + '[_destroy]').val(1);
        $(this).before(destroyInput);
        return false;
    });
});
