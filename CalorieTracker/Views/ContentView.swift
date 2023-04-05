//
//  ContentView.swift
//  CalorieTracker
//
//  Created by Onur Celik on 4.04.2023.
//

import SwiftUI
import CoreData
struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date,order:.reverse)]) var food:
    FetchedResults<Entity>
    @State private var showingAddView = false
    var body: some View {
        NavigationView{
            VStack(alignment:.leading){
                Text("\(Int(totalCaloriesToday())) kcal Today")
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                List{
                    ForEach(food){food in
                        NavigationLink {
                            EditFoodView(food: food)
                        } label: {
                            HStack {
                                VStack(alignment: .leading,spacing: 6) {
                                    Text(food.name!).bold()
                                    Text("\(Int(food.calories)) ") + Text("calories").foregroundColor(.red)
                                }
                                Spacer()
                                Text(calcTimeSince(date:food.date!))
                                    .foregroundColor(.gray)
                                    .italic()
                            }
                        }

                    }
                    .onDelete(perform: deleteFood)
                }
                .listStyle(.plain)
                
                
            }
            .navigationTitle("Calorie Tracker")
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add Food") {
                        showingAddView.toggle()
                    }
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddFoodView()
            }
        }
    }
    private func totalCaloriesToday()->Double{
        var caloriesToday: Double = 0
        for item in food{
            if Calendar.current.isDateInToday(item.date!){
                caloriesToday += item.calories
            }
        }
        return caloriesToday
    }
    private func deleteFood(offsets:IndexSet){
        offsets.map{food[$0]}.forEach(managedObjContext.delete)
        DataController().save(context: managedObjContext)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
