//Set the directory where your raw Z-stacks are stored.

directory = "/Volumes/Public/2023 FOR ANDRES from ElenaG/20230123_exp190822_SIZES d20/RAW/"

//Set Projection (Types: "Max Intensity", "Average Intensity", "Min Intensity", "Sum Slices", "Median", "Standard Deviation")

Pro_type_ch1 = "Sum Slices";
Pro_type_ch2 = "Max Intensity";
Pro_type_ch3 = "Max Intensity";
Pro_type_ch4 = "Sum Slices";

//Set the extension of your files

extension = ".nd2";

//Don't modify the script, it will run automatically

//setBatchMode(true);

filelist = getFileList(directory);

Photo_name = newArray();
area_results = newArray();

for (i = 0; i < (lengthOf(filelist)); i++) {

//Open files

if (endsWith(filelist[i], extension)) {
open(directory + File.separator + filelist[i]);filename1 = getTitle();}

title = getTitle();titlewoext = replace(title, extension, "");

run("Split Channels");

//Set names of the channels

FIJI_ch1_ID = "C1-" + title; 
FIJI_ch2_ID = "C2-" + title; 
FIJI_ch3_ID = "C3-" + title; 
FIJI_ch4_ID = "C4-" + title; 

selectWindow(FIJI_ch1_ID);run("Z Project...", " projection=["+Pro_type_ch1+"]");close(FIJI_ch1_ID);
selectWindow(FIJI_ch2_ID);run("Z Project...", " projection=["+Pro_type_ch2+"]");close(FIJI_ch2_ID);
selectWindow(FIJI_ch3_ID);run("Z Project...", " projection=["+Pro_type_ch3+"]");close(FIJI_ch3_ID);
selectWindow(FIJI_ch4_ID);run("Z Project...", " projection=["+Pro_type_ch4+"]");close(FIJI_ch4_ID);

function FIJI_ID_after_projection(FIJI_ch_ID,Pro_type_ch) {

	if (Pro_type_ch == "Max Intensity") {
		ID_after_projection = "MAX_" + FIJI_ch_ID;
	} else if (Pro_type_ch == "Sum Slices") {
		ID_after_projection = "SUM_" + FIJI_ch_ID;
	} else if (Pro_type_ch == "Average Intensity") {
		ID_after_projection = "AVG_" + FIJI_ch_ID;
	} else if (Pro_type_ch == "Min Intensity") {
		ID_after_projection = "MIN_" + FIJI_ch_ID;
	} else if (Pro_type_ch == "Median") {
		ID_after_projection = "MED_" + FIJI_ch_ID;
	} else if (Pro_type_ch == "Standard Deviation") {
		ID_after_projection = "STD_" +FIJI_ch_ID;
	} 

	return ID_after_projection;
	}

//Rename after projections

FIJI_ch1_ID = FIJI_ID_after_projection(FIJI_ch1_ID,Pro_type_ch1);
FIJI_ch2_ID = FIJI_ID_after_projection(FIJI_ch2_ID,Pro_type_ch2);
FIJI_ch3_ID = FIJI_ID_after_projection(FIJI_ch3_ID,Pro_type_ch3);
FIJI_ch4_ID = FIJI_ID_after_projection(FIJI_ch4_ID,Pro_type_ch4);

//Homogenize grey scales

if ((Pro_type_ch1 == Pro_type_ch2) & (Pro_type_ch1 == Pro_type_ch3) & (Pro_type_ch1== Pro_type_ch4)) { 
	run("Select None"); 
	} else {
		selectWindow(FIJI_ch1_ID);run("32-bit");
		selectWindow(FIJI_ch2_ID);run("32-bit");
		selectWindow(FIJI_ch3_ID);run("32-bit");
		selectWindow(FIJI_ch4_ID);run("32-bit");
		}

//Get abreviations of projection types

function Projection_Abreviation(Pro_type_ch) {

	if (Pro_type_ch == "Max Intensity") {
		Ab_after_projection = "MAX";
	} else if (Pro_type_ch == "Sum Slices") {
		Ab_after_projection = "SUM";
	} else if (Pro_type_ch == "Average Intensity") {
		Ab_after_projection = "AVG";
	} else if (Pro_type_ch == "Min Intensity") {
		Ab_after_projection = "MIN";
	} else if (Pro_type_ch == "Median") {
		Ab_after_projection = "MED";
	} else if (Pro_type_ch == "Standard Deviation") {
		Ab_after_projection = "STD";
	} 

	return Ab_after_projection;
	}
	
Summary_ch1 = "C1-"+Projection_Abreviation(Pro_type_ch1)+"_";
Summary_ch2 = "C2-"+Projection_Abreviation(Pro_type_ch2)+"_";
Summary_ch3 = "C3-"+Projection_Abreviation(Pro_type_ch3)+"_";
Summary_ch4 = "C4-"+Projection_Abreviation(Pro_type_ch4);

//Create composite and save:

run("Merge Channels...", "c1=["+FIJI_ch1_ID+"] c2=["+FIJI_ch2_ID+"] c3=["+FIJI_ch3_ID+"] c4=["+FIJI_ch4_ID+"] keep create");

saveAs("Tiff", directory + titlewoext+"-"+Summary_ch1+Summary_ch2+Summary_ch3+Summary_ch4+".tif");
close("*");
}