const pay = () => {
  // 環境変数はJavaScriptで呼び出せないので、touch config/initializers/webpacker.rbコマンドを使用して、環境変数を使用できるようにする
  // config/initializers/webpacker.rbにてWebpacker::Compiler.env["PAYJP_PUBLIC_KEY"] = ENV["PAYJP_PUBLIC_KEY"]を記述する

  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY);
  const submit = document.getElementById("button");
  submit.addEventListener('click',(e) =>{
    e.preventDefault();
    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);

    const card = {
      number: formData.get("number"),
      cvc: formData.get("cvc"),
      exp_month: formData.get("exp_month"),
      exp_year: `20${formData.get("exp_year")}`,
    };

    // 通信が成功した時にカードトークンを作成する処理を行う
    Payjp.createToken(card,(status,response) => {
      if (status ==200){
        const token = response.id
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='card_token' type="hidden" >`;
        renderDom.insertAdjacentHTML("beforeend",tokenObj);
      }

      //カード情報をデータベースに保存されないようname属性を削除しなければならない
      document.getElementById("number").removeAttribute("name");
      document.getElementById("cvc").removeAttribute("name");
      document.getElementById("exp_month").removeAttribute("name");
      document.getElementById("exp_year").removeAttribute("name");

      document.getElementById("charge-form").submit();
    });
  });
};

window.addEventListener("load",pay)