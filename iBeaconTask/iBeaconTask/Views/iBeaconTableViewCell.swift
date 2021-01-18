//
//  iBeaconTableViewCell.swift
//  iBeaconTask
//
//  Created by Aleksandr on 14/01/2021.
//  Copyright © 2021 Aleksandr Shushkov. All rights reserved.
//

import UIKit

class iBeaconTableViewCell: UITableViewCell {

    var uuidLabel: UILabel = {
        var uuidLabel = UILabel()
        uuidLabel.translatesAutoresizingMaskIntoConstraints = false
        return uuidLabel
    }()
    
    var majorLabel: UILabel = {
        var majorLabel = UILabel()
        majorLabel.translatesAutoresizingMaskIntoConstraints = false
        return majorLabel
    }()
    
    var minorLabel: UILabel = {
        var minorLabel = UILabel()
        minorLabel.translatesAutoresizingMaskIntoConstraints = false
        return minorLabel
    }()
    
    var rssiLabel: UILabel = {
        var rssiLabel = UILabel()
        rssiLabel.translatesAutoresizingMaskIntoConstraints = false
        return rssiLabel
    }()
    
    var accuracyLabel: UILabel = {
        var accuracyLabel = UILabel()
        accuracyLabel.translatesAutoresizingMaskIntoConstraints = false
        return accuracyLabel
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(uuidLabel)
        contentView.addSubview(majorLabel)
        contentView.addSubview(minorLabel)
        contentView.addSubview(rssiLabel)
        contentView.addSubview(accuracyLabel)
        
        NSLayoutConstraint.activate([
            uuidLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 8),
            uuidLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            uuidLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            majorLabel.topAnchor.constraint(equalTo: uuidLabel.bottomAnchor, constant: 8),
            majorLabel.leadingAnchor.constraint(equalTo: uuidLabel.leadingAnchor),
            
            minorLabel.topAnchor.constraint(equalTo: majorLabel.topAnchor),
            minorLabel.leadingAnchor.constraint(equalTo: majorLabel.trailingAnchor, constant: 8),
            minorLabel.trailingAnchor.constraint(equalTo: uuidLabel.trailingAnchor),
            minorLabel.widthAnchor.constraint(equalTo: majorLabel.widthAnchor),
            
            rssiLabel.topAnchor.constraint(equalTo: majorLabel.bottomAnchor, constant: 8),
            rssiLabel.leadingAnchor.constraint(equalTo: majorLabel.leadingAnchor),
            rssiLabel.trailingAnchor.constraint(equalTo: minorLabel.trailingAnchor),
            
            accuracyLabel.topAnchor.constraint(equalTo: rssiLabel.bottomAnchor, constant: 8),
            accuracyLabel.leadingAnchor.constraint(equalTo: rssiLabel.leadingAnchor),
            accuracyLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            accuracyLabel.trailingAnchor.constraint(equalTo: rssiLabel.trailingAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
