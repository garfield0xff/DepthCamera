//
//  GalleryView.swift
//  ARSessionTesting
//
//  Created by Gyujin Kim on 4/12/24.
//

import SwiftUI

struct CaptureFolderView: View {
    var appModel: AppDataModel

    var body: some View {
        FetchModelView().onDisappear {
            DispatchQueue.main.async {
                self.appModel.sessionState = .notSet
            }
        }
    }
}

//#Preview {
//    GalleryView(appModel: AppDataModel = AppDataModel)
//}
