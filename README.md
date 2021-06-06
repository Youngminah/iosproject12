

# 🏷 진행 기간 미리보기


| 앱 이름                 | 주제           | 진행기간                         |  피드백                                           |
| --------------------- | ------------- | --------------------------     |-----------------------------------------------------|
| 화해 AutoLayout Clone  | AutoLayout    |  **2021.01.23 ~ 2021.01.30**    |  텍스트편집기를 사용하지 않고 서치바 이용이 더 적합해보임. |
| Random Music          | LifeCycle     |  **2021.01.20 ~ 2021.02.06**    |                                                      |
| Phone Book            | TableView     |  **2021.02.13 ~ 2021.02.20**    | 수정 기능만 있었으면 CRUD에 완벽했을 듯 함 (수정 기능 추가 완료)            |
| Under The Sea         | MultiThread   |  **2021.02.20 ~ 2021.02.27**    | |
| Daily Notice.         | Rest API      |  **2021.02.27 ~ 2021.03.06**    | |

<br></br>
<br></br>

# 🏷 프로젝트 미리보기

### 📍  1.  화해 AutoLayout Clone 앱 (화해 어플 클론 코딩)
[폴더바로가기](https://github.com/Youngminah/iosproject12/tree/master/FirstApp)

**`FirstApp`: iOS AutoLayout**

→ 화해 어플의 대표 화면을 AutoLayout 만을 이용하여 Clone 코딩한 앱.

→ 아이폰se까지 돌려도 화면이 깨지지 않은 AutoLayout을 적용.

#### ▶︎ 실행화면
<img src="https://github.com/Youngminah/iosproject12/blob/master/gif%EC%A0%80%EC%9E%A5%EC%86%8C/hwahae.gif" title="auto gif" width="30%"/>

#### ▶︎ 느낀점

안드로이드 개발을 조금씩 해보다가 iOS 개발을 시작하니, 난해하였던 것 중 하나가 `AutoLayout`이였다.

안드로이드는 `AutoLayout` 없이 알아서 핸드폰 기종에 따라 view 위치가 알맞에 배분되었는데, iOS는 직접 해주어야한다. 🥲

<br></br>

-------------------------------------------------------
<br></br>

### 🎼  2. Random Music 추천 앱 (직접 구상)

[폴더바로가기](https://github.com/Youngminah/iosproject12/tree/master/LifeCycle)

**`LifeCycle`: iOS LifeCycle을 다룬 앱** 

→ 화면이 바뀔 때 마다 랜덤으로 뮤직을 추천하고 , 생명주기에 따라서 뮤직이 멈추고, 이어지는 것들을 구현한 앱.

→ `LifeCycle`의 모든 함수를 최대한 활용하기 위하여, 좋아요 추가, 랜덤으로 3가지 곡 생성. 알림창 띄우기. 플레이 조작하기. 등을 하였다.

→ 다크모드에도 적용 가능하게 구현 하였다.

→ 프로그래스 바는 `Observer`로 플레이어와 연결하여 사용자가 아무곳에 끌어 놓아도 그 위치에 알맞는 음악 구간이 실행되도록 하였다.

→ 싱글톤 디자인 패턴을 이용하여 플레이어를 하나만 생성하여 구현.


#### ▶︎ iOS LifeCycle 함수 이용

| 함수이용         | 진행     | 코멘트                         |
| ----------- | ------- | ---------------------------- |
| viewDidLoad | ✔️       |  |
| viewWillAppear | ✔️       | |
| viewDidAppear   | ✔️       | |
| viewWillDisappear | ✔️       | |
| viewDidDisappear | ✔️        | |
| sceneDidDisconnect | ✔️        | |
| sceneDidBecomeActive | ✔️     | |
| sceneWillResignActive  | ✔️       | |
| sceneWillEnterForegroound | ✔️       | |
| sceneDidEnterBackgroound | ✔️      | |


#### ▶︎ 실행화면
<img src="https://github.com/Youngminah/iosproject12/blob/master/gif%EC%A0%80%EC%9E%A5%EC%86%8C/randomMusic.gif" title="music gif" width="30%"/>

#### ▶︎ 느낀점


최대한 MVVM패턴에 가깝게 디자인하려고 노력하였다.

하지만 아직 MVVM 패턴에 익숙하지 않은듯하다 😂 연습을 계속 해봐야 할 것 같다.




<br></br>

-------------------------------------------------------
<br></br>


### 📒  3.  연락처 앱 (직접 구상)
[폴더바로가기](https://github.com/Youngminah/iosproject12/tree/master/TableView)

**`TableView`: iOS 테이블 뷰 연습 앱**

→ 테이블 뷰를 만들기 위한 필수 프로토콜과 그 밖의 다양한 프로토콜을 사용하여 연락처를 저장하는 앱 구현.


#### ▶︎ CRUD

| 기능         | 진행     | 코멘트                         |
| ----------- | ------- | ---------------------------- |
| 작성(Create) | ✔️       | 네이게이션의 "+" 버튼 클릭시 작성 기능 |
| 보기(Read)   | ✔️       | 테이블 뷰에 보이기, 즐겨찾기 섹션 추가 가능 |
| 수정(Update) | ✔️       | 오른쪽으로 스와이프시 수정 가능      |
| 삭제(Delete) | ✔️       | 왼쪽으로 스와이프시 삭제 가능          |


### ▶︎ 추가 기능

| 기능                    | 진행      | 코멘트                             |
| ---------------------- | -------- | -------------------------------- |
| 길게 누르면 셸 위치 이동 가능 | ✔️        |                                  |
| 별 버튼 클릭시 즐겨찾기 섹션 이동 기능  | ✔️       |                           |
| 연락처 실시간 저장 기능  | ✔️       | Codable을 이용하여 Json파일로 저장 |


#### ▶︎ UI/UX 개선
| 기능          | 진행       | 코멘트                             |
| -------------| --------- | -------------------------------- |
| 번호 입력시 자동으로 '-' 삽입 기능 | ✔️       |   생성, 수정 모두 적용            |
| 키보드 타이핑시 Contraint 조정   | ✔️        |   view가 가려지지 않도록 구성               |
| 이름이나 번호 입력 안했을 시 Save 불가능   | ✔️        |   필수 요건은 입력해야 된다는 알림창 띄움              |
| 이름, 번호 최대 11글자 까지 입력가능  | ✔️        |  그 이후에는 타이핑이 불가능             |


#### ▶︎ 실행화면
<img src="https://github.com/Youngminah/iosproject12/blob/master/gif%EC%A0%80%EC%9E%A5%EC%86%8C/PhoneBook.gif" title="phone book gif" width="30%"/>

#### ▶︎ 느낀점

처음에는 수정기능이 없었는데 , 다 만들고 알게 된 것이 CRUD가  앱에 있어서 사용자가 불편함 없이 쓰는데 중요한 개념이더라 그래서 공부를 해보면서 기능을 추가하게 되었다.

어려웠던 점은 헤더 섹션을 2가지로 나누어 즐겨찾기를 바로바로 업데이트 하는 부분이였다. 생각보다 어려웠다 ㅠ

처음에는 배열을 이용해서 기능 수행하는 단위들을 묶지 않게 구현을 하였는데, 수정을 거쳐 기능을 수행하는 단위들은 구조체로 묶어 구현하여 접근과 코드의 가독성을 높혔다. (이 부분을 깔끔히 구현하는 데는 오래걸렸고, 앞으로도 이렇게 하려면 숙련이 필요한 듯 싶다)

의외로 네이게이션 바를 디자인 하는게 어려웠다. 도저히 깔끔히 되지 않자 그냥 기본적인 디자인을 사용하여 구현하였는데, 디자인 연습도 많이 해보아야 할 듯 싶다.

<br></br>

-------------------------------------------------------
<br></br>

### 🐳  4. Under The Sea - Game 앱 (직접 구상)
[폴더바로가기](https://github.com/Youngminah/iosproject12/tree/master/MultiThreadGame)

**`MutitheradGame`: iOS Multithread GCD** 

→ `SpriteKit`을 사용하지 않고, 애니메이션과 `Multithread GCD`를 이용하여 구현한 게임 앱.

→ 어릴적 즐겨했던 쥬니버 네이버에 있는 게임을 모티브로 하여 이미지와 음악까지 직접 찾아(저작원이 없는 음악과 이미지를 가져옴) 구현.





#### ▶︎ 실행화면
<img src="https://github.com/Youngminah/iosproject12/blob/master/gif%EC%A0%80%EC%9E%A5%EC%86%8C/UnderTheSea.gif" alt="under the sea gif" title="Databay showcase gif" width="30%"/>

#### ▶︎ 느낀점

GCD를 가장 잘 활용해보고 써볼 수 있는 것이 게임이라고 생각하였으나, 아무리 찾아봐도 게임에선 GCD를 이용하지 않더라.

애플은 대부분의 모션 동작이 있는 게임을 `SpriteKit`를 활용하여 구현한다. 

엄청난 노가다 검색 끝에 알게된 사실이 있다.

` SpriteKit와 DispatchQueue를 같이 사용하는 것은 서버에서 데이터를 불러오는 일이 아닌 이상 최대한 피하라 ` 고 애플 개발자 포럼 홈페이지에 많은 이들이 답변 하였다. (이 사실을 몰라서 spritekit와 동시에 이용을 하려다가 많은 삽질을 하게 됨 ㅠㅠ)

spriteKit없이 GCD와 애니메이션만을 이용하여 간단한 게임을 만들어보고자 설계하게된 게임이다.
확실히 충돌효과를 감지할때, 캐릭터의 디테일한 부분까지 미세한 적용은 구현하기 까다로운 것 같다. (불가능은 아니다. 엄청난 노가다일뿐..)

충돌을 감지하는 것을 구현하는것 또한 노가다 일 줄 알았는데 `intersects`라는 아주~ 편리한 함수가 있어서 비교적 쉽게 구현하였다 ㅎㅅㅎ

멀티쓰레드를 활용해보고 개념을 확실히 깨닫고자 구현을 시작하게 되었는데, 꽤 괜찮게 구현된 것 같다 🐰

물론 다음에 iOS 게임을 구현하게 된다면 spriteKit를 무조건 적극 이용할 계획이다 😧


<br></br>



-------------------------------------------------------
<br></br>

### 💡  5. Daily Notice. - OpenAPI (직접 구상)
[폴더바로가기](https://github.com/Youngminah/iosproject12/tree/master/OpenAPI)

**`OpenAPI`: iOS Alamofire Rest API** 

→ Rest API를 각각 다른 3곳에서 받아와서 네트워크 통신의 기초를 연습하기 위한 앱.

→ 페이스북 연동 로그인 구현.

→ Alamofire 라이브러리를 이용하여 GET으로 데이터를 받아왔고, 파싱을 위하여 Codable을 이용하여 JSON 형식으로 Encoding, Decoding 해주었다.






#### ▶︎ 실행화면
<img src="https://github.com/Youngminah/iosproject12/blob/master/gif%EC%A0%80%EC%9E%A5%EC%86%8C/Daily%20Notice.gif" alt="under the sea gif" title="Databay showcase gif" width="30%"/>




#### ▶︎ 앱 설명

3곳에서 API를 가져와 Alamofire와 Codable을 연습하는 것에 초점을 맞춘 앱이다.

짜집기 인강으로 배운 `URLSession`으로 데이터를 받아올까 하였지만, 

`Alamofire`는 아주 잘 만들어진 라이브러리로 최근 회사에서는 Alamofire를 잘 다루는 사람을 우대하는 곳도 많다 하여 Alamofire로 구현하였다.

코로나 현재 실시간 상황, 현재 위치의 현재 날씨, 실시간 뉴스, 페이스북 연동 로그인을 구현하였다.

실시간 위치를 받아오기 위하여 `CLLocation`이용.

코로나 정보를 차트로 한눈에 보여주기 위하여 `Charts` 라이브러리 추가하여 이용.

<br></br>

#### ▶︎ 느낀점


Rest API를 연습해보기 위해서 `어떤 주제로 어떠한 기능이 있는 앱을 구현해 볼 것인가? 어떤 UI/UX 디자인으로 깔끔해보이게 만들것인가?` 를 정하는 것이 구현 못지않게 오래걸렸다. 
단순히 API만을 위한 앱이 아니라 어느정도 UI적으로도 깔끔한 디자인을 구현하려고 하였기 때문에, 아이디어만 짜는데 총 일주일의 기간중 2-3일은 걸렸다. 
기획의 중요성을 느꼈고, UI/UX 디자이너의 필요성을 체감하게 되었다. 

OpenAPI는 제대로 정리 되지 않은 곳도 있어서, 다시 고르게 된 것도 몇번이였다. 

데이터를 너무 많이 불러올 경우 UI에 올려주는데 로딩시간이 길어서, 페이징으로 나누어 사용해야 될 것 같다.  (보통은 서버에서 나뉨)

날씨 API는 우리나라에서 제공하던 유명한 곳들이 이제 유료로 전환을 해버려서 외국 사이트를 이용하였다. 

확실히 한글로 되어있지 않아서 위치정보를 `GeoCoder`로 변환을 해주어야 하였고, 시간 또한 Unix시간이라 변환해주어야 했다. 

UI에서 어려움을 느꼇던 점은 날씨 API에서 좀더 아이폰 기본 날씨앱과 비슷하게 만드려면 연습이 필요해보인다. (여러가지 슬라이딩이 많음)

지금까지 만든 앱들에서 계속 비슷 비슷한 view들(테이블뷰, 컬렉션뷰,스택뷰, 기본뷰)들만 이용하여서, 이번앱에선 좀더 다양한 뷰들을 이용해보려고 차트, 탭바 등등을 이용해보았다. 하지만 아직 한참 부족해보임. 

암튼, Alamofire로 데이터를 불러오거나 파싱하는것은 chrome extension에서 서버 연결할 때, axios로 해본적이 있어서 어렵지 않았다. 오히려 디자인이 넓은세계 같아 어렵게 느껴진다🥲🥲


<br></br>



-------------------------------------------------------
<br></br>



## :memo: Commit Convention

```
  - Init : 초기화
  - Add : 파일 추가
  - Rename : 파일 혹은 폴더명을 수정하거나 옮기는 작업만인 경우 
  - Remove : 파일을 삭제하는 작업만 수행한 경우
  - Feat : 기능 추가
  - Delete : 기능 삭제
  - Update : 기능 수정
  - Fix : 버그 수정
  - Refactor: 리팩토링
  - Style : 스타일 (코드 형식, 세미콜론 추가: 비즈니스 로직에 변경 없음)
  - Docs : 문서 (문서 추가(Add), 수정, 삭제)
  - Chore : 기타 변경사항 (빌드 스크립트 수정, 에셋 추가 등)
  - Design : 사용자 UI 디자인 변경 
  - !BREAKING CHANGE : 커다란 API 변경의 경우 !
  - HOTFIX : 급하게 치명적인 버그를 고쳐야하는 경우
  - Comment : 필요한 주석 추가 및 변경   
  - Test : 테스트 추가, 테스트 리팩토링(프로덕션 코드 변경 X) 
  - Chore : 빌드 태스트 업데이트, 패키지 매니저를 설정하는 경우(프로덕션 코드 변경 X) 

```

<br></br>
