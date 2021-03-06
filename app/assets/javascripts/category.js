$(document).on('turbolinks:load',function(){
  // カテゴリセレクトボックスのオプション
  function appendOption(category){
    let html =`<option value='${category.id}' data-category='${category.id}'>${category.name}</option>`;
    return html;
  }

  // 子カテゴリのセレクトボックス作成
  function appendChidrenBox(insertHTML){
    let childSelectHtml = '';
    childSelectHtml = `<div class='new__main__container__category__added' id='children_wrapper'>
                        <div class='new__main__container__category__box' id='children_wrapper_box'>
                          <select class='new__main__container__category__box--select' id='child_category' name='item[category_id]'>
                            <option value='---' data-category='---'>選択してください</option>
                            ${insertHTML}
                          </select>
                        </div>
                      </div>`;
    $('.new__main__container__category__box').append(childSelectHtml);
  }

  // 孫カテゴリのセレクトボックス作成
  function appendGrandchidrenBox(insertHTML){
    let grandchildSelectHtml = '';
    grandchildSelectHtml = `<div class='new__main__container__category__added' id= 'grandchildren_wrapper'>
                              <div class='new__main__container__category__box' id= 'grandchildren_wrapper_box'>
                                <select class='new__main__container__category__box--select' id='grandchild_category' name='item[category_id]'>
                                  <option value='---' data-category='---'>選択してください</option>
                                  ${insertHTML}
                                </select>
                              </div>
                            </div>`;
    $('#children_wrapper_box').append(grandchildSelectHtml);
  }

  // 親カテゴリ選択後のイベント
  $('#parent_category').on('change', function(){
    let parent_category_id = document.getElementById('parent_category').value; // 選択された親カテゴリの名前を取得
    ('parent_category').value;
    if (parent_category_id != "選択してください"){ // 親カテゴリが初期値でないときイベント発火
      $.ajax({
        url: '/items/get_category_children',
        type: 'GET',
        data: { parent_id: parent_category_id},
        dataType: 'json'
      })
      .done(function(children){
        $('#children_wrapper').remove(); // 親カテゴリが変更されたとき、子・孫カテゴリを削除する
        $('#grandchildren_wrapper').remove();
        let insertHTML = '';
        children.forEach(function(child){
          insertHTML += appendOption(child);
        });
        appendChidrenBox(insertHTML);
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました'); // カテゴリ取得失敗時にアラート表示
      })
    }else{ // 親カテゴリが初期値になったとき、子・孫カテゴリを削除する
      $('#children_wrapper').remove(); 
      $('#grandchildren_wrapper').remove();
    }
  });

  // 子カテゴリ選択後のイベント
  $('.new__main__container__category__box').on('change', '#child_category', function(){
    let childId = $('#child_category option:selected').data('category'); // 選択された子カテゴリのidを取得
    if (childId != "選択してください"){ // 子カテゴリが初期値でないときイベント発火
      $.ajax({
        url: '/items/get_category_grandchildren',
        type: 'GET',
        data: { child_id: childId },
        dataType: 'json'
      })
      .done(function(grandchildren){
        if (grandchildren.length != 0) {
          $('#grandchildren_wrapper').remove(); // 子カテゴリが変更されたとき孫カテゴリを削除する
          let insertHTML = '';
          grandchildren.forEach(function(grandchild){
            insertHTML += appendOption(grandchild);
          });
          appendGrandchidrenBox(insertHTML);
        }
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました'); // カテゴリ取得失敗時にアラート表示
      })
    }else{
      $('#grandchildren_wrapper').remove(); //子カテゴリが初期値になったとき孫カテゴリを削除する
    }
  });
});