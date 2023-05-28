//
//  StringLiterals.swift
//  Core
//
//  Created by devxsby on 2023/05/22.
//  Copyright © 2023 BankApp. All rights reserved.
//

import Foundation

public struct I18N {
    
    public struct Alert {
        public static let network = "네트워크 오류가 발생하였습니다.\n잠시 후 다시 시도해주세요."
        public static let reload = "다시 시도"
    }
    
    public struct TabBar {
        public static let home = "홈"
        public static let service = "서비스"
        public static let moneyTransfer = "송금"
        public static let stock = "주식"
        public static let overall = "전체"
    }
    
    public struct MainFeature {
        public static let yagomBank = "야곰뱅크"
        public static let getPoint = "함께 어플 켜고 포인트 받기"
        public static let assets = "자산"
        public static let investments = "투자"
        public static let consumption = "소비"

        public static let transfer = "송금"
        public static let history = "내역"
        public static let screenSettings = "화면 설정"
        public static let addingAssets = "자산 추가"
        public static let viewPrivacyPolicy = "개인정보처리방침 보기"

    }
    
    public struct ServiceFeature {
        public static let service = "서비스"
        public static let searchBank = "가까운 은행을 검색하세요"
        public static let refresh = "새로고침"
        public static let showDetail = "상세보기"
        public static let loan = "대출"
        public static let deposit = "예금"
        public static let teller = "창구"
        public static let time = "시"
        public static let minute = "분"
        public static let peopleCount = "명"
        public static let showMyWaitlist = "나의 대기 현황 보기"
        
        public static let sampleBankName = "KB국민은행 용산종합금융센터"
        public static let sampleBankPlace = "서울 용산구 청파로 101 나진상가 10동 (한강로3가 1-3)"
        public static let sampleBankBusinessHours = "월 ~ 금 09:00 ~ 18:00 / 토, 일, 공휴일 휴무"
        
        public static let mobileNumbering = "모바일 번호표"
        public static let waitingCustomers = "대기 고객"
        public static let estimatedWaitTimes = "예상 대기 시간"
        public static let issuanceTime = "발행 시간"
        public static let waitingNotifications = "대기 알림"
        public static let dot = "·"
        public static let waitingNotification1 = "발급받은 대기번호 호출 시 창구 직원에게 모바일 번호 표를 보여 주십시오."
        public static let waitingNotification2 = "조회된 대기고객 수는 실제와 다소 차이가 날 수 있습니다."
        public static let waitingNotification3 = "대기 취소 후에는 이를 번복할 수 없습니다."
        
        public static let waiting = "대기하기"
        public static let cancelWaiting = "대기 취소하기"
        public static let successWaiting = "번호표 발급에 성공했어요"
        
        public struct Alert {
            public static let cancelPopup = "정말 대기를\n취소하시겠습니까?"
            public static let cancel = "취소하기"
            public static let no = "아니요"
            public static let confirm = "확인"
            public static let unableToWait = "대기 불가능"
            public static let unableToWaitDescription = "이미 예약중인 창구가 존재합니다."
            public static let noWaitingList = "대기 중인 내역이 없습니다."
        }
    }
}
