//
//  FFGroceryLists.swift
//  FreshFinder
//
//  Created by Guillermo Santos Barrios on 3/2/23.
//

import SwiftUI
import RealmSwift

struct FFGroceryLists: View {
    
    @ObservedObject var groceryListStore: GroceryListStore
    
    @ObservedResults(GroceryList.self) var lists
    
    let columns = [GridItem(.flexible())]

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                NavigationLink(destination: FFGroceryListForm().environmentObject(groceryListStore)) {
                    Text("Nueva Lista")
                }
                .buttonStyle(FFMainButton())
                List {
                    ForEach(lists, id: \._id) { groceryList in
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
                        $lists.remove(atOffsets: deletedRows)
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
        FFGroceryLists(groceryListStore: GroceryListStore())
            .environment(\.realm, Persistence.preview.realm)
    }
}
