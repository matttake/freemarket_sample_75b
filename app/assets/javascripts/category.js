$(function(){
  // カテゴリセレクトボックスのオプション
  function appendOption(category){
    let html = `<option value = "${category.name}" data-category = "${category.id}">${category.name}</option>`;
    return html;
  }

  // 子カテゴリの表示
  function appendChildrenBox(insertHTML){
    let childSelectHtml = '';
    childSelectHtml = `<div class = "category-select-wrapper__added" id = "children_wrapper">
                        <div class = "category-select-wrapper__box">
                          <select class = "category-select-wrapper__box__select" id = "child_category" name = "category_id">
                          `
  }
})