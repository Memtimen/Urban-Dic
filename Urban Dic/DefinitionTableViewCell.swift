//
//  DefinitionTableViewCell.swift
//  Urban Dic
//
//  Created by Maimaitiming Abudukadier on 1/24/16.
//  Copyright © 2016 Maimaitiming Abudukadier. All rights reserved.
//

import UIKit

class DefinitionTableViewCell: UITableViewCell {

//    @IBOutlet weak var labelDef: UILabel!
    @IBOutlet weak var textViewDef: UITextView!
    @IBOutlet weak var labelDown: UILabel!
    @IBOutlet weak var labelUp: UILabel!
    @IBOutlet weak var labelAuthor: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
