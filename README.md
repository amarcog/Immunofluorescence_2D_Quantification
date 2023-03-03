# Immunofluorescence 2D Quantification

Drag and drop your image (composite of 4 channels) and the macro _4ch-2D-quantification.ijm_ in Fiji-imagej. Then fill the macro in the macro interpreter by following instructions in green and press run.

![Set-up](Input_Set-up.PNG)

After following macro instructions (pop-up windows),  the final output will be:

![Output](Output.PNG)

Resulting files will be stored in the output path (output folder) that you introduced in the macro interpreter:

![Output Files](Output_files.PNG)

Use the "Parsing_Results.py" script by using a python interpreter to merge data from multiple csv files into a simple excel (.xlsx) file.

Use the "Custom_Projection.ijm" ImageJ macro to project Z-stacks prior 2D quantification. Chose the kind of projection you want to use for each channel.

Use the "Test_all_Auto-Threshold-Methods.ijm" to try all possible Autothreshold Methods of ImageJ (similar to try all command).
