window.onload = function() {
  var btnElem = document.createElement('button');
  btnElem.type="button";
  btnElem.innerHTML="戻る";
  btnElem.style.position="fixed";
  btnElem.style.width=60;
  btnElem.style.height=40;
  btnElem.style.backgroundColor="#666C98";
  btnElem.style.color="white";

  var curUrl = window.location.href;
  var toUrl = curUrl.substring(0,curUrl.lastIndexOf("/"));
  var func = new Function("location.href='" + toUrl + "';");
  btnElem.onclick = func;

  document.body.appendChild(btnElem);
};
