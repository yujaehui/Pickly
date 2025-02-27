# Pickly

![Image](https://github.com/user-attachments/assets/139799b7-ef7b-48fe-81ed-e33a6d26ea2c)

### 상품 검색부터 즐겨찾기까지, 쉽고 빠르게 쇼핑하세요!

> 다양한 상품을 한곳에서 검색하고, 구매 사이트로 쉽게 이동할 수 있는 편리한 쇼핑 탐색 앱입니다.
> 

---

## ⭐️ 주요 기능

**1. 다양한 상품 검색 & 최근 검색어 기능**

- 카테고리에 상관없이 원하는 상품을 쉽고 빠르게 검색
- 이전에 검색한 상품을 빠르게 다시 확인할 수 있도록 최근 검색어 저장

**2. 상품 상세 페이지 & 구매 사이트 연결**

- 검색한 상품을 선택하면 웹뷰를 통해 해당 구매 사이트로 바로 이동

**3. 정렬 기능**

- 검색 결과를 정확도순, 최신순, 가격 높은 순, 가격 낮은 순으로 정렬하여 보기 가능

**4. 즐겨찾기(하트) 기능**

- 관심 있는 상품을 하트를 눌러 저장하고 언제든지 다시 확인 가능

**5. 프로필 설정**

- 사용자가 직접 프로필을 설정하여 맞춤형 경험 제공

---

## 💻 개발 환경

- **개발 기간**: 2024.01.19 ~ 2024.01.21
- **앱 지원 iOS SDK**: iOS 16.0 이상
- **Xcode**: 15.0 이상
- **Swift 버전**: 5.8 이상

---

## 📋 설계 패턴

- **MVC**: 직관적인 구조와 개발 용이
- **싱글턴 패턴**: 전역적으로 관리가 필요한 객체를 재사용하기 위해 사용

---

## 🛠️ 기술 스택

### **기본 구성**

- **UIKit**: iOS 사용자 인터페이스 구현
- **Storyboard**: Auto Layout 설정

### **비동기 처리 및 데이터 관리**

- **Alamofire**: 네트워크 요청 및 응답 관리
- **Codable**: 네트워크 응답 데이터 디코딩 및 인코딩

### **UI 및 사용자 경험**

- **Kingfisher**: 네트워크 이미지를 간편하게 로드 및 캐싱

---

## 🗂️ 파일 디렉토리 구조

```
Pickly
 ┣ Assets.xcassets
 ┃ ┣ AccentColor.colorset
 ┃ ┃ ┗ Contents.json
 ┃ ┣ AppIcon.appiconset
 ┃ ┃ ┣ Contents.json
 ┃ ┃ ┗ Pickly Icon.png
 ┃ ┣ camera.imageset
 ┃ ┃ ┣ Contents.json
 ┃ ┃ ┣ camera.png
 ┃ ┃ ┣ camera@2x.png
 ┃ ┃ ┗ camera@3x.png
 ┃ ┣ empty.imageset
 ┃ ┃ ┣ Contents.json
 ┃ ┃ ┣ empty.png
 ┃ ┃ ┣ empty@2x.png
 ┃ ┃ ┗ empty@3x.png
 ┃ ┣ logo.imageset
 ┃ ┃ ┣ Contents.json
 ┃ ┃ ┣ Pickly.png
 ┃ ┃ ┣ Pickly@2x.png
 ┃ ┃ ┗ Pickly@3x.png
 ┃ ┣ onboarding.imageset
 ┃ ┃ ┣ Contents.json
 ┃ ┃ ┣ onboarding.png
 ┃ ┃ ┣ onboarding@2x.png
 ┃ ┃ ┗ onboarding@3x.png
 ┃ ┣ profile1.imageset
 ┃ ┃ ┣ Contents.json
 ┃ ┃ ┣ profile1.png
 ┃ ┃ ┣ profile1@2x.png
 ┃ ┃ ┗ profile1@3x.png
 ┃ ┣ profile10.imageset
 ┃ ┃ ┣ Contents.json
 ┃ ┃ ┣ profile10.png
 ┃ ┃ ┣ profile10@2x.png
 ┃ ┃ ┗ profile10@3x.png
 ┃ ┣ profile11.imageset
 ┃ ┃ ┣ Contents.json
 ┃ ┃ ┣ profile11.png
 ┃ ┃ ┣ profile11@2x.png
 ┃ ┃ ┗ profile11@3x.png
 ┃ ┣ profile12.imageset
 ┃ ┃ ┣ Contents.json
 ┃ ┃ ┣ profile12.png
 ┃ ┃ ┣ profile12@2x.png
 ┃ ┃ ┗ profile12@3x.png
 ┃ ┣ profile13.imageset
 ┃ ┃ ┣ Contents.json
 ┃ ┃ ┣ profile13.png
 ┃ ┃ ┣ profile13@2x.png
 ┃ ┃ ┗ profile13@3x.png
 ┃ ┣ profile14.imageset
 ┃ ┃ ┣ Contents.json
 ┃ ┃ ┣ profile14.png
 ┃ ┃ ┣ profile14@2x.png
 ┃ ┃ ┗ profile14@3x.png
 ┃ ┣ profile2.imageset
 ┃ ┃ ┣ Contents.json
 ┃ ┃ ┣ profile2.png
 ┃ ┃ ┣ profile2@2x.png
 ┃ ┃ ┗ profile2@3x.png
 ┃ ┣ profile3.imageset
 ┃ ┃ ┣ Contents.json
 ┃ ┃ ┣ profile3.png
 ┃ ┃ ┣ profile3@2x.png
 ┃ ┃ ┗ profile3@3x.png
 ┃ ┣ profile4.imageset
 ┃ ┃ ┣ Contents.json
 ┃ ┃ ┣ profile4.png
 ┃ ┃ ┣ profile4@2x.png
 ┃ ┃ ┗ profile4@3x.png
 ┃ ┣ profile5.imageset
 ┃ ┃ ┣ Contents.json
 ┃ ┃ ┣ profile5.png
 ┃ ┃ ┣ profile5@2x.png
 ┃ ┃ ┗ profile5@3x.png
 ┃ ┣ profile6.imageset
 ┃ ┃ ┣ Contents.json
 ┃ ┃ ┣ profile6.png
 ┃ ┃ ┣ profile6@2x.png
 ┃ ┃ ┗ profile6@3x.png
 ┃ ┣ profile7.imageset
 ┃ ┃ ┣ Contents.json
 ┃ ┃ ┣ profile7.png
 ┃ ┃ ┣ profile7@2x.png
 ┃ ┃ ┗ profile7@3x.png
 ┃ ┣ profile8.imageset
 ┃ ┃ ┣ Contents.json
 ┃ ┃ ┣ profile8.png
 ┃ ┃ ┣ profile8@2x.png
 ┃ ┃ ┗ profile8@3x.png
 ┃ ┣ profile9.imageset
 ┃ ┃ ┣ Contents.json
 ┃ ┃ ┣ profile9.png
 ┃ ┃ ┣ profile9@2x.png
 ┃ ┃ ┗ profile9@3x.png
 ┃ ┗ Contents.json
 ┣ Base
 ┃ ┣ BaseCollectionViewCell.swift
 ┃ ┣ BaseTableViewCell.swift
 ┃ ┗ BaseViewController.swift
 ┣ Base.lproj
 ┃ ┣ LaunchScreen.storyboard
 ┃ ┗ Main.storyboard
 ┣ Custom
 ┃ ┗ PaddingLabel.swift
 ┣ DesignSystem
 ┃ ┣ ColorStyle.swift
 ┃ ┗ FontStyle.swift
 ┣ Extension
 ┃ ┣ UIApplication+Extension.swift
 ┃ ┣ UIButton+Extension.swift
 ┃ ┣ UIColor+Extension.swift
 ┃ ┣ UIImageView+Extension.swift
 ┃ ┣ UIScrollView+Extension.swift
 ┃ ┣ UITextField+Extension.swift
 ┃ ┣ UIView+Extension.swift
 ┃ ┗ UIViewController+Extension.swift
 ┣ Manager
 ┃ ┣ NumberFormatterManager.swift
 ┃ ┣ TextProcessingManager.swift
 ┃ ┗ UserDefaultsManager.swift
 ┣ Network
 ┃ ┣ Model
 ┃ ┃ ┗ Shopping.swift
 ┃ ┣ APIKey.swift
 ┃ ┣ SearchSessionManager.swift
 ┃ ┗ ShoppingAPI.swift
 ┣ Onboarding
 ┃ ┣ Onboarding.storyboard
 ┃ ┗ OnboardingViewController.swift
 ┣ Profile
 ┃ ┣ Cell
 ┃ ┃ ┣ ProfileImageCollectionViewCell.swift
 ┃ ┃ ┗ ProfileImageCollectionViewCell.xib
 ┃ ┣ Profile.storyboard
 ┃ ┣ ProfileImageViewController.swift
 ┃ ┗ ProfileViewController.swift
 ┣ Search
 ┃ ┣ Cell
 ┃ ┃ ┣ RecentSearchTableViewCell.swift
 ┃ ┃ ┣ RecentSearchTableViewCell.xib
 ┃ ┃ ┣ SearchResultCollectionViewCell.swift
 ┃ ┃ ┣ SearchResultCollectionViewCell.xib
 ┃ ┃ ┣ SortCollectionViewCell.swift
 ┃ ┃ ┗ SortCollectionViewCell.xib
 ┃ ┣ Search.storyboard
 ┃ ┣ SearchDetailViewController.swift
 ┃ ┣ SearchResultViewController.swift
 ┃ ┗ SearchViewController.swift
 ┣ Setting
 ┃ ┣ Cell
 ┃ ┃ ┣ ProfileTableViewCell.swift
 ┃ ┃ ┣ ProfileTableViewCell.xib
 ┃ ┃ ┣ SettingTableViewCell.swift
 ┃ ┃ ┗ SettingTableViewCell.xib
 ┃ ┣ Setting.storyboard
 ┃ ┗ SettingViewController.swift
 ┣ AppDelegate.swift
 ┣ Info.plist
 ┣ SceneDelegate.swift
 ┗ ViewController.swift
```

