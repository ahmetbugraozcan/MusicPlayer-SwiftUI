//
//  MusicPlayerApp.swift
//  MusicPlayer
//
//  Created by Ahmet Buğra Özcan on 10.12.2022.
//

import SwiftUI
import Firebase
import GoogleSignIn
import BackgroundTasks

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, open url: URL, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        GIDSignIn.sharedInstance.handle(url)
        return true
    }
    
    
}
class SceneDelegate: NSObject, UISceneDelegate {
    private(set) static var shared: SceneDelegate?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        Self.shared = self
    }
}

struct MusicPlayerAppWithoutBGTask: Scene {
    
    var body: some Scene {
        
            WindowGroup {
                LandingScreen()
            }
        
    }
}

@available(iOS 16.0, *)
struct MusicPlayerApp: Scene {
    init() {
  
        scheduleAppRefresh()
    }
    var body: some Scene {
        
            WindowGroup {
                LandingScreen()
            }.backgroundTask(.appRefresh("MusicPlayerApp")){
                var data = await getFakeData()
                scheduleAppRefresh()
               
              
            }.backgroundTask(.urlSession("getFakeData"), action: {
                
            })
    }
}



@main
struct AppLoader {
 
    
    static func main() {
        if #available(iOS 16, *) {  // << conditional availability !!
            AppWithBGTask.main()
        } else {
            AppWithoutBGTask.main()
        }
    }
}


@available (iOS 16, *)
struct AppWithBGTask: App {
    init() {

        FirebaseApp.configure()
       
    }
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        MusicPlayerApp()
    }
}

struct AppWithoutBGTask: App {

    init() {
    
        FirebaseApp.configure()
    }
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        MusicPlayerAppWithoutBGTask()
    }
}

func scheduleAppRefresh(){
//    UserDefaults.standard.set("BACKGROUND WORKED", forKey: "bgtest")
    let today = Calendar.current.date(byAdding: .second, value: 30, to: Date())!
    
    let request = BGAppRefreshTaskRequest(identifier: "MusicPlayerApp")
    request.earliestBeginDate = today
    do{
        try? BGTaskScheduler.shared.submit(request)

    } catch{
        print("ERROR IS \(error)")
    }
    
}

func getFakeData() async {

    UserDefaults.standard.set("bgtest worked", forKey: "bgtest")
    let config = URLSessionConfiguration.background(withIdentifier: "getFakeData")
    config.sessionSendsLaunchEvents = true
    let session = URLSession(configuration: config)
    
    let request = URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/todos/1")!)
    let response = await withTaskCancellationHandler{
        try? await session.data(for: request)
    } onCancel: {
        let task = session.downloadTask(with: request)
        task.resume()
    }
    if let data = response {
        let todo = try? JSONDecoder().decode(Todo.self, from: data.0)
        UserDefaults.standard.set(todo, forKey: "todotest")
    }
}
