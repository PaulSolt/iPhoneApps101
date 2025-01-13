//
//  StepCounterWidgetBundle.swift
//  StepCounterWidget
//
//  Created by Paul Solt on 1/11/25.
//

import WidgetKit
import SwiftUI

@main
struct StepCounterWidgetBundle: WidgetBundle {
    var body: some Widget {
        StepCounterWidget()
        StepCounterWidgetControl()
        StepCounterWidgetLiveActivity()
    }
}
