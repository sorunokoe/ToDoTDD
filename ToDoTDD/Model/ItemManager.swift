//
//  ItemManager.swift
//  ToDoTDD
//
//  Created by Mac on 29.08.2018.
//  Copyright © 2018 salgara. All rights reserved.
//

import UIKit

class ItemManager: NSObject{
    var toDoCount: Int { return toDoItems.count}
    var doneCount: Int { return doneItems.count}
    private var toDoItems = [ToDoItem]()
    private var doneItems = [ToDoItem]()
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(save), name: .UIApplicationWillResignActive, object: nil)
        if let nsToDoItems = NSArray(contentsOf: toDoPathURL) {
            for dict in nsToDoItems {
                if let toDoItem = ToDoItem(dict: dict as! NSDictionary) {
                    toDoItems.append(toDoItem)
                }
            }
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
        save()
    }
    
    var toDoPathURL: URL {
        let fileURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        guard let documentURL = fileURLs.first else {
            print("Something went wrong. Documents url could not befound")
            fatalError()
        }
        return documentURL.appendingPathComponent("toDoItems.plist")
    }
    
    @objc func save() {
        var nsToDoItems = [AnyObject]()
        for item in toDoItems {
            nsToDoItems.append(item.plistDict)
        }
        if nsToDoItems.count > 0 {
            (nsToDoItems as NSArray).write(to: toDoPathURL, atomically: true)
        } else {
            do {
                try FileManager.default.removeItem(at: toDoPathURL)
            } catch {
                print(error)
            }
        }
    }
    func addItem(_ item: ToDoItem){
        if !toDoItems.contains(item) {
            toDoItems.append(item)
        }
    }
    func itemAtIndex(_ index: Int) -> ToDoItem {
        if !toDoItems.isEmpty{
            return toDoItems[index]
        }
        return ToDoItem(title: "Hi")
    }
    func checkItemAtIndex(_ index: Int) {
        let item = toDoItems.remove(at: index)
        doneItems.append(item)
    }
    func doneItemAtIndex(_ index: Int) -> ToDoItem {
        return doneItems[index]
    }
    func removeAllItems() {
        toDoItems.removeAll()
        doneItems.removeAll()
    }
    func uncheckItemAtIndex(index: Int) {
        let item = doneItems.remove(at: index)
        toDoItems.append(item)
    }
}

