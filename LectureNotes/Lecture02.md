# Lecture 2

## 2-1. Create Custom View Type-CardView

- custom view type

## 2-2. Custom View Type with Stored Property

- custom view type에 stored property 추가
- ZStack 안에 local variable을 선언할 수도 있다.
  - ~~강의와 달리 var여도 별 다른 노란 경고가 발생하지는 않음!~~ 발생함!
- 스위프트의 타입 추론과 강타입

## 2-3. @State

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

- card에 content stored property를 추가하자.
  - hard coding된 이모지를 바꿔 더 flexible한 card view로 재탄생!
- option + click 하면 documentation을 볼 수 있다.
  - 공문 잘 보세요 :)
  - 검색도 가능함
  - String, Array 같은 주요 Type 들은 Instruction만 봐도 큰 도움이 됨.
- Developer Documentation으로 Doc을 만들 수 있다.

## 2-4. ForEach, Identifiable

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
      - behaves like ==> Functional Programming
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

## 2-5: Buttons

- 카드를 추가하고 빼는 버튼을 달거야.
  - range
    - `m...n` : m부터 n까지
    - `m..<n` : m부터 n-1까지
  - Button(action: ()->Void, label: ()->View)
    - label은 왜 function일까?
      - label의 type은 ViewBuilder function
  - Spacer()
    - minLength 설정 가능
    - default는 기기마다 다르다
  - computed property in View
  - SFSymbols
    - `Image(systemName: "plus.circle")`
    - `+ / -` 상한 설정하기
    - 하지 않으면 Preview crash 발생
      - n이 0보다 작을 때
      - n이 count보다 클 때
  - some View:
    - 어떤 View.. 정확한 타입 x
    - 왜 View가 아니라 some View?
      - 추가하기!!
  - ViewBuilder
    - ViewBuilder 안에 여러 View를 쭉 선언하면 됨.

## 2-6 LazyVGrid, ScrollView, Adoptive Grid Item

- 버튼 색 -> blue
  - 터치할 수 있음?
  - default 색깔은 blue임
- LazyVGrid
  - params - columns가 고정, row는 가변적
    - LazyHGrid는 rows가 고정, columns가 가변
  - GridItem
    - 왜 int가 아니라 GridItem으로?
    - GridItem을 받음으로서 할 수 있는 것: GridItem을 설정해서
      - `GridItem(.fixed(200))`
      - default: flexible
  - HStack 안에서는 height가 길었는데, LazyVGrid 안에서는 작아짐
  - default로 설정된 wh는 다음과 같다.
    - width는 gridItem에 따라
    - height는 가능한한 smaller
  - Grid가 점유하는 공간이 작아졌음에도 button이 계속 맨아래에 있을 수 있는 이유는, 둘 사이 공간을 Spacer()가 모두 점유하고 있기 때문
    - padding / spacer 를 넣었을 때, 레이아웃이 어떻게 바뀌는지 알아두자
- Card를 더 Card답게 보이게 하고 싶어
  - aspect ratio를 w:h = 2:3로 하고 싶은 경우
    - `aspectRatio(2/3, contentMode: .fit)`
    - .fill vs .fit
- Scroll되게 하고 싶어 -> LazyVGrid를 ScrollView안에 넣으면 됨
  - 문제상황: Card가 너무 많아서 버튼이 보이지 않음
- lazy는 나중에 다룰거야
  - lazyVGrid is lazy about accessing the body vars of all of its Views. we only get the value of a body var in a LazyVGrid for Views that actually appear on screen. So this LazyVGrid could scale to having thousand of cards, 왜나하면 보통 creating views는 가벼운 작업임. 보통 view는 적은 property만 갖고 있음. isFaceUp같이.
  - 근데 accessing a View's body는 다른 얘기임
  - That's going to create a whole bunch of other Views, and potentially cause some of their body vars to get accessed
  - So there's a lot of infastructure in SwiftUI to only access a View's body var when absolutely necessary.
  - This laziness we see in LazyVGrid
  - 다음주에, 언제, 어떻게 system이 View's body var에 access하는지 더 자세히 공부할거야.
- ScrollView에서 가장자리 좌우가 잘리는 현상
  - 왜?
    - stroke는 border에서 시작해서 lineWidth만큼 그림
    - 그래서 일부는 안쪽에, 일부는 바깥에 그려진 것 처럼 보임
  - 원하는 것?
    - inside the boundaries of the Shape.
  - 해결 방법
    - strokeBorder() method로 변경
- landscape 버전에서는 column개수를 늘리고 싶어
  - 문제
    - 화면 회전시 fixed column이 아니었으면 좋겠다.
  - 해결
    - `LazyVGrid(columns: [GridItem(.adoptive(minimum: CGFloat?))])`
    - 각 row에 가능한 한 많은 item을 담으려고 한다.
    - 따라서 minimum width를 설정해야 한다.
    - ScrollView라서 다행임. 보통은, It's hard to pick a width that works well in both portrait and landscape. What we really want to do is pick our width based on how much screen real state is being offered to us. We'll learn how to do that later next week or the weak after, but 지금은 일단 80이라고 두자. (스크롤 뷰 덕분에 overflow(?)인 카드들도 확인 가능함.)

## Coming up next

- game logic!
