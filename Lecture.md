# 1
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

# 2

- custom view type
- custom view type에 stored property 추가
- ZStack 안에 local variable을 선언할 수도 있다.
  - 강의와 달리 var여도 별 다른 노란 경고가 발생하지는 않음!