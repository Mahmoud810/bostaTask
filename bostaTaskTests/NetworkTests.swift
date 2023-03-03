//
//  NetworkTests.swift
//  bostaTaskTests
//
//  Created by Mahmoud on 04/03/2023.
//

import XCTest
@testable import bostaTask
final class NetworkTests: XCTestCase {
    //MARK: test Generic method twice
    var endPoint : EndPoint?
    override func setUp() {
        
    }
    override func tearDown() {
        endPoint = nil
    }

    func testExample() throws {
        
    }

    func testFetchUsers(){
        endPoint = EndPoint.users
        let url = endPoint?.makeUrl(baseUrl: NetworkServiece.baseUrl)
        let expectaion = expectation(description: "Wait response of Users end point")
        NetworkServiece.fetch(url: url!) { data in
            guard let data  : [User] = data else{
                expectaion.fulfill()
                return
            }
            XCTAssertNotEqual(data.count,0)
            expectaion.fulfill()
        }
        waitForExpectations(timeout: 3,handler: nil)
        
    }
    func testFetchAlbums(){
        endPoint = EndPoint.albumId
        let url = endPoint!.makeUrlWithId(baseUrl: NetworkServiece.baseUrl, id: "4")
        let ex = expectation(description: "wait album api response")
        NetworkServiece.fetch(url: url) { data in
            guard let data : [Album] = data else{
                ex.fulfill()
                return
            }
            XCTAssertNotEqual(data.count, 0)
            ex.fulfill()
            
        }
        waitForExpectations(timeout: 5,handler:nil)
    }

}
