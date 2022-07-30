//
//  SampleModel.swift
//  Secret Dairy
//
//  Created by ひろ on 2022/07/30.
//

import Foundation
import SwiftUI
import CoreData

class SampleModel :ObservableObject{
    @Published var date = Date()
    @Published var id = UUID()
    @Published var bool = false
    @Published var image1:Data = Data.init()
    @Published var image2:Data = Data.init()
    @Published var text = ""
    @Published var isNewData = false
    @Published var updateItem:SampleData!

    func writeData(context:NSManagedObjectContext) {
        if updateItem != nil {
            updateItem.date = date
            updateItem.bool = bool
            updateItem.image1 = image1
            updateItem.image2 = image2
            updateItem.text = text
            
            try!
            context.save()
            updateItem = nil
            isNewData.toggle()
            date = Date()
            bool = false
            image1 = Data.init()
            image2 = Data.init()
            text = ""
            return
        }
        let newSampleData = SampleData(context: context)
            newSampleData.date = date
            newSampleData.id = UUID()
            newSampleData.bool = bool
            newSampleData.image1 = image1
            newSampleData.image2 = image2
            newSampleData.text = text
        do{
            try
            context.save()
            
            isNewData.toggle()
            
            date = Date()
            bool = false
            image1 = Data.init()
            image2 = Data.init()
            text = ""
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func editItem(item:SampleData){
        updateItem = item
        date = item.wrappedDate
        id = item.wrappedId
        bool = item.bool
        image1 = item.wrappedImg1
        image2 = item.wrappedImg2
        text = item.wrappedText
        
        isNewData.toggle()
    }
}
