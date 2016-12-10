function malert ( msg ) {
  alert(msg);
}

function scrollToTop (scroll, interval) {
  var timer = setInterval(function(){
    var y = window.pageYOffset;
    if ( y == 0 ) {
      clearInterval(timer);
    } else {
      window.scrollBy(0, scroll);
    }
  },interval);
}

