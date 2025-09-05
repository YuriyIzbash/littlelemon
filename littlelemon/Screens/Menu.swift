//
//  Menu.swift
//  littlelemon
//
//  Created by yuriy on 5. 9. 25.
//

import SwiftUI
import CoreData

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var searchText: String = ""
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Little Lemon 🍋")
                .font(.largeTitle)
                .bold()

            Text("Chicago")
                .font(.title2)

            Text("The best Mediterranean food in town, served fresh daily.")
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            TextField("Search menu", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            FetchedObjects(
                predicate: buildPredicate(),
                sortDescriptors: buildSortDescriptors()
            ) { (dishes: [Dish]) in
                List {
                    ForEach(dishes, id: \.self) { dish in
                        HStack {
                            Text("\(dish.title ?? "") - $\(dish.price ?? "")")
                            if let urlString = dish.image,
                               let url = URL(string: urlString) {
                                AsyncImage(url: url) { image in
                                    image.resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                        }
                    }
                }
            }

        }
        .padding()
        .onAppear {
            getMenuData()
        }
    }

    private func getMenuData() {
        // Fetch current dishes
        let request: NSFetchRequest<Dish> = Dish.fetchRequest()
        let count = (try? viewContext.count(for: request)) ?? 0

        guard count == 0 else { return }

        let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let url = URL(string: urlString)!
        let requestURL = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: requestURL) { data, _, error in
            if let data = data {
                let decoder = JSONDecoder()
                if let decoded = try? decoder.decode(MenuList.self, from: data) {
                    DispatchQueue.main.async {
                        for item in decoded.menu {
                            let dish = Dish(context: viewContext)
                            dish.title = item.title
                            dish.image = item.image
                            dish.price = item.price
                        }
                        try? viewContext.save()
                    }
                }
            }
        }
        task.resume()
    }
    
    private func buildSortDescriptors() -> [NSSortDescriptor] {
        return [
            NSSortDescriptor(
                key: "title",
                ascending: true,
                selector: #selector(NSString.localizedStandardCompare(_:))
            )
        ]
    }
    
    private func buildPredicate() -> NSPredicate {
        if searchText.isEmpty {
            return NSPredicate(value: true) // No filter
        } else {
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
    }
}


#Preview {
    Menu()
}
