document.addEventListener(
  "DOMContentLoaded", e => {
    if (document.getElementById("token_submit") != null) { //token_submitというidがnullの場合、下記コードを実行しない
      Payjp.setPublicKey("pk_test_f156f3cfc1743f10f6aff39d"); 
      let btn = document.getElementById("token_submit"); //IDがtoken_submitの場合に取得
      btn.addEventListener("click", e => { //ボタンが押された時に作動
        e.preventDefault(); //ボタンを一旦無効化
        let card = {
          number: document.getElementById("card_number").value,
          cvc: document.getElementById("cvc").value,
          exp_month: document.getElementById("exp_month").value,
          exp_year: "20" + document.getElementById("exp_year").value
        }; //入力されたデータを取得
        // console.table(card)
        Payjp.createToken(card, (status, response) => {
          if (status === 200) { //成功した場合
            $("#card_number").removeAttr("name");
            $("#cvc").removeAttr("name");
            $("#exp_month").removeAttr("name");
            $("#exp_year").removeAttr("name"); 
            $("#card_token").append(
              $('<input type="hidden" name="payjp-token">').val(response.id)
            ); //取得したトークンを送信できる状態にする
            console.log(response)
            $("form")[0].submit();
            alert("登録が完了しました"); //確認
          } else {
            alert("カード情報が正しくありません。"); //確認
          }
        });
      });
    }
  },
  false
);