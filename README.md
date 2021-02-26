
# 미리보기 목차
<br></br>
### 📍  1.  화해 AutoLayout Clone 앱 (화해 어플 클론 코딩)
[폴더바로가기](https://github.com/Youngminah/iosproject12/tree/master/FirstApp)

`FirstApp`: iOS AutoLayout 

→ 화해 어플의 대표 화면을 AutoLayout 만을 이용하여 Clone 코딩한 앱.

→ 아이폰se까지 돌려도 화면이 깨지지 않은 AutoLayout을 적용.

### ▶︎ 실행화면
<img src="https://github.com/Youngminah/largegif/blob/master/hwahae.gif" title="auto gif" width="30%"/>

안드로이드 개발을 조금씩 해보다가 iOS 개발을 시작하니, 난해하였던 것 중 하나가 AutoLayout이였다.

안드로이드는 AutoLayout 없이 알아서 핸드폰 기종에 따라 view 위치가 알맞에 배분되었는데, iOS는 직접 해주어야한다. 🥲

<br></br>

-------------------------------------------------------
<br></br>

### 🎼  2. Random Music 추천 앱 (직접 구상)

[폴더바로가기](https://github.com/Youngminah/iosproject12/tree/master/LifeCycle)

`LifeCycle`: iOS LifeCycle을 다룬 앱 

→ 화면이 바뀔 때 마다 랜덤으로 뮤직을 추천하고 , 생명주기에 따라서 뮤직이 멈추고, 이어지는 것들을 구현한 앱.

→ LifeCycle의 모든 함수를 최대한 활용하기 위하여, 좋아요 추가, 랜덤으로 3가지 곡 생성. 알림창 띄우기. 플레이 조작하기. 등을 하였다.

→ 다크모드에도 적용 가능하게 구현 하였다.

→ 프로그래스 바는 Observer로 플레이어와 연결하여 사용자가 아무곳에 끌어 놓아도 그 위치에 알맞는 음악 구간이 실행되도록 하였다.

→ 싱글톤 디자인 패턴을 이용하여 플레이어를 하나만 생성하여 구현.

### ▶︎ 실행화면
<img src="https://github.com/Youngminah/largegif/blob/master/randomMusic.gif" title="music gif" width="30%"/>

최대한 MVVM패턴에 가깝게 디자인하려고 노력하였다.

하지만 아직 MVVM 패턴에 익숙하지 않은듯하다 😂 연습을 계속 해봐야 할 것 같다.




<br></br>

-------------------------------------------------------
<br></br>


### 📒  3.  연락처 앱 (직접 구상)
[폴더바로가기](https://github.com/Youngminah/iosproject12/tree/master/TableView)

`TableView`: iOS 테이블 뷰 연습 앱

→ 테이블 뷰를 만들기 위한 필수 프로토콜과 그 밖의 다양한 프로토콜을 사용하여 연락처를 저장하는 앱 구현.

→ CRUD의 Create(생성), Read(읽기), Update(갱신), Delete(삭제)를 가능하게 하는 기능 모두 구현.

→ Codable을 이용하여 Json 파일로 저장하여 연락처가 실시간으로 저장되게 하였다.


### ▶︎ 실행화면
<img src="https://github.com/Youngminah/largegif/blob/master/PhoneBook.gif" title="phone book gif" width="30%"/>
<br></br>

어려웠던 점은 헤더 섹션을 2가지로 나누어 즐겨찾기를 바로바로 업데이트 하는 부분이였다. 생각보다 어려웠다 ㅠ

처음에는 배열을 이용해서 기능 수행하는 단위들을 묶지 않게 구현을 하였는데, 수정을 거쳐 기능을 수행하는 단위들은 구조체로 묶어 구현하여 접근과 코드의 가독성을 높혔다. (이 부분을 깔끔히 구현하는 데는 오래걸렸고, 앞으로도 이렇게 하려면 숙련이 필요한 듯 싶다)

의외로 네이게이션 바를 디자인 하는게 어려웠다. 도저히 깔끔히 되지 않자 그냥 기본적인 디자인을 사용하여 구현하였는데, 디자인 연습도 많이 해보아야 할 듯 싶다.


-------------------------------------------------------
<br></br>

### 🐳  4. Under The Sea - Game 앱 (직접 구상)
[폴더바로가기](https://github.com/Youngminah/iosproject12/tree/master/MultiThreadGame)

`MutitheradGame`: iOS Multithread GCD 

→ SpriteKit을 사용하지 않고, 애니메이션과 Multithread GCD를 이용하여 구현한 게임 앱.

→ 어릴적 즐겨했던 쥬니버 네이버에 있는 게임을 모티브로 하여 이미지와 음악까지 직접 구상하여 구현.



### ▶︎ 실행화면
<img src="https://github.com/Youngminah/largegif/blob/master/UnderTheSea.gif" alt="under the sea gif" title="Databay showcase gif" width="30%"/>
<br></br>

GCD를 가장 잘 활용해보고 써볼 수 있는 것이 게임이라고 생각하였으나, 아무리 찾아봐도 게임에선 GCD를 이용하지 않더라.

애플은 대부분의 모션 동작이 있는 게임을 SpriteKit를 활용하여 구현한다. 

엄청난 노가다 검색 끝에 알게된 사실이 있다.

SpriteKit와 DispatchQueue를 같이 사용하는 것은 서버에서 데이터를 불러오는 일이 아닌 이상 최대한 피하라고 애플 개발자 포럼 홈페이지에 많은 이들이 답변 하였다.

애플은 대부분의 모션 동작이 있는 게임을 SpriteKit를 활용하여 구현한다. 엄청난 노가다 검색 끝에 알게된 사실이 있다. 

` SpriteKit와 DispatchQueue를 같이 사용하는 것은 서버에서 데이터를 불러오는 일이 아닌 이상 최대한 피하라 ` 고 애플 개발자 포럼 홈페이지에 많은 이들이 답변 하였다.

spriteKit없이 GCD와 애니메이션만을 이용하여 간단한 게임을 만들어보고자 설계하게된 게임이다.
확실히 충돌효과를 감지할때, 캐릭터의 디테일한 부분까지 미세한 적용은 구현하기 까다로운 것 같다. (불가능은 아니다. 엄청난 노가다일뿐..)

충돌을 감지하는 것을 구현하는것은 엄청난 노가다 일 줄 알았는데 intersects라는 아주~ 편리한 함수가 있어서 비교적 쉽게 구현하였다 ㅎㅅㅎ

하지만 멀티쓰레드를 활용해보고 개념을 확실히 깨닫고자 구현을 시작하게 되었는데, 꽤 괜찮게 구현되었다. 

물론 다음에 게임을 구현하라하면 spriteKit를 무조건 이용할 계획이다😧
