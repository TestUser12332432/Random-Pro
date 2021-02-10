//
//  NumberView.swift
//  Random
//
//  Created by Vitalii Sosin on 08.02.2021.
//  Copyright © 2021 Sosin.bet. All rights reserved.
//

import SwiftUI

struct NumberView: View {
    
    private var appBinding: Binding<AppState.AppData>
    init(appBinding: Binding<AppState.AppData>) {
        self.appBinding = appBinding
    }
    @Environment(\.injected) private var injected: DIContainer
    
    var body: some View {
        ZStack {
            Color(.clear)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                HStack(spacing: 16) {
                    firstTF
                    secondTF
                }
                Spacer()
                Text("\(appBinding.numberRandom.result.wrappedValue)")
                    .font(.robotoBold70())
                    .foregroundColor(.primaryGray())
                    .onTapGesture {
                        generateNumber(state: appBinding)
                        Feedback.shared.impactHeavy(.medium)
                    }   
                
                Spacer()
                
                listResults
                generateButton
            }
            .padding(.top, 16)
            
            .navigationBarTitle(Text(NSLocalizedString("Число", comment: "")), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                appBinding.numberRandom.showSettings.wrappedValue.toggle()
            }) {
                Image(systemName: "gear")
            })
            .sheet(isPresented: appBinding.numberRandom.showSettings, content: {
                NumberSettingsView(appBinding: appBinding)
            })
        }
        .dismissingKeyboard()
    }
}

private extension NumberView {
    var firstTF: some View {
        HStack {
            TextFieldUIKit(placeholder: "1",
                           text: appBinding.numberRandom.firstNumber,
                           font: UIFont.robotoMedium16()!,
                           foregroundColor: UIColor.primaryGray(),
                           keyType: .numberPad,
                           isSecureText: false,
                           textAlignment: .center,
                           limitLength: 4)
                .frame(width: 130, height: 30, alignment: .center)
                .background(Color.primaryPale())
                .cornerRadius(4)
                .overlay(RoundedRectangle(cornerRadius: 4)
                            .stroke(Color(.primaryDefault())))
                .foregroundColor(.clear)
        }
    }
}

private extension NumberView {
    var secondTF: some View {
        HStack {
            TextFieldUIKit(placeholder: "100",
                           text: appBinding.numberRandom.secondNumber,
                           font: UIFont.robotoMedium16()!,
                           foregroundColor: UIColor.primaryGray(),
                           keyType: .numberPad,
                           isSecureText: false,
                           textAlignment: .center,
                           limitLength: 4)
                .frame(width: 130, height: 30, alignment: .center)
                .background(Color.primaryPale())
                .cornerRadius(4)
                .overlay(RoundedRectangle(cornerRadius: 4)
                            .stroke(Color(.primaryDefault())))
                .foregroundColor(.clear)
        }
    }
}

private extension NumberView {
    var listResults: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(appBinding.numberRandom.listResult.wrappedValue, id: \.self) { number in
                    
                    Text("\(number)")
                        .foregroundColor(.primaryGray())
                        .font(.robotoMedium18())
                }
            }
            .padding(.leading, 16)
            .padding(.vertical, 16)
        }
    }
}

private extension NumberView {
    var generateButton: some View {
        Button(action: {
            generateNumber(state: appBinding)
            Feedback.shared.impactHeavy(.medium)
        }) {
            ButtonView(background: .primaryTertiary(),
                       textColor: .primaryPale(),
                       borderColor: .primaryPale(),
                       text: NSLocalizedString("Сгенерировать", comment: ""),
                       switchImage: false,
                       image: "")
        }
        .padding(16)
    }
}

// MARK: Actions
private extension NumberView {
    private func generateNumber(state: Binding<AppState.AppData>) {
        injected.interactors.numberInteractor.generateNumber(state: state)
    }
}

struct NumberView_Previews: PreviewProvider {
    static var previews: some View {
        NumberView(appBinding: .constant(.init()))
    }
}