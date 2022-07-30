//
//  SampleData+CoreDataProperties.swift
//  Secret Dairy
//
//  Created by ひろ on 2022/07/30.
//
//

import Foundation
import CoreData


extension SampleData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SampleData> {
        return NSFetchRequest<SampleData>(entityName: "SampleData")
    }

    @NSManaged public var bool: Bool
    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var image1: Data?
    @NSManaged public var image2: Data?
    @NSManaged public var text: String?

}

extension SampleData{
    public var wrappedDate:Date {date ?? Date()}
    public var wrappedId:UUID {id ?? UUID()}
    public var wrappedImg1:Data {image1 ?? Data.init(capacity: 0)}
    public var wrappedImg2:Data {image2 ?? Data.init(capacity: 0)}
    public var wrappedText:String {text ?? ""}
}

extension SampleData : Identifiable {

}
