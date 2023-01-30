//Set your output folder

output = "F:/Transfer_to_HIVE_118TB/Andres/CARDIO-Project/C240522-d27-Sections/COMBO1/Result-SumIP/" 

//Set your file extension. Input ".tif"

Extension = ".tif"

//Set markers name for each channel

markerCh1_name = "DAPI";
markerCh2_name = "MYH6_GFP";
markerCh3_name = "ASA";
markerCh4_name = "LAMININ";

//Set colours of your channels (Entry values should be as "Grays", "Red", "Green", "Blue", "Cyan", "Magenta", "Yellow")

Color_ch1 = "Blue";
Color_ch2= "Green";
Color_ch3= "Red";
Color_ch4= "Grays";

//Set threshold parameters:

//Automatic or intensity based?? Inputs: "Auto", "Intensity based"

Threshold_method = "Auto";

//If "Auto", set Automatic thresholding method for each channel
//Inputs: "Default", "Huang","Intermodes", "IsoData", "IJ_IsoData", "Li", "MaxEntropy", "Mean"
//"MinError", "Minimum", "Moments", "Otsu", "Percentile", "RenyiEntropy", "Shanbhag", "Triangle", "Yen"

Auto_thres_met_ch1 = "Huang";
Auto_thres_met_ch2 = "Default";
Auto_thres_met_ch3 = "Otsu";
Auto_thres_met_ch4 = "Otsu";

//If "Intensity based", set grey intensity values used fot thresholding. 
//Input: newArray(min,max); 
// min should be the "Number of your minimum grey intensity value"
// max should be the "Number of your maximum grey intensity value"
 
Thres_values_ch1 = newArray("0","4095");
Thres_values_ch1 = newArray("0","4095");
Thres_values_ch1 = newArray("0","4095");
Thres_values_ch1 = newArray("0","4095");

//Set scale

Scale = "200";

//Set what you want to measure

run("Set Measurements...", "area mean integrated display redirect=None decimal=3");

//From now on the script will run w/o changes
//Only if it is requigrays, command lines related with adjustment 
//of brightness/contrast and filtering could be added

title = getTitle();
titlewoext = replace(title, Extension, "");

//Fiji identifiers for each channel

markerA_ch = "C1-" + title;
markerB_ch = "C2-" + title;
markerC_ch = "C3-" + title;
markerD_ch = "C4-" + title;

//Break for image proccessing (Background filtering)

run("Split Channels");
run("Tile");

//Save images as used for further quantification (Important for labeling)

selectWindow(""+markerA_ch+""); saveAs("Tiff", ""+output+""+titlewoext+"_"+markerCh1_name+".tif"); run(Color_ch1);
selectWindow(""+markerB_ch+""); saveAs("Tiff", ""+output+""+titlewoext+"_"+markerCh2_name+".tif"); run(Color_ch2); 
selectWindow(""+markerC_ch+""); saveAs("Tiff", ""+output+""+titlewoext+"_"+markerCh3_name+".tif"); run(Color_ch3);
selectWindow(""+markerD_ch+""); saveAs("Tiff", ""+output+""+titlewoext+"_"+markerCh4_name+".tif"); run(Color_ch4); 

//Generate merges c1=red, c2=green, c3=blue, c4=greys, c5=cyan, c6=magenta, c7=yellow.

run("Merge Channels...", "c4=["+titlewoext+"_"+markerCh4_name+".tif] c1=["+titlewoext+"_"+markerCh3_name+".tif] c3=["+titlewoext+"_"+markerCh1_name+".tif] c2=["+titlewoext+"_"+markerCh2_name+".tif] keep create");
saveAs("Tiff", ""+output+""+titlewoext+"_Composite.tif");
selectWindow(""+titlewoext+"_Composite.tif");run("RGB Color");selectWindow(""+titlewoext+"_Composite.tif (RGB)"); saveAs("Tiff", ""+output+""+titlewoext+"_Mergedapi_raw.tif");

//Set scale in Mergedapi

selectWindow(""+titlewoext+"_Mergedapi_raw.tif"); height=getHeight;
run("Scale Bar...", "width="+Scale+" height="+height*0.02+" font=29 color=White background=None location=[Lower Right] hide");
saveAs("Tiff", ""+output+""+titlewoext+"_Mergedapiscale_raw.tif");

run("Tile");

//Create Masks Selection with Autothreshold mesaure and save a 8 bit image from the mask.

