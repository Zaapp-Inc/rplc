# rplc
Calculate the {Multiplier} value for relative constraints in Interface Builder.

This program assumes you have included the following constraints from the Subview to the Superview: 
  Center Horizontally
  Center Vertically
  Equal Widths
  Equal Heights
  
  # Usage: 
    Quick Calculation: 
      rplc [SuperView Width] [SuperView Height] [View X] [View Y] [View Width] [View Height] 
    
    Multiple Calculations: 
    rplc [SuperView Width] [SuperView Height] 
      then:
      [View X] [View Y] [View Width] [View Height] or Press Enter to Exit
