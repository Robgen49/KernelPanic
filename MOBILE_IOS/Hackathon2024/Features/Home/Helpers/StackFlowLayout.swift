//
//  StackFlowLayout.swift
//  Hackathon2024
//
//  Created by Николай Прощалыкин on 20.04.2024.
//

import UIKit

final class StackFlowLayout: UICollectionViewFlowLayout {
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

        guard let collectionView = collectionView,
              let attributesList = super.layoutAttributesForElements(in: rect) else { return nil }

        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.frame.size)

        attributesList.forEach { attributes in
            let distance = visibleRect.midY - attributes.center.y
            let newScale = max(1 - abs(distance) * 0.001, 0.7)
            
            attributes.transform = .init(scaleX: 1, y: newScale)
        }

        return attributesList
    }
}
