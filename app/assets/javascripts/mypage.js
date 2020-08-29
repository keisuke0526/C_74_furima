$(function() {
  // タブのDOM要素を取得し、変数で定義
  let tabs = $(".container-tabs__item");
  // tabsを配列に変換する
  tabsAry = Array.prototype.slice.call(tabs);
    // クラスの切り替えをtabSwitch関数で定義
    function tabSwitch() {
      // 全てのactiveクラスのうち、最初の要素を削除
      $(".active").removeClass("active");
  
      // クリックしたタブにactiveクラスを追加
  
      $(this).addClass("active");
  
      // 何番目の要素がクリックされたかを、配列tabsから要素番号を取得
      const index = tabs.index(this);
  
      // contentクラスの全てのshowクラスを削除した後、クリックされたタブの要素番号と一致するcontentクラスの要素だけ、showクラスを追加する
      $(".container-body__item").removeClass("show").eq(index).addClass("show");
    }
  
    // タブがクリックされたらtabSwitch関数を呼び出す
    tabs.click(tabSwitch);  
});
$(function() {
  let tabs = $(".container-dealing-tabs__item");
  tabsAry = Array.prototype.slice.call(tabs);
    function tabSwitch() {
      $(".active2").removeClass("active2");
      $(this).addClass("active2");
      const index = tabs.index(this);
      $(".dealing-body__item").removeClass("show2").eq(index).addClass("show2");
    }
    tabs.click(tabSwitch);  
});