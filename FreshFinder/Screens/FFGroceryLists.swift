//
//  FFGroceryLists.swift
//  FreshFinder
//
//  Created by Guillermo Santos Barrios on 3/2/23.
//

import SwiftUI

struct FFGroceryLists: View {
    
    @ObservedObject var groceryListStore: GroceryListStore
    
    let columns = [GridItem(.flexible())]

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                NavigationLink(destination: FFGroceryListForm().environmentObject(groceryListStore)) {
                    Text("Nueva Lista")
                }
                .buttonStyle(FFMainButton())
                List {

                    ForEach(groceryListStore.groceryLists, id: \.id) { groceryList in
                        groceryListCell(groceryList: groceryList)
                            .listRowInsets(EdgeInsets())
                            .listRowSeparator(.hidden)
                    }
                    .onDelete(perform: { deletedRows in
                        groceryListStore.deleteLists(at: deletedRows)
                    })
                    .padding(.top)
                }
                .listStyle(.inset)
            }
            .padding(.top, 24)
            .padding(.horizontal)
            .navigationTitle("Tus Listas")
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    @ViewBuilder
    func groceryListCell(groceryList: GroceryList) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 12) {
                Text(groceryList.name)
                    .font(.title2)
                Text("\(groceryList.items.count) productos")
            }
            Spacer()
            Text(groceryList.items.budget().toCurrencyString())
                .font(.title)
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .strokeBorder(Color.black, lineWidth: 2)
                .background(RoundedRectangle(cornerRadius: 20).fill(.thinMaterial))
        )
    }
}

struct FFGroceryLists_Previews: PreviewProvider {
    static var previews: some View {
        FFGroceryLists(groceryListStore: GroceryListStore(groceryLists: [
            GroceryList(name: "Test List", items: [GroceryListItem(name: "Manzana", quantity: 2)])
        ]))
    }
}
