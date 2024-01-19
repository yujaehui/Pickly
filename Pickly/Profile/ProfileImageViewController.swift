//
//  ProfileImageViewController.swift
//  Pickly
//
//  Created by Jaehui Yu on 1/19/24.
//

import UIKit

final class ProfileImageViewController: BaseViewController {
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var profileImageCollectionView: UICollectionView!
    
    var accessType: AccessType = .setting
    var profileImage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        configureView()
        configureCollectionView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UserDefaultsManager.shared.profileImage = profileImage
    }
}

extension ProfileImageViewController {
    func setNavigation() {
        navigationItem.title = accessType.rawValue
    }
}

extension ProfileImageViewController {
    func configureView() {
        profileImageCollectionView.setScrollViewBackgroundColor()
        let profileImage = UserDefaultsManager.shared.profileImage
        profileImageView.image = UIImage(named: "profile\(profileImage)")
        profileImageView.configureProfileImageView()
    }
}

extension ProfileImageViewController {
    func configureCollectionView() {
        let xib = UINib(nibName: ProfileImageCollectionViewCell.identifier, bundle: nil)
        profileImageCollectionView.register(xib, forCellWithReuseIdentifier: ProfileImageCollectionViewCell.identifier)
        
        profileImageCollectionView.dataSource = self
        profileImageCollectionView.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 16
        let cellWidth = UIScreen.main.bounds.width - (spacing * 5)
        layout.itemSize = CGSize(width: cellWidth / 4, height: cellWidth / 4)
        layout.sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        profileImageCollectionView.collectionViewLayout = layout
    }
}

extension ProfileImageViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.identifier, for: indexPath) as! ProfileImageCollectionViewCell
        cell.configureCell(indexPath.row, profileImage: profileImage)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        profileImage = indexPath.row + 1
        profileImageView.image = UIImage(named: "profile\(profileImage)")
        collectionView.reloadData()
    }
}
