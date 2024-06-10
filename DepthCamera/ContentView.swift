//
//  ContentView.swift
//  ARSessionTesting
//
//  Created by Gyujin Kim on 4/9/24.
//

import SwiftUI
import SwiftData



struct ContentView: View {
    @StateObject var appModel: AppDataModel = AppDataModel.instance
    @State private var isNavigationToCaptureFolder = false
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color.black.ignoresSafeArea()
                VStack {
                    arSessionView
                    selectViewSection
                    EventViewSection
                }
                .environmentObject(appModel)
                
            }.navigationDestination(isPresented: $isNavigationToCaptureFolder, destination: { CaptureFolderView(appModel: appModel) } )
        }
    }
    
    private var arSessionView: some View {
        Group {
            switch appModel.sessionState {
            case .notSet:
                LidarController().ignoresSafeArea()
            case .objectCapture:
                LidarController().ignoresSafeArea()
            case .roomCapture:
                RoomController().ignoresSafeArea()
            case .lidarCapture:
                LidarController().ignoresSafeArea()
            }
        }.onChange(of: appModel.sessionState) { 
            appModel.modelState = .restart
        }
    }
    
    private var selectViewSection: some View {
        HStack(spacing: 40) {
            SelectViewButton(label: "Lidar", mode: .lidarCapture, sessionState: $appModel.sessionState)
            SelectViewButton(label: "Room", mode: .roomCapture, sessionState: $appModel.sessionState)
        }
    }
    
    private var EventViewSection: some View {
        HStack {
            GalleryButton(isNavigationToCaptureFolder: $isNavigationToCaptureFolder, appModel: appModel)
            Spacer()
            CameraCaptureButton().onTapGesture {
                self.appModel.modelState = .completed
            }
            Spacer()
            SessionStopButton()
            
        }.padding()
    }

}

struct GalleryButton: View {
    @Binding var isNavigationToCaptureFolder: Bool
    var appModel: AppDataModel

    var body: some View {
        Button(action: {
            self.appModel.modelState = .restart
            self.isNavigationToCaptureFolder = true  // 네비게이션 활성화
        }) {
            Image(systemName: "photo.stack")
                .resizable()
                .foregroundColor(.white)
                .frame(width: 40, height: 40)
        }
    }
}


struct SessionStopButton: View {
    var body: some View {
        Button(action : {}) { Text("Stop").padding().background(Color.blue).foregroundColor(Color.white).cornerRadius(10)}
    }
}


struct SelectViewButton: View {
    let label: String
    let mode: AppDataModel.SessionState
    @Binding var sessionState: AppDataModel.SessionState
    
    var body: some View {
        Button(action: {
            self.sessionState = mode
        }) {
            Text(label).foregroundColor(sessionState == mode ? .yellow : .white)
        }
    }
}


#Preview {
    ContentView()
}
