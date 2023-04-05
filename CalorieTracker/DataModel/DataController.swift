//
//  DataController.swift
//  CalorieTracker
//
//  Created by Onur Celik on 4.04.2023.
//

import Foundation
import CoreData
class DataController: ObservableObject{
    let container = NSPersistentContainer(name: "FoodModel")
    
    init(){
        container.loadPersistentStores { desc, error in
            if let error = error{
                print("Failed to load data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext){
        do{
            try context.save()
            print("Data saved")
        }catch{
            print(error.localizedDescription)
        }
    }
    func addFood(name:String,calories:Double,context:NSManagedObjectContext){
        let food = Entity(context: context)
        food.id = UUID()
        food.name = name
        food.calories = calories
        food.date = Date()
        save(context: context)
    }
    func editFood(food:Entity,name:String,calories:Double,context:NSManagedObjectContext){
        food.name = name
        food.calories = calories
        food.date = Date()
        save(context: context)
    }
}
