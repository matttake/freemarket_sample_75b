$(document).on('turbolinks:load', ()=> {
  // 画像用のinputを生成する関数
  const buildFileField = (num)=> {
    const html = `<div data-index="${num}" class="js-file_group">
                    <input class="js-file" type="file"
                    name="product[images_attributes][${num}][src]"
                    id="product_images_attributes_${num}_src"><br>
                    <div class="js-remove">削除</div>
                  </div>`;
    return html;
  }
  // プレビュー用のimgタグを生成する関数
  const buildImg = (index, url)=> {
    const html = `<img data-index="${index}" src="${url}" width="100px" height="100px">`;
    return html;
  }

  // file_fieldのnameに動的なindexをつける為の配列
  let fileIndex = [1,2,3,4,5,6,7,8,9,10];
  // 既に使われているindexを除外
  lastIndex = $('.js-file_group:last').data('index');
  fileIndex.splice(0, lastIndex);

  $('.hidden-destroy').hide();

  $('#image-box').on('change', '.js-file', function(e) {
    const targetIndex = $(this).parent().data('index');
    // ファイルのブラウザ上でのURLを取得する
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);

    // 該当indexを持つimgがあれば取得して変数imgに入れる(画像変更の処理)
    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
      img.setAttribute('src', blobUrl);
    } else {  // 新規画像追加の処理
      $('#previews').append(buildImg(targetIndex, blobUrl));
      // fileIndexの先頭の数字を使ってinputを作る
      $('#image-box').append(buildFileField(fileIndex[0]));
      fileIndex.shift();
      // 末尾の数に1足した数を追加する
      fileIndex.push(fileIndex[fileIndex.length - 1] + 1);
    }
  });

  $('#image-box').on('click', '.js-remove', function() {
    const targetIndex = $(this).parent().data('index');
    // 該当indexを振られているチェックボックスを取得する
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
    // もしチェックボックスが存在すればチェックを入れる
    if (hiddenCheck) hiddenCheck.prop('checked', true);

    $(this).parent().remove();
    $(`img[data-index="${targetIndex}"]`).remove();

    // 画像入力欄が0個にならないようにしておく
    if ($('.js-file').length == 0) $('#image-box').append(buildFileField(fileIndex[0]));
  });
});









// $(document).on('turbolinks:load', function(){
//   var dropzone = $('.dropzone-area');
//   var dropzone2 = $('.dropzone-area2');
//   var dropzone_box = $('.dropzone-box');
//   var images = [];
//   var inputs  =[];
//   var input_area = $('.input_area');
//   var preview = $('#preview');
//   var preview2 = $('#preview2');

//   $(document).on('change', 'input[type= "file"].upload-image',function(event) {
//     var file = $(this).prop('files')[0];
//     var reader = new FileReader();
//     inputs.push($(this));
//     var img = $(`<div class= "img_view"><img></div>`);
//     reader.onload = function(e) {
//       var btn_wrapper = $('<div class="btn_wrapper"><div class="btn edit">編集</div><div class="btn delete">削除</div></div>');
//       img.append(btn_wrapper);
//       img.find('img').attr({
//         src: e.target.result
//       })
//     }
//     reader.readAsDataURL(file);
//     images.push(img);

