function createBackButton() {
  var btnElem = document.createElement('button');
  btnElem.type="button";
  btnElem.innerHTML="戻る";
  btnElem.style.position="fixed";
  btnElem.style.width=70;
  btnElem.style.height=50;
  btnElem.style.backgroundColor="#666C98";
  btnElem.style.color="white";

  var curUrl = window.location.href;
  var toUrl = curUrl.substring(0,curUrl.lastIndexOf("/"));
  var func = new Function("location.href='" + toUrl + "';");
  btnElem.onclick = func;

  document.body.insertBefore(btnElem, document.body.firstChild);
}

window.onload = function() {
  createBackButton();
}
