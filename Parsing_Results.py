#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Mar 19 21:06:13 2021

@author: andresmg
"""

import pandas as pd
from glob import glob
import os

#Fill with your output folder:

os.chdir("/PATH/TO/YOUR/FOLDER")

#Fill with your experiment name

name_exp = "COMBO1";

#Fill with the marker names (Same order as in the macro for Imagej)

markerA_name = "DAPI"
markerB_name = "WT1"
markerC_name = "ACE2"
markerD_name = "LTL"

#From now on, don't modify the script.

files=sorted(glob("*.csv"))

#Obtain names of the files without extension

files_clean = []

for i in range(0,len(files)):
    
    files_clean.append(files[i].replace(".csv", ""))


#Generate a DataFrame list with the csv files

dflist = []

for i in range(0,len(files)):

    dflist.append(pd.read_csv(files[i]))

#Extract Integrated Densties for each file from csv data

Photo_name = []

A_Area = []
B_Area = []
C_Area = []
D_Area = []

A_Mean = []
B_Mean = []
C_Mean = []
D_Mean = []

A_IntD = []
B_IntD = []
C_IntD = []
D_IntD = []

A_RawIntD = []
B_RawIntD = []
C_RawIntD = []
D_RawIntD = []

for i in range(0,len(dflist)):

    Photo_name.append(files_clean[i])
    
    A_Area.append(dflist[i].Area[0])
    B_Area.append(dflist[i].Area[1])
    C_Area.append(dflist[i].Area[2])
    D_Area.append(dflist[i].Area[3])

    A_Mean.append(dflist[i].Mean[0])
    B_Mean.append(dflist[i].Mean[1])
    C_Mean.append(dflist[i].Mean[2])
    D_Mean.append(dflist[i].Mean[3])

    A_IntD.append(dflist[i].IntDen[0])
    B_IntD.append(dflist[i].IntDen[1])
    C_IntD.append(dflist[i].IntDen[2])
    D_IntD.append(dflist[i].IntDen[3])
    
    A_RawIntD.append(dflist[i].RawIntDen[0])
    B_RawIntD.append(dflist[i].RawIntDen[1])
    C_RawIntD.append(dflist[i].RawIntDen[2])
    D_RawIntD.append(dflist[i].RawIntDen[3])

    
df = pd.DataFrame({'Photo_name': Photo_name,\
            ''+markerA_name+'_Area': A_Area,\
            ''+markerB_name+'_Area': B_Area,\
            ''+markerC_name+'_Area': C_Area,\
            ''+markerD_name+'_Area': D_Area,\
                
            ''+markerA_name+'_Mean': A_Mean,\
            ''+markerB_name+'_Mean': B_Mean,\
            ''+markerC_name+'_Mean': C_Mean,\
            ''+markerD_name+'_Mean': D_Mean,\
                
            ''+markerA_name+'_IntD': A_IntD,\
            ''+markerB_name+'_IntD': B_IntD,\
            ''+markerC_name+'_IntD': C_IntD,\
            ''+markerD_name+'_IntD': D_IntD,\
                
            ''+markerA_name+'_RawIntD': A_RawIntD,\
            ''+markerB_name+'_RawIntD': B_RawIntD,\
            ''+markerC_name+'_RawIntD': C_RawIntD,\
            ''+markerD_name+'_RawIntD': D_RawIntD})

final_df = df.sort_values(['Photo_name'])

os.chdir('..')
    
final_df.to_excel(name_exp+".xlsx", index=False)


