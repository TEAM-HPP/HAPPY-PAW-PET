<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="/css/footer.css" />
    <title>footer</title>
    <script>
        function open_privacy_pop(){
            var open_modal = document.querySelector(".privacy_modal");
            open_modal.style.display = "flex";
        }
        function close_privacy_button(){
            var close_modal = document.querySelector(".privacy_modal");
            close_modal.style.display = "none";
        }
        function open_terms_pop(){
            var open_modal = document.querySelector(".terms_modal");
            open_modal.style.display = "flex";
        }
        function close_terms_button(){
            var close_modal = document.querySelector(".terms_modal");
            close_modal.style.display = "none";
        }
    </script>
    <footer>
        <div class="footer">
            <div id="logo">
                <img src="/image/footerLogo.png" alt="HappyPawPet Logo">
            </div>
            <div id="text">
                <div id="main_text">
                    <div id="intro"><a>HappyPawPet 소개</a></div>
                    <div id="privacy-policy"><a onclick="open_privacy_pop()">개인정보처리방침</a></div>
                    <!-- modal 개인정보처리방침 시작 -->
                    <div class="privacy_modal">
                        <div id="privacy-pop">
                            <div id="h2"><h2>개인정보처리방침</h2></div>
                            <textarea readonly style="width: 400px;">1. 수집하는 개인정보의 항목 및 수집 방법

(1)수집하는 개인정보 항목
- 성명 , 아이디, 비밀번호
- 이메일주소, 전화번호
- 생년월일, 성별
- (견) 이름, 무게, 생년월일, 성별, 중성화유무
- IP Address

(2)수집 방법
(주)HappyPawPet은 이용자가 자발적으로, 구체적으로 기입할 때 개인정보를 수집하고 있습니다.


2. 개인정보 수집 및 이용목적
- 회원제 서비스 이용에 따른 본인 확인 절차에 이용
- 개인맞춤 서비스를 제공하기 위한 자료
- 불량회원의 부정 이용 방지와 비인가 사용 방지


3. 개인정보의 보유 및 이용기간
- 계약 또는 청약철회 등에 관한 기록 : 5년
- 소비자의 불만 또는 분쟁처리에 관한 기록 : 3년
- 회원가입 탈퇴하거나 회원에서 제명된 경우 등에는 3개월 동안 재가입 방지를 위하여 식별정보를 보관합니다.</textarea>
                            <div id="privacy_button">
                                <button id="privacy_mbtn" onclick="close_privacy_button()">닫기</button>
                            </div>
                        </div>
                    </div>
                    <!-- modal 개인정보처리방침 끝 -->
                    <div id="terms"><a onclick="open_terms_pop()">이용약관</a></div>
                    <!-- modal 이용약관 시작 -->
                    <div class="terms_modal">
                        <div id="terms_pop">
                            <div id="h2"><h2>이용약관</h2></div>
                            <textarea readonly style="width: 400px;">제1조(목적 등)
① HappyPawPet 인터넷 회원 약관(이하 "본 약관"이라 합니다)은 이용자가 HappyPawPet에서 제공하는 인터넷 관련 서비스(이하 "서비스"라 합니다)를 이용함에 있어 이용자와 HappyPawPet에 권리·의무 및 책임사항을 규정함을 목적으로 합니다
② 이용자가 되고자 하는 자가 HappyPawPet가 정한 소정의 절차를 거쳐서 "회원가입" 단추를 누르면 본 약관에 동의하는 것으로 간주합니다. 본 약관에 정하는 이외의 이용자와 HappyPawPet에 권리, 의무 및 책임사항에 관해서는 전기통신사업법 기타 대한민국의 관련 법령과 상관습에 의합니다.

제2조(이용자 정의)
"이용자"란 HappyPawPet 홈페이지에 접속하여 본 약관에 따라 HappyPawPet 인터넷 회원으로 가입하여 HappyPawPet 인터넷 회원 서비스를 받는 자를 말합니다.

