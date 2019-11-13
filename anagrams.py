# Original code at: https://www.johndcook.com/blog/2019/11/13/anagram-frequency/
from collections import defaultdict

lines = open("spanish", "r").readlines()

words = set()
for line in lines:
    line = line.strip().lower()
    words.add(line)

def sig(word):
    return "".join(sorted(word))

d = defaultdict(set)
for w in words:
    d[sig(w)].add(w)

for w in sorted(words):
    anas = sorted(d[sig(w)])
    if len(anas) > 1:
        anas.remove(w)
        print("{}: {}".format(w, ", ".join(anas)))

