//
//  PostCodeXMLParser.swift
//  commerce
//
//  Created by jigwan on 2015. 11. 14..
//  Copyright © 2015년 STRUCEL. All rights reserved.
//

import Foundation
import UIKit

/**
 우체국 Open API 통해 우편번호 얻어온다.
 구이름/동이름(strDong)과 인증키(strReg)을 넘기면 euc-kr(0x80000940)로 인코딩해서 우편번호와 주소리스트 받아와 파싱한 후 어레이에 담아 리턴한다.
 
 1) 파라미터
 strDong    : 구이름 혹은 동이름
 strReg      : 우체국 Open API 이용 인증키
 
 2) 리턴 값        : self.muArr
 
 dic: NSDictionary = ["postcode":self.strPostcode, "address":self.strAddr]
 
 [self.muArr addObject:dict];
 
 
 Ref) 인증키 발급 및 이용방법 URL : http://biz.epost.go.kr/openapi/openapi_request.jsp?subGubun=sub_3&subGubun_1=cum_38&gubun=m07
 */

public class PostCodeXMLParser: NSObject, NSXMLParserDelegate {
    var muArr = NSMutableArray()
    var strAddr: String!
    var strPostcode: String!
    var strVal: String!
     
    func getPostCode (strDong: NSString, strReg: NSString) -> NSMutableArray{
        let strURL = "http://biz.epost.go.kr/KpostPortal/openapi"
        
        let responseString:NSString = strDong.stringByAddingPercentEscapesUsingEncoding(0x80000940)!
        
        print(responseString)
        let strQuery = strURL.stringByAppendingString("?regkey="+(strReg as String)+"&target=post&query="+((responseString) as String))
        
        print(strQuery)
        let url = NSURL(string: strQuery)
        print(url)
        let xmlParser = NSXMLParser(contentsOfURL: url!)!
        xmlParser.delegate = self
        xmlParser.parse()
        
        return muArr
    }
    
    public func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if(elementName.isEqual("address") || elementName.isEqual("postcd")) {
            NSLog("didStartElemet elementName: %@", elementName)
        }
    }
    
    public func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        NSLog("didEndElemet elementName: %@", elementName)
        if(elementName.isEqual("address")) {
            self.strAddr = self.strVal
        }
        
        if(elementName.isEqual("postcd")) {
            self.strPostcode = self.strVal
        }
        
        if(elementName.isEqual("item")) {
            let dic: NSDictionary = ["postcode":self.strPostcode, "address":self.strAddr]
            self.muArr.addObject(dic)
        }
    }
    
    public func parser(parser: NSXMLParser, foundCharacters string: String) {
        self.strVal = string
        NSLog("string : %@", string)
    }
}
