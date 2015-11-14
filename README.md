#설명
참조) https://github.com/ydk0318/DKPostCodeXMLParser

참조의 Object-C코드를 Swift로 변경한 우체국 우편번호 Open API 파서 클래스입니다. 우체국 Open API 통해 우편번호를 얻어옵니다.


'구이름 혹은 동이름'과 '인증키'를 파라미로 넘기면 이를 euc-kr로 인코딩해서 API 호출하고,
우편번호 및 주소리스트를 받아와 파싱하여 배열에 담아 리턴합니다.


#사용법
1. 우체국 API 인증키 발급 및 이용방법 확인 : [링크](http://biz.epost.go.kr/openapi/openapi_request.jsp?subGubun=sub_3&subGubun_1=cum_38&gubun=m07)

1. 클래스 파일 임포트 (PostCodeXMLParser.swift)
2. 테스트 케이스 참고 (PostCodeTests.swift)

#인터페이스
```
1) 파라미터
 - strDong    : 구이름 혹은 동이름
 - strReg      : 우체국 Open API 이용 인증키
 
2) 리턴 값        : self.muArr

#Test code

```swift

func testExample() {
    let strDong: NSString = "덕계동"
    let strRegKey: NSString = "API Reg Key"

    let postcode = PostCodeXMLParser()

    let arrResult = postcode.getPostCode(strDong, strReg: strRegKey)

    for n in 0...arrResult.count-1 {
        let strPostcode: NSString = arrResult.objectAtIndex(n).objectForKey("postcode") as! NSString
        let strAddr: NSString = arrResult.objectAtIndex(n).objectForKey("address") as! NSString
        NSLog("%@ - %@", strPostcode, strAddr)
    }
}
```

