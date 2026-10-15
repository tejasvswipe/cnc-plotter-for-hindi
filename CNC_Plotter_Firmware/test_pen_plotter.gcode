; CNC plotter first-motion test
; Run with pen lifted and no paper first.
G21         ; millimetres
G90         ; absolute positioning
G94         ; feed per minute
G0 Z5       ; pen up: Z > 0
G0 X10 Y10
G1 X40 Y10 F300
G1 X40 Y40
G1 X10 Y40
G1 X10 Y10
G0 Z5
G0 X0 Y0

; Servo test: lower then raise without moving XY
G1 Z0 F100
G4 P0.5
G1 Z5 F100
