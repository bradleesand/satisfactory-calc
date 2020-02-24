$(function () {
    $('.sortable').each(function () {
        const $this = $(this);
        let options = {
            draggable: '.item',
            handle: '.handle',
        };
        const sortableUrl = $this.data('sortableUrl'),
            authToken = $this.data('authToken');
        if (sortableUrl) {
            options.onEnd = function (evt) {
                const arr = $this.sortable('toArray');
                $.ajax({
                    method: 'PUT',
                    url: sortableUrl,
                    data: {
                        authenticity_token: authToken,
                        ids: arr
                    }
                });
            };
        }
        $this.sortable(options);
    });
});
