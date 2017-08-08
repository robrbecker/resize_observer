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
```
