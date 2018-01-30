//
//  main.swift
//  RelativeProportionalLayoutCalculator
//
//  Created by Benjamin Zeeman on 1/29/18.
//  Copyright © 2018 Zaapp Inc. All rights reserved.
//

import Foundation

let usageDescription = "Calculate the {Multiplier} value relative constraints in Interface Builder. \n\n This program assumes you have included the following constraints from the Subview to the Superview: \n\tCenter Horizontally\n\tCenter Vertically\n\tEqual Widths\n\tEqual Heights \n\n Usage: \n\tQuick Calculation: rplc [SuperView Width] [SuperView Height] [View X] [View Y] [View Width] [View Height] \n\n Multiple Calculations: rplc [SuperView Width] [SuperView Height] \n\tthen:\n\t  [View X] [View Y] [View Width] [View Height] or Press Enter to Exit\n"

func writeToStdOut(str: String) {
    let handle = FileHandle.standardOutput
    if let data = str.data(using: String.Encoding.utf8) {
        handle.write(data)
    }
}

let args = CommandLine.arguments
let argc = CommandLine.argc

if(argc != 3 && argc != 7)
{
    writeToStdOut(str: usageDescription)
    exit(EXIT_FAILURE)
}
else{
    let _ = TheCalculator(args: args)
}



