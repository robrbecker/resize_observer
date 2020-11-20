# resize_observer
A Dart wrapper for the Resize Observer API that uses JS interop and a single observer and convenient callback.
(This library is intended for web/browser use, not Flutter)

# API
```
// bool if the browser supports the Resize Observer API
ResizeObserver.supported

// Start observing an element for resizes
ResizeObserver.observe(Element? element, ResizeObserverCallback callback);

// Stop observing resizes to [element]
ResizeObserver.unobserve(Element? element);


// Callbacks must match the following signature
typedef void ResizeObserverCallback(Element element, num x, num y, num width, num height, num top, num bottom, num left, num right);
```

See [the example](https://github.com/robrbecker/resize_observer/blob/master/example/main.dart) for an example of how to use it.
