/*
 Muscle Book
 Copyright (C) 2016  Cristian Filipov

 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import UIKit
import Eureka

class AnatomyViewCell : Cell<AnatomyViewConfig>, CellType {

    let anatomyView: AnatomySplitView = {
        let v = AnatomySplitView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    required init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        height = { UIScreen.mainScreen().bounds.height - (60 + 44 + 20) }
    }

    override func setup() {
        super.setup()
        row.title = nil
        selectionStyle = .None
        contentView.addSubview(anatomyView)
        let views : [String: AnyObject] =  ["anatomyView": anatomyView]
        contentView.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat(
                "V:|[anatomyView]|",
                options: [],
                metrics: nil,
                views: views
            )
        )
        contentView.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat(
                "H:|[anatomyView]|",
                options: [],
                metrics: nil,
                views: views
            )
        )
    }

    override func update() {
        row.title = nil
        super.update()
        if let config = row.value {
            anatomyView.reset()
            let displayableConfig = anatomyView.configure(config)
            if displayableConfig.fillColors != config.fillColors {
                row.value = displayableConfig
            }
        }
        self.setNeedsDisplay()
    }

}

final class AnatomyViewRow: Row<AnatomyViewConfig, AnatomyViewCell>, RowType {

    required init(tag: String?) {
        super.init(tag: tag)
        displayValueFor = nil
    }

}