제3조(회원가입)
① 이용자가 되고자 하는 자는 HappyPawPet가 정한 가입 양식에 따라 회원정보를 기입하고 "회원가입" 단추를 누르는 방법으로 회원 가입을 신청합니다.
② HappyPawPet는 제1항과 같이 회원으로 가입할 것을 신청한 자가 다음 각 호에 해당하는 경우 회원등록을 거부할 수 있고 기입한 데이터를 삭제할 수 있습니다.
1. 가입신청자가 본 약관 제6조 제3항에 의하여 이전에 회원자격을 상실한 적이 있는 경우. 다만 제6조 제3항에 의한 회원자격 상실 후 3년이 경과한 자로서 HappyPawPet에 회원재가입 승낙을 얻은 경우에는 예외로 합니다.
2. 등록 내용에 허위, 기재누락, 오기가 있는 경우
3. 기타 회원으로 등록하는 것이 HappyPawPet에 기술상 현저히 지장이 있다고 판단되는 경우
③ 회원가입계약의 성립시기는 HappyPawPet에 승낙이 가입신청자에게 도달한 시점으로 합니다.
④ 회원은 제1항의 회원정보 기재 내용에 변경이 발생한 경우, 즉시 변경사항을 정정하여 기재하여야 합니다.

제4조(서비스의 제공 및 변경)
① HappyPawPet 인터넷 회원 서비스는 이용자에게 아래와 같은 서비스를 제공합니다.
1. AI 안구 진단 서비스
2. AI 피부 진단 서비스
3. 진단에 따른 사료, 영양제, 샴푸 추천 서비스
4. 유기견 입양 정보
5. 응급처치 정보
6. 기타 HappyPawPet가 회원들에게 제공할 일체의 서비스
② HappyPawPet는 그 변경될 서비스의 내용 및 제공일자를 제7조 제2항에서 정한 방법으로 이용자에게 통지하고, 제1항에 정한 서비스를 변경하여 제공할 수 있습니다.

제5조(서비스의 중단)
① HappyPawPet는 컴퓨터 등 정보통신설비의 보수점검·교체 및 고장, 통신의 두절 등의 사유가 발생한 경우에는 서비스의 제공을 일시적으로 중단할 수 있고, 새로운 서비스로의 교체 기타 HappyPawPet가 적절하다고 판단하는 사유에 기하여 현재 제공되는 서비스를 완전히 중단할 수 있습니다.
② 제1항에 의한 서비스 중단의 경우에는 HappyPawPet는 제7조 제2항에서 정한 방법으로 이용자에게 통지합니다. 다만, HappyPawPet가 통제할 수 없는 사유로 인한 서비스의 중단(시스템 관리자의 고의, 과실이 없는 디스크 장애, 시스템 다운 등)으로 인하여 사전 통지가 불가능한 경우에는 그러하지 아니합니다.

제6조(이용자 탈퇴 및 자격 상실 등)
① 이용자는 HappyPawPet에 언제든지 자신의 회원 등록을 말소해 줄 것(이용자 탈퇴)을 요청할 수 있으며 HappyPawPet는 위 요청을 받은 즉시 해당 이용자의 회원 등록 말소를 위한 절차를 밟습니다.
② 이용자가 다음 각 호의 사유에 해당하는 경우, HappyPawPet는 이용자의 회원자격을 적절한 방법으로 제한 및 정지, 상실시킬 수 있습니다.
1. 가입 신청 시에 허위 내용을 등록한 경우
2. 다른 사람의 서비스 이용을 방해하거나 그 정보를 도용하는 등 전자거래질서를 위협하는 경우
3. 서비스를 이용하여 법령과 본 약관이 금지하거나 공서양속에 반하는 행위를 하는 경우
③ HappyPawPet가 이용자의 회원자격을 상실시키기로 결정한 경우에는 회원등록을 말소합니다. 이 경우 이용자인 회원에게 회원등록 말소 전에 이를 통지하고, 소명할 기회를 부여합니다.

제7조(이용자에 대한 통지)
① HappyPawPet가 특정 이용자에 대한 통지를 하는 경우 회원가입 시 기입한 메일주소로 할 수 있습니다.
② HappyPawPet가 불특정다수 이용자에 대한 통지를 하는 경우 1주일이상 HappyPawPet 게시판에 게시함으로써 개별 통지에 갈음할 수 있습니다.

제8조(이용자의 개인정보보호)
HappyPawPet는 관련법령이 정하는 바에 따라서 이용자 등록정보를 포함한 이용자의 개인정보를 보호하기 위하여 노력합니다. 이용자의 개인정보보호에 관해서는 관련법령 및 HappyPawPet가 정하는 "개인정보보호정책"에 정한 바에 의합니다.

