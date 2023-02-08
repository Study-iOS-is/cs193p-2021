# 1
## 왜 Some View인가?
- opaque return type
```swift
Text("Hello world!"): Text
Text("hi").foregroundColor(.red): some View 
// Error:
// Property definition has inferred type 'some View', involving the 'some' return type of another declaration
```
