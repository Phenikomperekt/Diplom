//
//  News.swift
//  DIplom
//
//  Created by Evgeny Mastepan on 01.04.2022.
//

import Foundation

struct News: Decodable {

    struct Article: Decodable {
        let author, description, image: String
        let likes, views: Int

        enum CodingKeys: String, CodingKey {
            case author, description, image, likes, views
        }

    }

    let articles: [Article]

}