if (Threshold_method == "Auto") {

selectWindow(""+titlewoext+"_"+markerCh1_name+".tif") ;getMinAndMax(min_ch1_i, max_ch1); run("Duplicate...", ""+titlewoext+"_"+markerCh1_name+"-1.tif"); selectWindow(""+titlewoext+"_"+markerCh1_name+"-1.tif");
setAutoThreshold(Auto_thres_met_ch1+" dark");waitForUser("Readjust threshold manually if needed");run("Create Selection");resetThreshold();
run("Measure");getMinAndMax(min_ch1, max_ch1);
run("Create Mask");selectWindow("Mask"); run(Color_ch1); run("RGB Color");
saveAs("Tiff", ""+output+""+titlewoext+"_"+markerCh1_name+"-Mask.tif");

selectWindow(""+titlewoext+"_"+markerCh2_name+".tif");getMinAndMax(min_ch2_i, max_ch1); run("Duplicate...", ""+titlewoext+"_"+markerCh2_name+"-1.tif"); selectWindow(""+titlewoext+"_"+markerCh2_name+"-1.tif");
setAutoThreshold(Auto_thres_met_ch2+" dark");waitForUser("Readjust threshold manually if needed");run("Create Selection");resetThreshold();
run("Measure");getMinAndMax(min_ch2, max_ch2);
run("Create Mask");selectWindow("Mask"); run(Color_ch2); run("RGB Color");
saveAs("Tiff", ""+output+""+titlewoext+"_"+markerCh2_name+"-Mask.tif");

selectWindow(""+titlewoext+"_"+markerCh3_name+".tif"); getMinAndMax(min_ch3_i, max_ch1); run("Duplicate...", ""+titlewoext+"_"+markerCh3_name+"-1.tif"); selectWindow(""+titlewoext+"_"+markerCh3_name+"-1.tif");
setAutoThreshold(Auto_thres_met_ch3+" dark");waitForUser("Readjust threshold manually if needed");run("Create Selection");resetThreshold();
run("Measure");getMinAndMax(min_ch3, max_ch3);
run("Create Mask");selectWindow("Mask"); run(Color_ch3); run("RGB Color");
saveAs("Tiff", ""+output+""+titlewoext+"_"+markerCh3_name+"-Mask.tif");

selectWindow(""+titlewoext+"_"+markerCh4_name+".tif");getMinAndMax(min_ch4_i, max_ch1); run("Duplicate...", ""+titlewoext+"_"+markerCh4_name+"-1.tif"); selectWindow(""+titlewoext+"_"+markerCh4_name+"-1.tif");
setAutoThreshold(Auto_thres_met_ch4+" dark");waitForUser("Readjust threshold manually if needed");run("Create Selection");resetThreshold();
run("Measure");getMinAndMax(min_ch4, max_ch4);
run("Create Mask");selectWindow("Mask"); run(Color_ch4); run("RGB Color");
saveAs("Tiff", ""+output+""+titlewoext+"_"+markerCh4_name+"-Mask.tif");

} else if (Threshold_method == "Intensity based") {
	
selectWindow(""+titlewoext+"_"+markerCh1_name+".tif"); getMinAndMax(min_ch1_i, max_ch1); run("Duplicate...", ""+titlewoext+"_"+markerCh1_name+"-1.tif"); selectWindow(""+titlewoext+"_"+markerCh1_name+"-1.tif");
setThreshold(Thres_values_ch1[0], Thres_values_ch1[1]);waitForUser("Readjust threshold manually if needed");run("Create Selection");resetThreshold();
run("Measure");getMinAndMax(min_ch1, max_ch1);
run("Create Mask");selectWindow("Mask"); run(Color_ch1); run("RGB Color");
saveAs("Tiff", ""+output+""+titlewoext+"_"+markerCh1_name+"-Mask.tif");

selectWindow(""+titlewoext+"_"+markerCh2_name+".tif"); getMinAndMax(min_ch2_i, max_ch1); run("Duplicate...", ""+titlewoext+"_"+markerCh2_name+"-1.tif"); selectWindow(""+titlewoext+"_"+markerCh2_name+"-1.tif");
setThreshold(Thres_values_ch2[0], Thres_values_ch2[1]);waitForUser("Readjust threshold manually if needed");run("Create Selection");resetThreshold();
run("Measure");getMinAndMax(min_ch2, max_ch2);
run("Create Mask");selectWindow("Mask"); run(Color_ch2); run("RGB Color");
saveAs("Tiff", ""+output+""+titlewoext+"_"+markerCh2_name+"-Mask.tif");

selectWindow(""+titlewoext+"_"+markerCh3_name+".tif"); getMinAndMax(min_ch3_i, max_ch1); run("Duplicate...", ""+titlewoext+"_"+markerCh3_name+"-1.tif"); selectWindow(""+titlewoext+"_"+markerCh3_name+"-1.tif");
setThreshold(Thres_values_ch3[0], Thres_values_ch3[1]);waitForUser("Readjust threshold manually if needed");run("Create Selection");resetThreshold();
run("Measure");getMinAndMax(min_ch3, max_ch3);
run("Create Mask");selectWindow("Mask"); run(Color_ch3); run("RGB Color");
saveAs("Tiff", ""+output+""+titlewoext+"_"+markerCh3_name+"-Mask.tif");

selectWindow(""+titlewoext+"_"+markerCh4_name+".tif"); getMinAndMax(min_ch4_i, max_ch1);run("Duplicate...", ""+titlewoext+"_"+markerCh4_name+"-1.tif"); selectWindow(""+titlewoext+"_"+markerCh4_name+"-1.tif");
setThreshold(Thres_values_ch4[0], Thres_values_ch4[1]);waitForUser("Readjust threshold manually if needed");run("Create Selection");resetThreshold();
run("Measure");getMinAndMax(min_ch4, max_ch4);
run("Create Mask");selectWindow("Mask"); run(Color_ch4); run("RGB Color");
saveAs("Tiff", ""+output+""+titlewoext+"_"+markerCh4_name+"-Mask.tif");
	
} else {
	print("Please check your input for threshold method");
}

