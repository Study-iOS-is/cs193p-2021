# Lecture 1

## 왜 Some View인가?

- opaque return type

```swift
Text("Hello world!"): Text
// Error occured!
Text("hi").foregroundColor(.red): some View 
// Property definition has inferred type 'some View', involving the 'some' return type of another declaration
```

- padding

```swift
func padding(_ edges: Edge.Set = .all, _ length: CGFloat? = nil) -> some View
```

## Need To Study

- 왜 View가 아니라 Some View?
