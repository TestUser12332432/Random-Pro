//
//  MainView.swift
//  Random
//
//  Created by Vitalii Sosin on 08.02.2021.
//  Copyright © 2021 Sosin.bet. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    private var appBinding: Binding<AppState.AppData>
    init(appBinding: Binding<AppState.AppData>) {
        self.appBinding = appBinding
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(alignment: .center, spacing: 16) {
                    HStack {
                        NavigationLink(
                            destination: NumberView(appBinding: appBinding)) {
                            CellMainView(image: "number",
                                         title: NSLocalizedString("Число", comment: ""))
                        }
                        
                        NavigationLink(
                            destination: YesOrNotView(appBinding: appBinding)) {
                            CellMainView(image: "questionmark.square.dashed",
                                         title: NSLocalizedString("Да или Нет", comment: ""))
                        }
                    }
                    
                    HStack {
                        NavigationLink(
                            destination: CharactersView(appBinding: appBinding)) {
                            CellMainView(image: "textbox",
                                         title: NSLocalizedString("Буква", comment: ""))
                        }
                        
                        NavigationLink(
                            destination: ListWordsView(appBinding: appBinding)) {
                            CellMainView(image: "rectangle.and.pencil.and.ellipsis",
                                         title: NSLocalizedString("Список", comment: ""))
                        }
                    }
                    
                    HStack {
                        NavigationLink(
                            destination: CoinView(appBinding: appBinding)) {
                            CellMainView(image: "bitcoinsign.circle",
                                         title: NSLocalizedString("Монета", comment: ""))
                        }
                        
                        NavigationLink(
                            destination: CubeView(appBinding: appBinding)) {
                            CellMainView(image: "cube",
                                         title: NSLocalizedString("Кубики", comment: ""))
                        }
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 16)
                
            }
            .navigationBarTitle(Text("Random"))
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(appBinding: .constant(.init()))
    }
}