//Export results as .csv files

saveAs("Results", ""+output+""+titlewoext+".csv"); //run("Clear Results");

//Adjust colors as quantified, generate the adjusted merge and then convert adjusted colors to rgb

selectWindow(""+titlewoext+"_"+markerCh1_name+".tif"); run(Color_ch1); setMinAndMax(min_ch1_i, (min_ch1+((max_ch1-min_ch1)*0.3)));
selectWindow(""+titlewoext+"_"+markerCh2_name+".tif"); run(Color_ch2); setMinAndMax(min_ch2_i, (min_ch2+((max_ch2-min_ch2)*0.3)));
selectWindow(""+titlewoext+"_"+markerCh3_name+".tif"); run(Color_ch3); setMinAndMax(min_ch3_i, (min_ch3+((max_ch3-min_ch3)*0.3))); 
selectWindow(""+titlewoext+"_"+markerCh4_name+".tif"); run(Color_ch4); setMinAndMax(min_ch4_i, (min_ch4+((max_ch4-min_ch4)*0.3))); 

run("Merge Channels...", "c4=["+titlewoext+"_"+markerCh4_name+".tif] c1=["+titlewoext+"_"+markerCh3_name+".tif] c3=["+titlewoext+"_"+markerCh1_name+".tif] c2=["+titlewoext+"_"+markerCh2_name+".tif] keep create");
run("RGB Color");saveAs("Tiff", ""+output+""+titlewoext+"_Mergedapi_adj.tif");

selectWindow(""+titlewoext+"_"+markerCh1_name+".tif"); run("RGB Color");
selectWindow(""+titlewoext+"_"+markerCh2_name+".tif"); run("RGB Color");
selectWindow(""+titlewoext+"_"+markerCh3_name+".tif"); run("RGB Color");
selectWindow(""+titlewoext+"_"+markerCh4_name+".tif"); run("RGB Color");

//Set scale in Mergedapi

selectWindow(""+titlewoext+"_Mergedapi_adj.tif"); height=getHeight;
run("Scale Bar...", "width="+Scale+" height="+height*0.02+" font=29 color=White background=None location=[Lower Right] hide");
saveAs("Tiff", ""+output+""+titlewoext+"_Mergedapi_adj_scale.tif");

run("Tile");

run("Concatenate...", "  title=[Stack] image1=["+titlewoext+"_"+markerCh1_name+".tif] image2=["+titlewoext+"_"+markerCh2_name+".tif] image3=["+titlewoext+"_"+markerCh3_name+".tif] image4=["+titlewoext+"_"+markerCh4_name+".tif] image5=["+titlewoext+"_Mergedapi_adj_scale.tif]");
run("Make Montage...", "columns=5 rows=1 scale=1 first=1 last=5");
selectWindow("Montage");run("RGB Color");saveAs("Tiff", ""+output+""+titlewoext+"_Montage_colors.tif");
close("Stack");

//   Make montage Mask

run("Concatenate...", "  title=[Stack] image1=["+titlewoext+"_"+markerCh1_name+"-Mask.tif] image2=["+titlewoext+"_"+markerCh2_name+"-Mask.tif] image3=["+titlewoext+"_"+markerCh3_name+"-Mask.tif] image4=["+titlewoext+"_"+markerCh4_name+"-Mask.tif]");
selectWindow("Stack");run("Make Montage...", "columns=4 rows=1 scale=1 first=1 last=4");
selectWindow("Montage");
saveAs("Tiff", ""+output+""+titlewoext+"_Montage-Masks.tif");

