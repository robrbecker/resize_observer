import 'dart:html';
import 'dart:js';

/// A callback for ResizeObserver must conform to this signature
typedef void ResizeObserverCallback(Element element, num x, num y, num width, num height, num top, num bottom, num left, num right);

/// Resize Observer
abstract class ResizeObserver {
  /// true if this browser supports native Resize Observer API
  static bool supported = context['ResizeObserver'] != null;

  static final JsObject _resizeObserver = _initResizeObserver();

  static Map<Element, ResizeObserverCallback> _callbackMap = <Element, ResizeObserverCallback>{};

  static JsObject _initResizeObserver() {
    if (supported) {
      return new JsObject(context['ResizeObserver'], [_dispatchResizes]);
    }
    return null;
  }

  static void _dispatchResizes(JsArray entries, JsObject jsResizeObserver) {
    if (entries == null) {
      return;
    }
    for (JsObject entry in entries) {
      Element target = entry['target'];
      
      if (!document.contains(target)) {
        ResizeObserver.unobserve(target);
        return;
      }

      ResizeObserverCallback callback = _callbackMap[target];
      if (target != null && callback != null) {
        JsObject rect = entry['contentRect'];
        if (rect != null) {
          callback(target, rect['x'],rect['y'],rect['width'],rect['height'],rect['top'],rect['bottom'],rect['left'],rect['right']);
        }
      }
    }
  }

  /// Start observing an [element] for resizes
  static void observe(Element el, ResizeObserverCallback callback) {
    _callbackMap[el] = callback;
    if (_resizeObserver != null) {
      _resizeObserver.callMethod('observe', [el]);
    }
  }

  /// Stop observing resizes to [element]
  static void unobserve(Element el) {
    _callbackMap.remove(el);
    if (_resizeObserver != null) {
      _resizeObserver.callMethod('unobserve', [el]);
    }
  }
}
