#!/bash/bin/python
from re import search

repos = []

commit=""

for repo in repos:
    with open(repo+"_Commits.txt","r") as f:
        for line in f:
            if not "*" in line:
                if "STR" in line or "RTC" in line or "DCTI" in line:
                    commit += line.strip("\n") + "\n"
    with open(repo+"_Commits.txt","w") as f:
        f.write(commit)
        f.close()
    commit = ""

print("File processed.")
