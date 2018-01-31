//
//  ViewController.swift
//  iNPLC
//
//  Created by Benjamin Zeeman on 1/30/18.
//  Copyright © 2018 Zaapp Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate, UITextFieldDelegate {

    struct hitBox
    {
        var x: Double!
        var y: Double!
        var width: Double!
        var height: Double!
    }

    @IBOutlet weak var dasScroller: UIScrollView!
    private var activeTextField: UITextField? = nil
    private var successfullCompute = false

    @IBOutlet weak var svWidthField: UITextField!
    @IBOutlet weak var svHeightField: UITextField!
    @IBOutlet weak var subXField: UITextField!
    @IBOutlet weak var subYField: UITextField!
    @IBOutlet weak var subWField: UITextField!
    @IBOutlet weak var subHField: UITextField!
    @IBOutlet weak var chButton: UIButton!
    @IBOutlet weak var cvButton: UIButton!
    @IBOutlet weak var pwButton: UIButton!
    @IBOutlet weak var phButton: UIButton!
    @IBOutlet var superViewFields: [UITextField]!
    @IBOutlet var subViewFields: [UITextField]!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(not:)), name: Notification.Name.UIKeyboardWillShow, object: nil)

        }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        activeTextField = textField

        var isClean = true
        for aField in subViewFields
        {
            guard let charCount = aField.text?.count else
            {
                isClean = false
                continue
            }
            if charCount > 0
            {
                isClean = false
            }
        }
        if isClean {
            //wipe out the buttons and clear their value

            chButton.setTitle("No Value", for: .normal)
            chButton.isEnabled = false
            cvButton.setTitle("No Value", for: .normal)
            cvButton.isEnabled = false
            pwButton.setTitle("No Value", for: .normal)
            pwButton.isEnabled = false
            phButton.setTitle("No Value", for: .normal)
            phButton.isEnabled = false

            for aField in subViewFields
            {
                aField.placeholder = "No Value"
            }
        }



        return true;
    }
    func textFieldDidEndEditing(_ textField: UITextField){
        textField.resignFirstResponder()
        activeTextField = nil

        successfullCompute = computeIfValid()

        if successfullCompute{
            for aField in subViewFields
            {
                let text = aField.text!
                aField.placeholder = text
                aField.text = nil
            }
        }
        //return true;
    }
    @objc func keyboardWillShow(not: Notification)
    {
        let uInfo = Dictionary<AnyHashable, Any>?(not.userInfo!)
        let keyFrame = uInfo![UIKeyboardFrameEndUserInfoKey] as! CGRect
        let aSender = activeTextField
        let senderCords = self.view?.convert(aSender!.frame, from: aSender?.superview)
        let aDuration = uInfo![UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        if keyFrame.contains(senderCords!)
        {
            let bottomEdge = senderCords?.maxY
            let topEdge = keyFrame.minY

            let yOffset = bottomEdge! - topEdge

            UIView.animate(withDuration: aDuration, animations: {

            })
            dasScroller.contentOffset = CGPoint(x: 0.0, y: yOffset)
        }
    }
    @IBAction func buttonPressed(_ sender: UIButton) {
        //copy coresponding text to clip board
        let text = sender.title(for: .normal)
        UIPasteboard.general.string = text
        let messString = String(format: "%@ \n coppied to clipboard!", text!)

        let ac = UIAlertController(title: "Copied!", message: messString, preferredStyle: UIAlertControllerStyle.alert)
        present(ac, animated: true, completion: nil)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.dismiss(animated: true, completion: nil)
        }

    }


    func computeIfValid() -> Bool
    {
        var success = true
        for aField in superViewFields
        {
            guard let charCount = aField.text?.count else
            {
                success = false
                return success;
            }
            if charCount == 0
            {
                success = false
                return success;
            }

        }
        for aField in subViewFields
        {
            guard let charCount = aField.text?.count else
            {
                success = false
                return success;
            }
            if charCount == 0
            {
                success = false
                return success;
            }
        }
        //we got here so lets gitter Done

        let aHitBox = hitBox(x: Double(subXField.text!), y: Double(subYField.text!), width: Double(subWField.text!), height: Double(subHField.text!))
        calculateValuesForBox(aBox: aHitBox)

        return true

    }
    func calculateValuesForBox(aBox: hitBox) {

        let superViewWidth = Double(svWidthField.text!)!
        let superViewHeight = Double(svHeightField.text!)!
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

        chButton.setTitle(centerXString, for: .normal)
        chButton.isEnabled = true
        cvButton.setTitle(centerYString, for: .normal)
        cvButton.isEnabled = true
        pwButton.setTitle(propWidthString, for: .normal)
        pwButton.isEnabled = true
        phButton.setTitle(propHeightString, for: .normal)
        phButton.isEnabled = true

        //writeToStdOut(str: result)
    }

    @IBAction func tappedOutside(_ sender: Any)
    {
        for aField in superViewFields
        {
            if aField.isFirstResponder
            {
                aField.resignFirstResponder()
            }
        }
        for aField in subViewFields
        {
            if aField.isFirstResponder
            {
                aField.resignFirstResponder()
            }
        }
    }
}

