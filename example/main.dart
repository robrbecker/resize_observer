import 'dart:html';
import 'dart:async';

import 'package:resize_observer/resize_observer.dart' as ro;

bool observing = true;

Future<void> main() async {
  final textarea = document.getElementById('textarea')!;
  final obsEl = document.getElementById('observing')!;

  ro.ResizeObserver.observe(textarea, _onResize);
  obsEl.innerHtml = observing.toString();

  document.getElementById('supported')!.innerHtml =
      ro.ResizeObserver.supported.toString();

  document.getElementById('observeBtn')!.onClick.listen((_) {
    ro.ResizeObserver.observe(textarea, _onResize);
    observing = true;
    obsEl.innerHtml = observing.toString();
  });
  document.getElementById('unobserveBtn')!.onClick.listen((_) {
    ro.ResizeObserver.unobserve(textarea);
    observing = false;
    obsEl.innerHtml = observing.toString();
  });
}

void _onResize(Element el, num x, num y, num width, num height, num top,
    num bottom, num left, num right) {
  el.text =
      'x: $x y: $y width: $width height: $height top: $top left: $left bottom: $bottom right: $right';
}
