//
//  StepUpWidgetBundle.swift
//  StepUpWidget
//
//  Created by Paul Solt on 12/19/24.
//

import WidgetKit
import SwiftUI

@main
struct StepUpWidgetBundle: WidgetBundle {
    var body: some Widget {
        StepUpWidget()
        StepUpWidgetControl()
        StepUpWidgetLiveActivity()
    }
}
