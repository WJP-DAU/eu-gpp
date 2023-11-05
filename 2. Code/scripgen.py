import os
import sys
import re
import pandas as pd

#  Reading codebook
codebook = pd.read_excel("../0. Metadata/EU2 GPP 2023 Codebook.xlsx",
                         sheet_name = "Codebook")
datamap  = pd.read_excel("../0. Metadata/EU2 GPP 2023 Full Datamap.xlsx",
                         sheet_name = "Data Map")

# Creating country directories
base_path = sys.path[0]
eucountries = ["Austria", "Belgium", "Bulgaria", "Cyprus",
               "Czechia", "Germany", "Denmark", "Estonia",
               "Greece", "Spain", "Finland", "France",
               "Croatia", "Hungary", "Ireland", "Italy",
               "Lithuania", "Luxembourg", "Latvia", 
               "Malta", "Netherlands", "Poland", "Portugal",
               "Romania", "Sweden", "Slovenia", "Slovakia"]
dstages = ["1. PTR", "2. FFW"]

for stage in dstages:

    wpath = base_path + f"/Country-Wrangling/{stage}"
    os.mkdir(wpath)

    for country in eucountries:

        dpath = base_path + f"/../1. Data/{stage}/{country}"
        # os.mkdir(dpath)

        rawpath   = dpath + "/0. Raw Data"
        # os.mkdir(rawpath)
        cleanpath = dpath + "/1. Clean Data"
        # os.mkdir(cleanpath)

# Generating the variable_renaming.do routine:
for lab, row in codebook.iterrows():
    EUname = row["2023  EU Questionnaire"]
    if  EUname != row["Variable"] and EUname != "Transformed variable":
        line = "rename " + str(EUname) + " " + str(row["Variable"])
        print(line)

# Order variables
qquestions = codebook[~codebook["2023  EU Questionnaire"].isin(["Transformed variable"])]
print("order " + " ".join(qquestions["Variable"].unique()))


# Label summarization
def summarize_text(input_text, max_length = 80):
    response = openai.Completion.create(
        engine = "gpt-3.5-turbo-instruct",
        prompt = f"Summarize the following text: '{input_text}'\n\nSummary:",
        max_tokens = max_length,
        n = 1,
        stop = None,
        temperature = 0.7,
    )
    
    summary = response.choices[0].text.strip()
    return summary


# Generating the var_labels.do routine:
for lab, row in codebook.iterrows():
    label = row["Label"]
    line = "label var " + str(row["Variable"]) + ' "' + str(label) + '"'
    print(line)
for lab, row in codebook.iterrows():
    desc = row["Description"]
    line = "note " + str(row["Variable"]) + ": " + str(desc)
    print(line)

# Generating merge subset for Santi
merge_vars1 = [x for x in codebook["Global GPP"].to_list() if not re.match("^EU_", x)]
merge_vars2 = [x for x in merge_vars1 if not re.match("^No equivalent", x)]
codebook_onlyGlobal = codebook[codebook["Global GPP"].isin(merge_vars2)]

"keep " + " ".join(codebook_onlyGlobal["Global GPP"].to_list())

for lab, row in codebook_onlyGlobal.iterrows():
    EUname     = row["Variable"]
    GlobalName = row["Global GPP"] 
    line = "rename " + str(GlobalName) + " " + str(EUname)
    print(line)

# Generating the harmonization.do routine:
for lab, row in codebook.iterrows():
    EUname     = row["Variable"]
    GlobalName = row["Global GPP"] 
    if  EUname != GlobalName and GlobalName != "No equivalent":
        line = "rename " + str(EUname) + " " + str(GlobalName)
        print(line)

qset = ["A1", "A2", "A3", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3",
        "D4", "D5", "D6", "E1", "E2", "E3", "F1", "F2", "G1", "G2", "G3", "H1", "H2", "H3",
        "I1", "J1", "J2", "J3", "J4", "K1", "K2", "K3", "L1", "L2"]
a = 1
results = []
for lab in qset:
    r = str(a) + ' "' + lab + '"'
    print(r)