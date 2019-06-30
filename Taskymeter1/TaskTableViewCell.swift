//
//  TaskTableViewCell.swift
//  Taskymeter1
//
//  Created by user155748 on 6/29/19.
//  Copyright © 2019 UPC. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var taskDescriptionLabel: UILabel!
    @IBOutlet weak var taskTitleLabel: UILabel!
    @IBOutlet weak var taskStatusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setTask(WithName name: String, WithDescription descripion: String, WithStatus status: String) {
        self.taskTitleLabel.text = name
        self.taskDescriptionLabel.text = descripion
        self.taskStatusLabel.text = status
    }
}
