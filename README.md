# resize_observer
A Dart wrapper for the Resize Observer API

# API
```
// bool if the browser supports the Resize Observer API
ResizeObserver.supported

// Start observing an element for resizes
ResizeObserver.observe(Element element, ResizeObserverCallback callback);

// Stop observing resizes to [element]
ResizeObserver.unobserve(Element element);


// Callbacks must match the following signature
typedef void ResizeObserverCallback(Element element, num x, num y, num width, num height, num top, num bottom, num left, num right);
```

See [the example](https://github.com/robrbecker/resize_observer/blob/master/example/index.dart) for an example of how to use it.
