# STGIPS POWER BOARD

This power board is designed around the STMicro STGIPSxxC60T-H series of Intelligent Power Modules.

These modules are available with [10](http://www.st.com/content/st_com/en/products/power-modules/sllimm-intelligent-power-modules/stgips10c60t-h.html), [15](http://www.st.com/content/st_com/en/products/power-modules/sllimm-intelligent-power-modules/stgips15c60t-h.html), [20](http://www.st.com/content/st_com/en/products/power-modules/sllimm-intelligent-power-modules/stgips20c60t-h.html), or [30](http://www.st.com/content/st_com/en/products/power-modules/sllimm-intelligent-power-modules/stgips30c60t-h.html) amp ratings.

## Design Notes

STGIPS Footprint notes:

Power pins are 0.55mm nominal, 0.65mm max thick, by 1.00mm nominal, 1.15mm max wide.  Max diagonal is 1.321mm (0.052"), will fit well in a 1.55mm (0.061") hole.
Signal pins are 0.55mm nominal, 0.65mm max thick, by 0.50mm nominal, 0.65mm max wide.  Max diagonal is 0.919mm (0.036"), will fit well in a 1.15mm (0.045") hole.

Power pins are spaced 4.7mm nominal, 4.5mm minimum.  Hole placement on board is at nominal, but I will calculate spacings at minimum.  Clearance for functional spacing is 1.7mm, with 4.5mm centers that leaves a 2.8mm pad (0.110").  With a 1.55mm hole the annular ring is 0.625mm (0.024").

Signal pins are spaced 2.35mm nominal, 2.15mm minimum (low voltage) or 3.60mm nominal, 3.40mm minimum (high voltage).  Clearance for high voltage is 1.7mm, which with 3.4mm centers leaves a 1.7mm pad (0.067").  With a 1.15mm hole the annular ring is 0.275mm (0.0108").  Using the same 1.7mm pad at the low voltage spacing of 2.15mm miniimum leaves 0.45mm (0.017") clearance between pads.

Trace Width

The data sheet for the largest module implies that it could reach about 18A RMS output current at a module case temperature of 100 deg C and 15kHz switching frequency.  For 18A RMS, and 1oz or 2oz copper, this [Trace Width Calculator](http://www.4pcb.com/trace-width-calculator.html) gives the following trace widths:

| Temp Rise | 1oz Width | 2oz Width |
|---|---|---|
| 10 degC | 16.2mm (0.638") | 8.1mm (0.319") |
| 20 degC | 10.6mm (0.417") | 5.1mm (0.209") |
| 30 degC | 8.3mm (0.327") | 4.2mm (0.163") |
| 40 degc | 7.0mm (0.275") | 3.5mm (0.137") |

The pin spacing of the module limits the trace (at least near the pins) to 2.8mm.  So this is a problem if we really want to deliver 18A continuous.  The artwork should use the widest traces possible, possibly double-up layers in narrow runs, and use 10mil lines and spaces to allow for 2oz copper as an option.




