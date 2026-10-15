# Pinout and Wiring

## Arduino Uno / CNC Shield V3

The pen-servo source is compiled for the Arduino Uno ATmega328P map:

| Function | Arduino pin | CNC Shield V3 connection |
|---|---:|---|
| X step | D2 | X driver |
| Y step | D3 | Y driver |
| Z step | D4 | Z driver |
| X direction | D5 | X driver |
| Y direction | D6 | Y driver |
| Z direction | D7 | Z driver |
| Driver enable | D8 | Shared enable |
| X limit | D9 | X- / X limit input |
| Y limit | D10 | Y- / Y limit input |
| Pen servo pulse | D11 | Servo signal / shield Z- signal position as used by the reference wiring |
| Z limit input | D12 | Optional; do not use this for the servo signal |
| Servo ground | GND | Shield GND |
| Servo power | 5 V | Shield 5 V, only if the 5 V rail can supply the SG90 current |
| Serial | USB | GRBL sender at 115200 baud |

The reference article uses the X- and Y- inputs for two mechanical limit switches. It does not require a physical Z limit switch for the binary pen mechanism.

## Wiring sequence

1. Disconnect 12 V power and USB power.
2. Install the A4988 modules in the orientation marked by your CNC Shield. Do not rely on a generic photo; shield revisions vary.
3. Set the microstep jumpers. The reference uses 1/8 microstepping.
4. Connect the three stepper motors.
5. Connect X- and Y- limit switches to their input and GND pins.
6. Connect the SG90 signal, 5 V, and GND. If the servo resets the Arduino or causes noise, power it from a separate regulated 5 V supply with a common ground.
7. Connect the 12 V motor supply to the shield.
8. Connect USB and test with the motors unloaded before attaching the mechanism.

## Direction checks

With the pen raised, jog X and Y by 10 mm. If an axis travels opposite to the sender's positive direction, either reverse that motor connector only if the shield/motor connector wiring permits it, or invert the corresponding direction setting in GRBL using the `$3` direction mask.

Example direction masks:

- `$3=0` — no axis inversion
- `$3=1` — invert X
- `$3=2` — invert Y
- `$3=4` — invert Z
- Add masks for multiple axes, such as `$3=3` for X and Y.

## Limit-switch checks

Before enabling `$21=1` hard limits or `$22=1` homing, use the GRBL status report and manually press each switch. If the state is reversed, check the switch wiring and `$5`. The reference article uses `$5=1`, but your switch type and shield wiring may require a different value.
