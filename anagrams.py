# Original code at: https://www.johndcook.com/blog/2019/11/13/anagram-frequency/
from collections import defaultdict

# change to the path on your system
lines = open("/usr/share/dict/spanish", "r").readlines()

words = set()
for line in lines:
    line = line.strip().lower()
    words.add(line)

def sig(word):
    return "".join(sorted(word))

d = defaultdict(set)
for w in words:
    d[sig(w)].add(w)

# make a csv file containing the signature, length of set and its elements
sig_file = open("anagrams-signature-spanish.csv", "w")
print("signature,n,elements", file = sig_file)
for s, wrds in d.items():
    if len(wrds) > 1:
        print("{},{},{}".format(s, str(len(wrds)), "|".join(wrds)), file = sig_file)
sig_file.close()

# make the anagram dictionary file
dict_file = open("anagrams-spanish.txt", "w")
for w in sorted(words):
    anas = sorted(d[sig(w)])
    if len(anas) > 1:
        anas.remove(w)
        print("{}: {}".format(w, ", ".join(anas)), file = dict_file)
dict_file.close()