//     if(images.length >= 5) {
//       dropzone2.css({
//         'display': 'block'
//       })
//       dropzone.css({
//         'display': 'none'
//       })
//       $.each(images, function(index, image) {
//         image.attr('data-image', index);
//         preview2.append(image);
//         dropzone2.css({
//           'width': `calc(100% - (135px * ${images.length - 5}))`
//         })
//       })
//       if(images.length == 9) {
//         dropzone2.find('p').replaceWith('<i class="fa fa-camera"></i>')
//       }
//     } else {
//         $('#preview').empty();
//         $.each(images, function(index, image) {
//           image.attr('data-image', index);
//           preview.append(image);
//         })
//         dropzone.css({
//           'width': `calc(100% - (135px * ${images.length}))`
//         })
//       }
//       if(images.length == 4) {
//         dropzone.find('p').replaceWith('<i class="fa fa-camera"></i>')
//       }
//     if(images.length == 10) {
//       dropzone2.css({
//         'display': 'none'
//       })
//       return;
//     }
//     var new_image = $(`<input multiple= "multiple" name="product_images[image][]" class="upload-image" data-image= ${images.length} type="file" id="upload-image">`);
//     input_area.prepend(new_image);
//   });
//   $(document).on('click', '.delete', function() {
//     var target_image = $(this).parent().parent();
//     $.each(inputs, function(index, input){
//       if ($(this).data('image') == target_image.data('image')){
//         $(this).remove();
//         target_image.remove();
//         var num = $(this).data('image');
//         images.splice(num, 1);
//         inputs.splice(num, 1);
//         if(inputs.length == 0) {
//           $('input[type= "file"].upload-image').attr({
//             'data-image': 0
//           })
//         }
//       }
//     })
//     $('input[type= "file"].upload-image:first').attr({
//       'data-image': inputs.length
//     })
//     $.each(inputs, function(index, input) {
//       var input = $(this)
//       input.attr({
//         'data-image': index
//       })
//       $('input[type= "file"].upload-image:first').after(input)
//     })
//     if (images.length >= 5) {
//       dropzone2.css({
//         'display': 'block'
//       })
//       $.each(images, function(index, image) {
//         image.attr('data-image', index);
//         preview2.append(image);
//       })
//       dropzone2.css({
//         'width': `calc(100% - (135px * ${images.length - 5}))`
//       })
//       if(images.length == 9) {
//         dropzone2.find('p').replaceWith('<i class="fa fa-camera"></i>')
//       }
//       if(images.length == 8) {
//         dropzone2.find('i').replaceWith('<p>ココをクリックしてください</p>')
//       }
//     } else {
//       dropzone.css({
//         'display': 'block'
//       })
//       $.each(images, function(index, image) {
//         image.attr('data-image', index);
//         preview.append(image);
//       })
//       dropzone.css({
//         'width': `calc(100% - (135px * ${images.length}))`
//       })
//     }
//     if(images.length == 4) {
//       dropzone2.css({
//         'display': 'none'
//       })
//     }
//     if(images.length == 3) {
//       dropzone.find('i').replaceWith('<p>ココをクリックしてください</p>')
//     }
//   })
// });












// function buildImage(loadedImageUri){
//   var html =
//   `<li>
//     <img src=${loadedImageUri}>
//     <div class="item__images__container__preview__box">
//       <div class="item__images__container__preview__box__edit" >
//         編集
//       </div>
//       <div>
//         <a class="item__images__container__preview__box__delete">削除</a>
//       </div>
//     </div>
//   </li>`
//   return html
// };
// // 画像を管理するための配列を定義する。
// var files_array = [];
// // 通常のドラッグオーバイベントを止める。
// $('.item__images__container__guide').on('dragover',function(e){
//     e.preventDefault();
// });
// // ドロップ時のイベントの作成
// $('.item__images__container__guide').on('drop',function(event){
//   event.preventDefault();
//     // 何故か、dataTransferがうまくいかなかったので、originalEventから読み込んでいます。
//     // ここで、イベントによって得たファイルを配列で取り込んでいます。
//   files = event.originalEvent.dataTransfer.files;
//     // 画像のファイルを一つづつ、先ほどの画像管理用の配列に追加する。
//   for (var i=0; i<files.length; i++) {
//     files_array.push(files[i]);
//     var fileReader = new FileReader();
//     // ファイルが読み込まれた際に、行う動作を定義する。
//     fileReader.onload = function( event ) {
//     // 画像のurlを取得します。
//     var loadedImageUri = event.target.result;
//     // 取得したURLを利用して、ビューにHTMLを挿入する。
//     $(buildImage(loadedImageUri,)).appendTo(".item__images__container__preview ul").trigger("create");
//     };
//     // ファイルの読み込みを行う。
//     fileReader.readAsDataURL(files[i]);
//   }
// });


// $(document).on('click','.item__images__container__preview a', function(){
//   // index関数を利用して、クリックされたaタグが、div内で何番目のものか特定する。
//   var index = $(".item__images__container__preview a").index(this);
//   // クリックされたaタグの順番から、削除すべき画像を特定し、配列から削除する。
//   files_array.splice(index - 1, 1);
//   // クリックされたaタグが含まれるli要素をHTMLから削除する。
//   $(this).parent().parent().parent().remove();
// });



// // submitボタンが押された際のイベント
// $('#new_item').on('submit', function(e){
//   e.preventDefault();
//   // そのほかのform情報を以下の記述でformDataに追加
//   var formData = new FormData($(this).get(0));
//   // ドラッグアンドドロップで、取得したファイルをformDataに入れる。
//   files_array.forEach(function(file){
//    formData.append("image[images][]" , file)
//   });
//   $.ajax({
//     url:         '/items',
//     type:        "POST",
//     data:        formData,
//     contentType: false,
//     processData: false,
//     dataType:   'json',
//   })
//   .done(function(data){
//     alert('出品に成功しました！');
//   })
//   .fail(function(XMLHttpRequest, textStatus, errorThrown){
//     alert('出品に失敗しました！');
//   });
// });






