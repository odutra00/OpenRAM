Due to NDA restrictions, only tech_NDA.py was commited.
Rename the file to tech.py and change the layers names, number and purposes.

Search for:

- NAME_LAYER_YOUR_PDK
- LAYER_YOUR_PDK, PURPOSE_YOUR_PDK
- RULE_YOUR_PDK

and change the values accordingly.

If needed, also change the DRC rules values, whoose have been changed to ficticious values.

Although if used full custom cells for:
- nand2
- and2
- and3
- inv
- dff
- cell_1rw
- dummy_cell_1rw
- replica_cell_1rw
- sense_amp
- write_driver
- precharge

And having the technology/tsmc65N/custom folder with overriding classes as this projecty, and following the flow 
properly (readme README.md), those values should not be utilized. Although they might exist in order to OpenRAM
execute its own flow properly.

