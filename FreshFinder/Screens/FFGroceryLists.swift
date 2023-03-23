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
                        ZStack {
                            NavigationLink {
                                FFGroceryList(groceryList: groceryList)
                            } label: {
                                EmptyView()
                            }
                            groceryListCell(groceryList: groceryList)
                                .buttonStyle(.plain)
                        }
                        
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                    }
                    .onDelete(perform: { deletedRows in
                        groceryListStore.deleteLists(at: deletedRows)
                    })
                    
                    
                }
                .listStyle(.inset)
                .environment(\.defaultMinListRowHeight, 124)
                
            }
            .padding(.top, 24)
            .padding(.horizontal)
            .navigationTitle("Tus Listas")
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
}

struct FFGroceryLists_Previews: PreviewProvider {
    static var previews: some View {
        FFGroceryLists(groceryListStore: GroceryListStore(viewContext: PersistenceController.preview.container.viewContext))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
