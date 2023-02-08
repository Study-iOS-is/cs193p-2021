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
  - 이제 click하면 isFaceUp이 가리키는 값이 바뀌고 이에 따라 view도 바뀐다.
    - isFaceUp이 가리키는 값이 바뀔 때마다 이를 감지하고 View를 rebuild / recreate the body한다. 
    - Game Logic이 변하면, 어느 뷰가 바뀌어야할지 파악하고 그 view의 body를 rebuild함
    - rebuild하는 이유 : body 는 read-only이기 때문
- simulater 모드 
  - selectable
  - live

### 2-3
- card에 content stored property를 추가하자.
  - hard coding된 이모지를 바꿔 더 flexible한 card view로 재탄생!
- option + click 하면 documentation을 볼 수 있다. 
  - 공문 잘 보세요 :)
  - 검색도 가능함
  - String, Array 같은 주요 Type 들은 Instruction만 봐도 큰 도움이 됨.
- Developer Documentation으로 Doc을 만들 수 있다.

- ForEach
  - bag of lego maker.
  - 따라서 view combiner에 넣어줘야 한다. ForEach의 return값은 body의 return값이 될 수 없다.
  - Identifiable:
    ```swift
    ForEach(emojis) { emoji in
        CardView(content: emoji)
    }
    ```
    - 발생한 에러: Referencing initializer 'init(_:content:)' on 'ForEach' requires that 'String' conform to 'Identifiable'
    - `String: Identifiable`: `String` hehaves like `Identifiable`
    - Unique ID가 있음
    - 왜 forEach에서 unique identifier가 있어야 할까?
      - emojis라는 array가 재정렬되거나, array에 새로운 요소가 삽입, 삭제될 때 등등의 상황에
      - 어떤 친구가 어떻게 바뀌었는지 알 수 있어야 하고(id로)
      - 이를 바탕으로 view를 adjust한다.
    - 그런데, String은 id가 없음. 
      - `["🍎", "🍎"]` 두 동일한 이모지는 String 값 자체만 봤을 때 동일하다.
      - 이는 추후 문제가 되지 않음. 지금은 emojis로 ForEach를 돌지만, 나중에는 Cards로 돌기 때문
      - game logic인 card를 구현하기 전까지, 실제로는 그렇지 않지만 string의 값을 id로 사용하고 emojis에는 같은 emoji를 넣지 않을 거야.
        - 같은 emoji가 있다면, 두 카드에 guesture event callback이 동시에 적용된다.
      - `id: \.self` : String itself
      - 
