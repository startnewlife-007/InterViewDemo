//
//  InterviewDemoTests.swift
//  InterviewDemoTests
//
//  Created by MacBook Pro on 2021/3/1.
//

import XCTest
@testable import InterviewDemo

class InterviewDemoTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    /// MARK : - 接口数据测试、超时测试
    func testAsynNetWork() {
        let networkExpection = expectation(description: "networkDownSuccess")
        NetWorkHelper.shared.GET(url: "https://api.github.com") { (data, error) in
            XCTAssertNotNil(data, "接口数据异常")
            networkExpection.fulfill()
        }
        let result = XCTWaiter(delegate: self).wait(for: [networkExpection], timeout:  10)
        XCTAssertTrue(result != .timedOut, "接口请求超时")
    }
    
    // MARK : - 数据存储测试
    func testUserDefaultsData()   {
        var vm = HomeViewModel()
        let data = ["url1":"value1","url2":"value2"]
        vm.cacheRequestData(data: data as AnyObject, key: "key1")
        let result = vm.queryRequestData(key: "key1") as! [String : String]
        
        var ret = (NSDictionary(dictionary: data)).isEqual(to: (NSDictionary(dictionary: result) as! [AnyHashable : Any]))
        XCTAssertTrue(ret, "something wrong in cache data")
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