제9조(이용자의 ID 및 비밀번호에 대한 의무)
① HappyPawPet가 관계법령, "개인정보보호정책"에 의해서 그 책임을 지는 경우를 제외하고, 자신의 ID와 비밀번호에 관한 관리책임은 각 이용자에게 있습니다.
② 이용자는 자신의 ID 및 비밀번호를 제3자에게 이용하게 해서는 안됩니다.
③ 이용자는 자신의 ID 및 비밀번호를 도난당하거나 제3자가 사용하고 있음을 인지한 경우에는 바로 HappyPawPet에 통보하고 HappyPawPet에 안내가 있는 경우에는 그에 따라야 합니다.

제10조(이용자의 의무)
① 이용자는 다음 각 호의 행위를 하여서는 안됩니다. 1. 회원가입신청 또는 변경시 허위내용을 등록하는 행위
2. 서비스에 게시된 정보를 변경하는 행위
3. HappyPawPet 기타 제3자의 인격권 또는 지적재산권을 침해하거나 업무를 방해하는 행위
4. 다른 회원의 ID를 도용하는 행위
5. HappyPawPet의 승인 없이 자료의 무단 복제, 배부 임의 변경하거나 가공 또는 판매하거나 기타 영리를 목적으로 사용하는 행위
6. 관련 법령에 의하여 그 전송 또는 게시가 금지되는 정보의 전송 또는 게시하는 행위
7. 컴퓨터 소프트웨어, 하드웨어, 전기통신 장비의 정상적인 가동을 방해, 파괴할 목적으로 고안된 소프트웨어 바이러스, 기 타 다른 컴퓨터 코드, 파일, 프로그램을 포함하고 있는 자료를 게시하거나 전자우편으로 발송하는 행위
8. 다른 이용자에 대한 개인정보를 그 동의 없이 수집, 저장, 공개하는 행위
9. HappyPawPet가 제공하는 서비스에 정한 약관 기타 서비스 이용에 관한 규정을 위반하는 행위
② 제1항에 해당하는 행위를 한 이용자가 있을 경우 HappyPawPet는 본 약관 제6조 제2, 3항에서 정한 바에 따라 이용자의 회원자격을 적절한 방법으로 제한 및 정지, 상실시킬 수 있습니다.
③ 이용자는 그 귀책사유로 인하여 HappyPawPet는 다른 이용자가 입은 손해를 배상할 책임이 있습니다.

제11조(저작권의 귀속 및 이용제한)
① HappyPawPet가 작성한 저작물에 대한 저작권 기타 지적재산권은 HappyPawPet에 귀속합니다.
② 이용자는 서비스를 이용함으로써 얻은 정보를 HappyPawPet의 사전승낙 없이 자료의 무단 복제, 배부 임의 변경하거나 가공 또는 판매하거나 기타 영리를 목적으로 사용하여서는 안됩니다.

제12조 (약관의 개정)
① HappyPawPet는 약관의 규제 등에 관한법률, 전자거래기본법, 전자서명법, 정보통신망이용촉진등에관한법률 등 관련법을 위배하지 않는 범위에서 본 약관을 개정할 수 있습니다.
② HappyPawPet가 본 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 초기화면에 그 적용일자 7일 이전부터 적용일자 전일까지 공지합니다.
③ HappyPawPet가 본 약관을 개정할 경우에는 그 개정약관은 개정된 내용이 관계 법령에 위배되지 않는 한 개정 이전에 회원으로 가입한 이용자에게도 적용됩니다.
④ 변경된 약관에 이의가 있는 이용자는 제6조 제1항에 따라 탈퇴할 수 있습니다.</textarea>
                            <div id="terms_button">
                                <button id="terms_mbtn" onclick="close_terms_button()">닫기</button>
                            </div>
                        </div>
                    </div>
                    <!-- modal 이용약관 끝 -->

                    <div id="notice"><a href="/board/list">공지사항</a></div>
                </div>
                <div id="sub_text">
                    <div id="company-info">상호 : HappyPawPet | 대표자 : *** | 개인정보취급담당자 : ***</div>
                    <div id="business-license">사업자등록번호 : ***-**-*****</div>
                    <div id="address">(08378) 서울 구로구 디지털로34길 27 (구로동) 1106-7호</div>
                </div>
            </div>
        </div>
    </footer>