//
//  ScheduleModel.swift
//  Schedule
//
//  Created by Никита Козловский on 20.09.2024.
//

import UIKit
import RealmSwift

class ScheduleModel: Object {
    @Persisted var scheduleDate: Date?
    @Persisted var scheduleTime: Date?
    @Persisted var scheduleName: String = "Не выбрано"
    @Persisted var scheduleType: String = "Не выбрано"
    @Persisted var scheduleBuilding: String = "Не выбрано"
    @Persisted var scheduleAudience: String = "Не выбрано"
    @Persisted var scheduleTeacher: String = "Name Lastname"
    @Persisted var scheduleColor: String = "FFFFFF"
    @Persisted var scheduleRepeat: Bool = true
    @Persisted var scheduleWeekday: Int = 1
}
