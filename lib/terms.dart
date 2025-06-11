import 'package:flutter/material.dart';

// 이용약관 페이지
class TermsOfServicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('이용약관')),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, MediaQuery.of(context).padding.bottom + 16.0,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '본 약관은 SAM(이하 "회사")이 제공하는 서비스(이하 "서비스")의 이용과 관련하여 회사와 회원 간의 권리, 의무, 책임사항 등을 규정함을 목적으로 합니다.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            Text(
              '제1조 (목적)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              '이 약관은 회사가 제공하는 서비스의 이용조건, 절차, 권리, 의무 및 책임사항 등을 규정하는 것을 목적으로 합니다.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
            Text(
              '제2조 (정의)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              '"회원"이란 본 약관에 따라 회사와 서비스 이용계약을 체결하고, 회사가 제공하는 서비스를 이용하는 자를 말합니다.\n'
                  '"서비스"란 SAM 애플리케이션 및 관련 부가서비스를 의미합니다.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
            Text(
              '제3조 (약관의 게시와 변경)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              '회사는 본 약관을 서비스 초기화면 또는 기타 방법으로 게시합니다.\n'
                  '회사는 필요한 경우 관련 법령을 위반하지 않는 범위 내에서 약관을 변경할 수 있으며, 변경 시 공지합니다.\n'
                  '변경된 약관은 공지한 날로부터 효력이 발생합니다.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
            Text(
              '제4조 (회원 가입)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              '이용자는 회사가 정한 절차에 따라 회원가입을 신청하고, 회사가 이를 승인함으로써 회원가입이 완료됩니다.\n'
                  '회사는 가입 신청자에게 필요한 정보를 요청할 수 있습니다.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
            Text(
              '제5조 (회원의 의무)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              '회원은 본 약관 및 관련 법령을 준수해야 합니다.\n'
                  '회원은 타인의 정보를 도용하거나 부정한 목적으로 서비스를 이용할 수 없습니다.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
            Text(
              '제6조 (서비스의 제공 및 변경)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              '회사는 회원에게 다양한 콘텐츠 및 기능을 제공합니다.\n'
                  '회사는 서비스의 일부 또는 전부를 사전 공지 후 변경하거나 종료할 수 있습니다.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
            Text(
              '제7조 (서비스의 중단)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              '회사는 시스템 점검, 유지보수, 기술적 문제 발생 등의 경우 서비스 제공을 일시 중단할 수 있습니다.\n'
                  '이 경우 회사는 사전에 공지하며, 부득이한 경우 사후에 통지할 수 있습니다.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
            Text(
              '제8조 (개인정보 보호)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              '회사는 개인정보 보호법 등 관련 법령을 준수하며, 개인정보처리방침에 따라 회원의 개인정보를 보호합니다.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
            Text(
              '제9조 (계약 해지 및 이용 제한)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              '회원은 언제든지 서비스 탈퇴를 요청할 수 있으며, 회사는 지체 없이 처리합니다.\n'
                  '회원이 약관을 위반하거나 부정한 이용을 한 경우, 회사는 서비스 이용을 제한하거나 계약을 해지할 수 있습니다.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
            Text(
              '제10조 (면책 조항)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              '회사는 천재지변, 불가항력적 사유 등으로 서비스를 제공할 수 없는 경우 책임을 지지 않습니다.\n'
                  '회사는 회원의 귀책사유로 인한 서비스 이용 장애에 대해 책임을 지지 않습니다.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
            Text(
              '제11조 (분쟁 해결)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              '회사와 회원 간에 발생한 분쟁은 원만하게 해결하기 위해 노력합니다.\n'
                  '분쟁이 해결되지 않을 경우, 관할 법원은 회사의 본사 소재지를 관할하는 법원으로 합니다.',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

// 개인정보처리방침 페이지
class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('개인정보처리방침')),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, MediaQuery.of(context).padding.bottom + 16.0,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SAM(이하 "회사"라 함)은 개인정보 보호법 등 관련 법령을 준수하며, 이용자의 개인정보를 중요시하고 있습니다. '
                  '회사는 개인정보처리방침을 통해 어떤 정보를 수집하고, 어떤 목적으로 이용하며, 개인정보 보호를 위해 어떤 조치를 취하고 있는지 알려드립니다.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            Text(
              '1. 수집하는 개인정보 항목',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              '회사는 회원가입, 서비스 이용, 고객문의 등을 위해 아래와 같은 개인정보를 수집할 수 있습니다.\n\n'
                  '필수항목: 이름, 이메일, 전화번호, 비밀번호\n'
                  '선택항목: 프로필 사진, 위치 정보\n'
                  '서비스 이용 기록, 접속 로그, 쿠키, 기기정보',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
            Text(
              '2. 개인정보 수집 방법',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              '회원가입 및 서비스 이용 과정에서 이용자가 직접 입력\n'
                  '고객센터 문의 과정에서 수집\n'
                  '자동 생성 정보(기기 정보, IP 등)',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
            Text(
              '3. 개인정보 이용 목적',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              '회사는 수집한 개인정보를 다음 목적을 위해 사용합니다.\n\n'
                  '회원 관리 (회원 식별, 본인 확인)\n'
                  '서비스 제공 및 개선\n'
                  '공지사항 전달 및 고객지원\n'
                  '이용자 맞춤형 서비스 제공\n'
                  '법적 의무 이행',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
            Text(
              '4. 개인정보 보유 및 이용 기간',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              '회원 탈퇴 시까지\n'
                  '관련 법령에 따라 일정 기간 보관이 필요한 경우 해당 기간 동안 보관',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
            Text(
              '5. 개인정보의 제3자 제공',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              '회사는 이용자의 동의 없이 개인정보를 제3자에게 제공하지 않습니다. 다만, 법령에 따라 요구되는 경우에는 예외로 합니다.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
            Text(
              '6. 개인정보의 파기',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              '개인정보 보유기간이 경과하거나 처리 목적이 달성된 경우, 지체 없이 파기합니다.\n\n'
                  '전자적 파일 형태: 복구 불가능한 방법으로 삭제\n'
                  '종이 문서 형태: 분쇄하거나 소각하여 파기',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
            Text(
              '7. 이용자의 권리와 행사 방법',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              '이용자는 언제든지 개인정보 조회, 수정, 삭제를 요청할 수 있습니다.\n'
                  '개인정보 관련 문의는 고객센터를 통해 접수 가능합니다.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
            Text(
              '8. 개인정보 보호를 위한 조치',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              '회사는 개인정보의 안전성을 확보하기 위해 다음과 같은 조치를 취하고 있습니다.\n\n'
                  '관리적 조치: 내부 관리계획 수립 및 시행, 정기적 직원 교육\n'
                  '기술적 조치: 개인정보 암호화, 접근 통제\n'
                  '물리적 조치: 서버 및 데이터 접근 제한',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
            Text(
              '9. 고지 의무',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              '이 개인정보처리방침은 시행일로부터 적용되며, 내용이 변경되는 경우 웹사이트나 앱을 통해 공지합니다.',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}