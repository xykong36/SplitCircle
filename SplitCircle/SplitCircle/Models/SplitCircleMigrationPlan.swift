//
//  SplitCircleMigrationPlan.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 6/9/24.
//

import Foundation
import SwiftData

enum SplitCircleMigrationPlan: SchemaMigrationPlan {
    static var stages: [MigrationStage] {
        [migrateV1toV2]
    }
    
    static var schemas: [any VersionedSchema.Type] {
        [SplitCircleSchemaV1.self, SplitCircleSchemaV2.self]
    }

    static let migrateV1toV2 = MigrationStage.custom(fromVersion: SplitCircleSchemaV1.self, toVersion: SplitCircleSchemaV2.self, willMigrate: { context in
        // Fetch existing MemberGroup entities from the ModelContext
        let existingMemberGroups = try context.fetch(FetchDescriptor<SplitCircleSchemaV1.MemberGroup>())

        // Iterate through the existing MemberGroup entities and delete them
        for memberGroup in existingMemberGroups {
            context.delete(memberGroup)
        }

        // Save the changes made to the ModelContext
        try context.save()
    }, didMigrate: nil)
    
}


