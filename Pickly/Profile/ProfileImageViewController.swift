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
    var profileImage: Int = UserDefaultsManager.shared.profileImage // Noti 전달을 위해 필요
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    override func setNavigation() {
        super.setNavigation()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(leftBarButtonItemClicked))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(rightBarButtonItemClicked))
    }
    
    @objc func leftBarButtonItemClicked() {
        dismiss(animated: true)
    }
    
    @objc func rightBarButtonItemClicked() {
        UserDefaultsManager.shared.profileImage = profileImage
        NotificationCenter.default.post(name: NSNotification.Name(Noti.profileImageChanged.rawValue), object: nil)
        dismiss(animated: true)
    }
    
    override func configureView() {
        super.configureView()
        profileImageView.image = UIImage(named: "profile\(UserDefaultsManager.shared.profileImage)")
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
        let row = indexPath.row
        cell.configureCell(row, profileImage: profileImage)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        profileImage = indexPath.row + 1
        profileImageView.image = UIImage(named: "profile\(profileImage)")
        collectionView.reloadData()
    }
}
