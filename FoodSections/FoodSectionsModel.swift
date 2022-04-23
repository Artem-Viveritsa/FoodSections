//
//  FoodSectionsModel.swift
//  FoodSections
//
//  Created by Artem on 22.04.2022.
//

import Foundation
import SwiftUI

struct FoodImage: Codable {
	let x1, x2, x3: URL
	let aspectRatio: Int?
	let loopAnimation: Bool?
	
	private enum CodingKeys: String, CodingKey {
		case x1 = "1x", x2 = "2x", x3 = "3x", aspectRatio, loopAnimation
	}
	
	func getImageByScale(_ scale: CGFloat) -> URL {
		switch scale{
		case 1:
			return x1
		case 2:
			return x2
		case 3:
			return x3
			
		default:
			return x2
		}
	}
}

struct FoodItem: Codable, Identifiable, Equatable, Hashable {
	let id: UUID
	let title: String
	let image: FoodImage
	
	static func == (lhs: FoodItem, rhs: FoodItem) -> Bool {
		lhs.id == rhs.id
	}
	
	func hash (into hasher: inout Hasher) {
		hasher.combine(id)
	}
}

struct FoodSection: Codable, Identifiable {
	let id: String
	let header: String
	let items: [FoodItem]
	let itemsToShow: Int
	let itemsTotal: Int
}

struct FoodSections: Codable {
	let sections: [FoodSection]
}

class FoodSectionsModel: ObservableObject {
	
	static let shared = FoodSectionsModel()
	
	@Published var sections = [FoodSection]()
	
	@MainActor
	func fetchSections() async {
		if let url = URL(string: jsonUrl) {
			do {
				let (data, _) = try await URLSession.shared.data(from: url)
				sections = try JSONDecoder().decode(FoodSections.self, from: data).sections
			} catch {
				debugPrint("Fetch error")
			}
		}
	}
	
	
}
