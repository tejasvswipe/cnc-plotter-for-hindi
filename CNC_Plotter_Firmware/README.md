# CNC Plotter Firmware Package

This package is prepared for the reference build from [CNC Plotter — 3D Printed Mostly](https://www.instructables.com/CNC-Plotter-3D-Printed-Mostly/).

It uses the reference author's recommended **Grbl_Pen_Servo** firmware for:

- Arduino Uno / ATmega328P
- CNC Shield V3
- Three A4988 stepper drivers
- Three NEMA 17 stepper motors
- X and Y limit switches, plus optional Z limit input
- SG90 servo for pen up/down
- Universal G-code Sender or another GRBL sender at 115200 baud

The servo behavior is integrated into the modified GRBL source: **Z > 0 lifts the pen; Z <= 0 lowers the pen**.

## Files

- `source/grbl/` — downloaded pen-servo GRBL library source.
- `arduino/GrblUpload/GrblUpload.ino` — Arduino IDE upload sketch.
- `plotter_settings.txt` — settings to send after flashing.
- `pinout_and_wiring.md` — CNC Shield V3 wiring and safety checks.
- `test_pen_plotter.gcode` — slow pen-up/pen-down test job.

## Upload procedure

1. Install Arduino IDE.
2. Copy the `source/grbl` folder into the Arduino libraries folder as `Grbl`.
3. Open `arduino/GrblUpload/GrblUpload.ino`.
4. Select **Arduino Uno** as the board and select the correct serial port.
5. Upload the sketch.
6. Connect a GRBL sender at **115200 baud**.
7. Send `$$` and save the returned settings before changing anything.
8. Send the commands in `plotter_settings.txt` one line at a time.
9. Power off before connecting or changing motors, A4988 drivers, or the servo.
10. Test axis direction and travel with the pen lifted before enabling a drawing job.

The package contains source code rather than a precompiled `.hex`, because the Arduino IDE compiles the GRBL library and produces the correct upload for the selected board.

## Reference calibration

The article reports 1/8 microstepping and T8 lead screws with a 2 mm pitch, giving:

`steps/mm = 200 steps/revolution × 8 microsteps ÷ 2 mm/revolution = 800 steps/mm`

The supplied settings start X and Y at 800 steps/mm. Confirm the actual lead-screw pitch and microstep jumpers before relying on this value. Calibrate by commanding 100 mm and measuring the actual travel.

The reference build reports 1000 mm/min maximum X/Y rate and approximately 201 mm travel. Start slower if the motors stall or lose steps.

## Pen servo adjustment

The source uses the CNC Shield/Arduino Uno hardware-PWM pin mapped to the pen-servo output. The default pulse values in `source/grbl/spindle_control.c` are:

- `PEN_SERVO_UP 16`
- `PEN_SERVO_DOWN 31`

If the pen travels in the wrong direction, swap the values. If the servo buzzes or reaches a hard stop, reduce the range immediately. Do not force the SG90 against its mechanical endpoint.

## Safety

This firmware controls moving motors. Keep fingers, cables, and tools clear during testing. Use a current-limited 12 V supply, correctly oriented A4988 drivers, suitable heatsinks, and a common ground. Never plug or unplug a stepper motor while the driver is powered.

The reference article connects X- to the support limit switch, Y- to the rear-leg limit switch, and the servo pulse/5 V/GND to the shield's corresponding connections. Verify the silkscreen on your specific CNC Shield V3 before wiring.

## License

The source is distributed under its included GPL license. The plotter settings, wiring notes, and test G-code are provided for this reference build.
