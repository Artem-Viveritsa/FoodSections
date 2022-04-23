//
//  FoodSectionsViewModel.swift
//  FoodSections
//
//  Created by Artem on 22.04.2022.
//

import Combine

class FoodSectionsViewModel: ObservableObject {
	
	@Published var sections = [FoodSection]()
	@Published var selectedItems = Set<FoodItem>()
	
	private let foodSectionsModel = FoodSectionsModel.shared
	private var cancellable = Set<AnyCancellable>()
	
	init(){
		foodSectionsModel.$sections
			.assign(to: \.sections, on: self)
			.store(in: &cancellable)
	}
	
	func onTap(_ item: FoodItem) {
		print(item.title)
		
		if selectedItems.contains(item) {
			selectedItems.remove(item)
		} else if selectedItems.count < 6 {
			selectedItems.insert(item)
		}
	}
	
	
}
