import 'dart:html';
import 'dart:async';

import 'package:resize_observer/resize_observer.dart';

Future<Null> main() async {
  Element textarea = document.getElementById('textarea');
  ResizeObserver.observe(textarea, p);

  document.getElementById('supported').innerHtml = ResizeObserver.supported.toString();
  
  document.getElementById('observeBtn').onClick.listen( (_) {
    ResizeObserver.observe(textarea, p);
  });
  document.getElementById('unobserveBtn').onClick.listen( (_) {
    ResizeObserver.unobserve(textarea);
  });
}

void p(Element el, num x, num y, num width, num height, num top, num bottom, num left, num right) {
  el.text = 'x: $x y: $y width: $width height: $height top: $top left: $left bottom: $bottom right: $right';
}
