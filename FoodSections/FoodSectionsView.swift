//
//  FoodSectionsView.swift
//  FoodSections
//
//  Created by Artem on 22.04.2022.
//

import SwiftUI

struct FoodSectionsView: View {
	
	@StateObject var vm = FoodSectionsViewModel()
	
	var body: some View {
		ScrollView {
			VStack {
				ForEach (vm.sections) { section in
					FoodSectionView(section: section)
				}
			}
		}
		.environmentObject(vm)
		
	}
}

struct FoodSectionView: View {
	
	let section: FoodSection
	
	var body: some View {
		VStack (alignment: .leading) {
			
			Text (section.header)
				.font(.title)
				.bold()
				.padding(.horizontal, 20)
			
			ScrollView (.horizontal) {
				HStack (spacing: 15) {
					ForEach (section.items) { item in
						FoodItemView(item: item)
					}
				}
				.padding(.horizontal, 20)
			}
			
		}
		.padding(.vertical, 20)
	}
}

struct FoodItemView: View {
	
	let item: FoodItem
	
	@EnvironmentObject private var vm: FoodSectionsViewModel
	
	private let width: CGFloat = 160
	private let height: CGFloat = 200
	private let cornerRadius: CGFloat = 20
	
	var body: some View {
		
		let selected = vm.selectedItems.contains(item)
		
		VStack (alignment: .trailing) {
			
			Spacer()
			
			Text(item.title)
				.bold()
				.padding(10)
				.frame(maxWidth: .infinity)
				.background(.ultraThinMaterial)
			
		}
		.frame(width: width, height: height)
		.background(
			AsyncImage (url: item.image.getImageByScale(deviceScale)) { image in
				image.resizable()
			} placeholder: {
				ProgressView()
			}
		)
		.cornerRadius(cornerRadius)
		.overlay(
			RoundedRectangle(cornerRadius: cornerRadius)
				.strokeBorder(selected ? .mint : .clear, lineWidth: selected ? 5 : 0)
				.animation(.default, value: selected)
		)
		.onTapGesture {
			vm.onTap(item)
		}
		
	}
}


