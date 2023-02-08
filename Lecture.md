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
  - ~~강의와 달리 var여도 별 다른 노란 경고가 발생하지는 않음!~~ 발생함! 
- 스위프트의 타입 추론과 강타입

- @State
  - 붙이지 않았다면?
    - struct인 view의 stored property를 변경 불가능 - self는 immutable이므로
    ```swift
    var body: some View = {
        ...
    }
    // Cannot assign to property: 'self' is immutable
    .onTapGesture {
        isFaceUp = !isFaceUp
    }
    ```
- `@State var isFaceUp`
  - 어떻게 동작? 
    - ❌ isFaceUp이 mutable이 되었다
    - 메모리 어디엔가 isFaceUp을 나타내는 boolean 값이 있고, self.isFaceUp은 이에 대한 reference임
    - 즉, self.isFaceUp 이라는 pointer는 immutable하다.
  - 근데 이걸 많이 쓰지는 않을거야.
    - 이후에 게임 logic 파트에서 변경 후 UI로 끌어오기 때문
    - 이건 단순한 temperary state임
      - 멀티 터치 했는지 여부
      - 드래그 중인지
      - 뷰가 보여지는 방식을 제어하기 위해?
        - 게임이 진행될 때 아닐 때 어떻게 보여지는지