//
//  ContentView.swift
//  FoodSections
//
//  Created by Artem on 22.04.2022.
//

import SwiftUI

struct ContentView: View {
	
	@StateObject var foodSectionsModel = FoodSectionsModel.shared
	
    var body: some View {
        FoodSectionsView()
			.onAppear {
				Task {
					await foodSectionsModel.fetchSections()
				}
			}
    }
}
