//
//  StringLiterals.swift
//  Core
//
//  Created by devxsby on 2023/05/22.
//  Copyright © 2023 BankApp. All rights reserved.
//

import Foundation

public struct I18N {
    
    public struct TabBar {
        public static let home = "홈"
        public static let service = "서비스"
        public static let moneyTransfer = "송금"
        public static let stock = "주식"
        public static let overall = "전체"
    }
    
    public struct ServiceFeature {
        public static let service = "서비스"
        public static let searchBank = "가까운 은행을 검색하세요"
        public static let refresh = "새로고침"
        public static let showDetail = "상세보기"
        public static let loans = "대출"
        public static let deposits = "예금"
        public static let teller = "창구"
        public static let time = "시"
        public static let minute = "분"
        public static let peopleCount = "명"
        public static let showMyWaitlist = "나의 대기 현황 보기"
        
        public static let sampleBankName = "공덕금융센터점"
        public static let sampleBankPlace = "서울 마포구 백범로 192,(S-OIL본사 사옥2층)"
        public static let sampleBankBusinessHours = "월~금 09:00 ~ 16:00 / 토, 일 정기휴무"
        
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
        public static let successWaiting = "번호표 발행 완료"
        public static let cancelPopup = "정말 대기를\n취소하시겠습니까?"
        public static let cancel = "취소하기"
        public static let no = "아니요"
    }
}
