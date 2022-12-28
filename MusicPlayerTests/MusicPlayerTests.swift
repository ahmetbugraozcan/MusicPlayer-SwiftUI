//
//  MusicPlayerTests.swift
//  MusicPlayerTests
//
//  Created by Ahmet Buğra Özcan on 10.12.2022.
//


@testable import FirebaseFirestoreSwift

@testable import MusicPlayer_Test_App
import XCTest
@testable import Firebase

final class MusicPlayerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        FirebaseApp.configure()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        let expectation = XCTestExpectation(description: "Callback is called")
    
        var db = Firestore.firestore()
      

        db.collection("musics").whereField("id", in: ["UKizECUMopDapCPCNooA", "zhusGy4yZpqfKosTSzJh"]).getDocuments { snapshot, error in
          
            XCTAssertNotNil(snapshot, "Some error occured error is \(error)")
            XCTAssert(snapshot == nil, "Snapshot nil \(snapshot)")
            XCTAssert(snapshot?.isEmpty ?? true, "SNAPSHOT BOŞ")
    
            print("Snapshot is \(snapshot)")
         
        
        }
        
        wait(for: [expectation], timeout: 10)

    }
    
     func testjsonPlaceholderTest() async {
         let expectation = XCTestExpectation(description: "Callback is called")
         let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1")!
                let request = URLRequest(url: url)

                URLSession.shared.dataTask(with: request) { data, response, error in
                    if let data = data {
                        let todo = try? JSONDecoder().decode(Todo.self, from: data)
                        DispatchQueue.main.async {
                            print("todo is \(todo)")
                            XCTAssert(todo != nil, "Snapshot nil \(todo)")
                            expectation.fulfill()
                        }
                    }
                }.resume()
         wait(for: [expectation], timeout: 10)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
