import 'dart:html';
import 'dart:js';

/// A callback for ResizeObserver must conform to this signature
typedef void ResizeObserverCallback(Element element, num x, num y, num width,
    num height, num top, num bottom, num left, num right);

/// Resize Observer
abstract class ResizeObserver {
  /// true if this browser supports native Resize Observer API
  static bool supported = context['ResizeObserver'] != null;

  static final JsObject? _resizeObserver = _initResizeObserver();

  static final Map<Element, ResizeObserverCallback> _callbackMap =
      <Element, ResizeObserverCallback>{};

  static JsObject? _initResizeObserver() {
    if (supported) {
      return JsObject(
          context['ResizeObserver'], <dynamic>[_dispatchResizes]);
    }
    return null;
  }

  static void _dispatchResizes(
      JsArray<dynamic> entries, JsObject jsResizeObserver) {
    for (dynamic entry in entries) {
      if (entry is JsObject) {
        Element? target = entry['target'];

        if (!document.contains(target)) {
          ResizeObserver.unobserve(target!);
          return;
        }

        ResizeObserverCallback? callback = _callbackMap[target!];
        if (callback != null) {
          JsObject? rect = entry['contentRect'];
          if (rect != null) {
            callback(
                target,
                rect['x'],
                rect['y'],
                rect['width'],
                rect['height'],
                rect['top'],
                rect['bottom'],
                rect['left'],
                rect['right']);
          }
        }
      }
    }
  }

  /// Start observing an [element] for resizes
  static void observe(Element? element, ResizeObserverCallback callback) {
    if (element == null) {
      return;
    }
    _callbackMap[element] = callback;
    if (_resizeObserver != null) {
      _resizeObserver!.callMethod('observe', <dynamic>[element]);
    }
  }

  /// Stop observing resizes to [element]
  static void unobserve(Element? element) {
    _callbackMap.remove(element);
    if (_resizeObserver != null) {
      _resizeObserver!.callMethod('unobserve', <dynamic>[element]);
    }
  }
}
