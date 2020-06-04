// カーソルを合わせた画像をメイン画像へ変更する
$(document).on('turbolinks:load', function() {
  $('.image__list').hover(function () {
    var $src = $(this).attr('src');
    $('.main__image').attr('src', $src);
  });
});
