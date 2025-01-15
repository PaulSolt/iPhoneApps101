//
//  StepCounterWidgetBundle.swift
//  StepCounterWidget
//
//  Created by Paul Solt on 1/13/25.
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
