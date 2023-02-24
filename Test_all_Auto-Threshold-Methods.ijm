// This macro allows the display of all possible segmentations using the
// different threshold algorithms that are implemented in Fiji-Imagej

filename = getTitle();
subStringArray = split(filename, ".");
extension = subStringArray[lengthOf(subStringArray)-1]
titlewoext = replace(filename, "."+extension, "");
Auto_methods = newArray("Default", "Huang", "Intermodes", "IsoData", "IJ_IsoData", "Li", "MaxEntropy", "Mean", "MinError", "Minimum","Moments", "Otsu", "Percentile", "RenyiEntropy", "Shanbhag", "Triangle", "Yen");

function apply_Auto() { 
	run("Duplicate...", titlewoext+"-1."+extension);setAutoThreshold(Auto_methods[i]+" dark");rename(Auto_methods[i]);
}

for (i = 0; i < lengthOf(Auto_methods); i++) {
	apply_Auto();
}

run("Tile");



