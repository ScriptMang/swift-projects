//
//  MealTableViewCell.swift
//  FoodTracker
//
//  Created by Andy Peralta on 6/22/20.
//  Copyright © 2020 UGLYMUG. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {
  //MARK: Properties
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var ratingControl: RatingControl!




  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
