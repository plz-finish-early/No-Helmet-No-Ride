# 🛴 킥보드 대여 앱 - 명.노.운 (명심 노(No)헬멧은 운전금지)
<div align="center">
<img src = "https://github.com/user-attachments/assets/0afa0958-47c8-41a1-aa1a-1e30ca21c845" width=300>
</div>

## 📋 프로젝트 개요
### `명.노.운`은 킥보드 대여 앱 입니다.
>**명.노.운**<br>
→ 명심!<br>
→ 노(No)헬멧은<br>
→ 운전금지
- 프로젝트 명 : 명.노.운
- 프로젝트 기간 : 2025.04.25 ~ 2025.05.02
- 팀 명 : 1찍 끝내시조

---

## 🫂 1찍 끝내시조 팀 소개
> **1팀인 만큼 1찍 끝내는 에이스가 되자!** 라는 포부가 담긴 의미로<br>
> 선두 주자가 되자는 의미를 담아 <ins>**1찍 끝내시조**</ins> 이라는 팀명을 사용하게 되었습니다.

|이름|👑 전원식|명노훈|이정진|이찬호|
|---|---|---|---|---|
|<div align="center">직책</div>|<div align="center">👑 Leader</div>|<div align="center">👤 Member</div>|<div align="center">👤 Member</div>|<div align="center">👤 Member</div>|
|<div align="center">역할</div>|- 마이페이지 View 개발<br>- CoreDataManager 개발<br>- 마이페이지 View 데이터 적용|- 로그인/회원가입 View 개발<br>- 로그인/회원가입 기능 개발<br>- 로그인/회원가입/마이페이지 View 연경<br>- 발표|- 네이버 지도 SDK를 이용헌 메인 지도 개발<br>- 세그먼티드 컨트롤 개발<br>- 지도 관련 View 화면 연결|- 네트워크 기능 개발<br>- 네이버 지도 API 이용해 주소 데이터 가져오는 기능 개발<br> - 주소 검색 기능 개발|
|<div align="center">Github</div>| <div align="center">[lemonisgreen](https://github.com/lemonisgreen)</div> | <div align="center"> [ghnn-n](https://github.com/ghnn-n)</div> | <div align="center">[mnh4140](https://github.com/mnh4140)</div>|<div align="center">[LCH-1228](https://github.com/LCH-1228)</div>|

---

## 🛠️ 기술 스택
- Language : Swift
- IDE : Xcode
- 버전 : iOS 16
- 라이브러리 : SnapKit, Alamofire
- UI 구현 : UIKit
- UI 디자인 : Figma
- 디자인 패턴 : Delegate 패턴
- 형상 관리 : Github
- 스크럼 및 마일스톤 : Notion
- 커뮤니케이션 : ZEP

## 🎨 와이어 프레임
![image](https://github.com/user-attachments/assets/e6a8560d-c0e5-4841-8274-548860ff95e2)


---

## 📱 주요 기능
### 1. 로그인 / 회원가입
- 가입한 ID/PassWD 로 로그인 가능
- 회원가입을 통한 계정 등록
### 2. 킥보드 이용하기
- 지도에 표시된 킥보드를 대여 가능
- 대여한 킥보드 반납 기능
- 이용 내역 확인 기능
### 3. 킥보드 등록 기능
- 지도에 특정 위치에 대여할 수 있는 킥보드 등록 기능 
- 킥보드 ID 와 킥보드 확인 사항을 저장 가능
### 4. 마이 페이지 기능
- 마이페이지 화면에서 3가지 기능 제공
  - 이용 내역 화면에서 지금까지 내가 이용한 내역 확인 가능
  - 이용 현황 화면에서 현재 이용중인 킥보드의 이용 시간 및 거리, 요금을 확인 가능
  - 등록한 킥보드 화면에서 내가 등록한 킥보드 목록 확인 가능
---

## 📋 커밋 컨벤션 (PR 시 동일하게 적용)
- Commit Message 규칙
  - 💡 [Issue 종류] #Issue 번호 - 한 줄 정리
    - 예시) [Feat] #22 - 탭바 추가

---

## 📌 브렌치 룰 & 전략
- 브랜치 전략
    - github flow를 따르되, main과 개인 작업 브랜치 사이에 Develop를 만들어서 좀 더 안전하게 공동작업을 보호.
        - main: Develop 브랜치에서 하나의 Issue에 생성된 브랜치가 안전하게 머지 되었을 때 푸시
        - Develop: 새로운 Issue가 완료되었을 때 푸시 앤 머지
        - Issue 할당 브랜치: 개인 작업용
        
- 브랜치 룰
    - **`Block force pushes` : Force push 방지**
    - **`require approval of the most recent reviewable push` : 푸시한 사람 외의 누군가의 승인을 받게 강제합니다.**
        - main과 Dev 브랜치에 적용해 모든 팀원의 Approve가 있어야 merge 가능하게 만들고,  Force push를 금지해 Main과 Dev 브랜치를 보호합니다.
        
- 브랜치 네이밍
    - 이슈 종류/#이슈 번호
 
---

## 📦 설치 및 실행 방법
- 이 저장소를 클론
  ```bash
  https://github.com/plz-finish-early/No-Helmet-No-Ride.git
  ```
- Xcode로 프로젝트 파일을 실행 후 빌드!
