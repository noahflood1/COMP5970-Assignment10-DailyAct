//
//  ActModel.swift
//  RandomActOfKindness
//
//  Created by Noah Flood on 7/25/25.
//

import Foundation
import FirebaseFirestore

struct ActModel : Codable, Identifiable { // i don't think we need identifiable here, but maybe.
    @DocumentID var id : String?
    var content : String
    
    init(content: String = "") { // didn't know you could do initalizers with structs
        self.content = content
    }
    
}
