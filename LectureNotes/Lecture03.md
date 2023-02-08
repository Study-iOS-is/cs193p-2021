# Lecture 3

## Architecture

- MVVM
  - design paradigm
- Swift Type System
  - struct
  - class
  - protocol
  - "Don't Care" type (aka generics)
  - enum
  - functions

## MVVM

### Model-View-ViewModel
- MVVM
  - SwiftUI pretty much does not work without MVVM.
  - MVVM is a different thing than MVC.
  - It separates the user interface code(View) from the backend or logic of our application(Model)
    - protocol View를 쌓아서 만든 것이 `View`
- Model
  - UI Independent
  - Data + Logic
  - What application is and does
    - Memorize의 경우, 카드 매칭 게임
    - 데이터: 카드
    - 로직: User가 카드를 선택했을 때 행위
  - the single source of truth about the data that represents our game
    - 다른 곳에는 (특히 뷰) 관련 정보를 저장하지 않음
    - eg. UI코드에 모델의 variable과 데이터를 담고 있지 않을 거임.
      - 이 준칙에 따라 isFaceUp은 Card에서 없어질 예정.
      - 대신, 모델에게 이 카드가 face up인지 아닌지 물어볼거임.
- View
  - How application is presented to user.