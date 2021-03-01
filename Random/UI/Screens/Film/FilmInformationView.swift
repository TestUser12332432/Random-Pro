//
//  FilmInformationView.swift
//  Random Pro
//
//  Created by Vitalii Sosin on 01.03.2021.
//  Copyright © 2021 Sosin.bet. All rights reserved.
//

import SwiftUI

struct FilmInformationView: View {
    private var filmsInfo: FilmsInfo
    private var iframeSrc: String
    init(filmsInfo: FilmsInfo, iframeSrc: String) {
        self.filmsInfo = filmsInfo
        self.iframeSrc = iframeSrc
    }
    
    var body: some View {
        VStack {
            listResults
        }
        .navigationBarTitle(Text(NSLocalizedString("Информация по фильму", comment: "")), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            getLinkFromStringURL(strURL: iframeSrc)
        }) {
            Image(systemName: "play.rectangle")
                .font(.system(size: 24))
                .gradientForeground(colors: [Color.primaryError(), Color.red]).opacity(0.5)
        })
    }
}

private extension FilmInformationView {
    var listResults: some View {
        List {
            HStack(spacing: 16) {
                Text(NSLocalizedString("Название фильма:", comment: ""))
                    .foregroundColor(.primaryGray())
                    .font(.robotoMedium18())
                
                Spacer()
                
                Text(NSLocalizedString("домен", comment: "") == "ru" ? "\(filmsInfo.data?.nameRu ?? "")" : "\(filmsInfo.data?.nameEn ?? "")")
                    .gradientForeground(colors: [Color.primaryGreen(), Color.primaryTertiary()])
                    .font(.robotoMedium18())
            }
            
            HStack(spacing: 16) {
                Text(NSLocalizedString("Год:", comment: ""))
                    .foregroundColor(.primaryGray())
                    .font(.robotoMedium18())
                
                Spacer()
                
                Text("\(filmsInfo.data?.year ?? "")")
                    .gradientForeground(colors: [Color.primaryGreen(), Color.primaryTertiary()])
                    .font(.robotoMedium18())
            }
            
            HStack(spacing: 16) {
                Text(NSLocalizedString("Продолжительность фильма:", comment: ""))
                    .foregroundColor(.primaryGray())
                    .font(.robotoMedium18())
                
                Spacer()
                
                Text("\(filmsInfo.data?.filmLength ?? "")")
                    .gradientForeground(colors: [Color.primaryGreen(), Color.primaryTertiary()])
                    .font(.robotoMedium18())
            }
            
            HStack(spacing: 16) {
                Text(NSLocalizedString("Возрастные ограничения:", comment: ""))
                    .foregroundColor(.primaryGray())
                    .font(.robotoMedium18())
                
                Spacer()
                
                Text("\(filmsInfo.data?.ratingAgeLimits ?? 0)+")
                    .gradientForeground(colors: [Color.primaryGreen(), Color.primaryTertiary()])
                    .font(.robotoMedium18())
            }
            
            HStack(spacing: 16) {
                Text(NSLocalizedString("Описание:", comment: ""))
                    .foregroundColor(.primaryGray())
                    .font(.robotoMedium18())
                
                Spacer()
                
                Text("\(filmsInfo.data?.description ?? "")")
                    .gradientForeground(colors: [Color.primaryGreen(), Color.primaryTertiary()])
                    .font(.robotoMedium18())
            }
        }
    }
}

struct FilmInformation_Previews: PreviewProvider {
    static var previews: some View {
        FilmInformationView(filmsInfo: .init(), iframeSrc: "")
    }
}
