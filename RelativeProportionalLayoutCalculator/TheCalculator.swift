//
//  TheCalculator.swift
//  RelativeProportionalLayoutCalculator
//
//  Created by Benjamin Zeeman on 1/29/18.
//  Copyright © 2018 Zaapp Inc. All rights reserved.
//

import Foundation

class TheCalculator {

    struct hitBox {
        var x: Double!
        var y: Double!
        var width: Double!
        var height: Double!
    }
    let superViewWidth: Double
    let superViewHeight: Double

    init(args: [String])
    {
        for aStr in args
        {
            guard let _ = Double(aStr) else {
                writeToStdOut(str: usageDescription)
                exit(EXIT_FAILURE)
            }
        }
        superViewWidth = Double(args[1])!
        superViewHeight = Double(args[2])!

        if args.count  == 3 {
            multiCalc()
        }
        else
        {
            let aHitbox = hitBox(x: Double(args[3]), y: Double(args[4]), width: Double(args[5]), height: Double(args[6]))
            calculateValuesForBox(aBox: aHitbox)
        }
    }


    func calculateValuesForBox(aBox: hitBox){
        var centerXString: String?
        var centerYString: String?
        var propWidthString: String?
        var propHeightString: String?

        let superCenterX = superViewWidth / 2.0
        let superCenterY = superViewHeight / 2.0

        let centerX = aBox.width / 2.0  + aBox.x
        let centerY = aBox.height / 2.0 + aBox.y

        centerXString = String(format: "%.1f:%.1f", arguments: [centerX, superCenterX])
        centerYString = String(format: "%.1f:%.1f", arguments: [centerY, superCenterY])

        propWidthString = String(format: "%.1f:%.1f", arguments: [aBox.width, superViewWidth])
        propHeightString = String(format: "%.1f:%.1f", arguments: [aBox.height, superViewHeight])
        let result = String(format: " Center X: %@ \n Center Y: %@ \n Prop Width: %@ \n Prop Height: %@ \n", arguments: [centerXString!, centerYString!, propWidthString!, propHeightString!])

        writeToStdOut(str: result)
    }
    func multiCalc(){

        writeToStdOut(str: "\n\nPlease enter 4 values:\n")
        let response = readLine()
        if response?.count == 0 {
            exit(EXIT_SUCCESS)
        }
        else{
            guard let newArgs = response?.components(separatedBy: " ")
                else
            {
                writeToStdOut(str: usageDescription)
                exit(EXIT_FAILURE)
            }

            for aSub in newArgs{
                if Double(aSub) == nil{
                    writeToStdOut(str: usageDescription)
                    multiCalc()
                }
            }

            if(newArgs.count != 4)
            {
                writeToStdOut(str: usageDescription)
                multiCalc()
            }

            let additionalHitBox = hitBox(x: Double(newArgs[0])!, y: Double(newArgs[1])!, width: Double(newArgs[2])!, height: Double(newArgs[3])!)
            calculateValuesForBox(aBox: additionalHitBox)
            multiCalc()

        }
    }
}
