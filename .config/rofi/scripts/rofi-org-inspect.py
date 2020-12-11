#!/bin/python3
import sys
import os
from datetime import date
from rofi import Rofi

# thanks to Daryl Manning (wakatara) for this script
# here is the original repo: https://github.com/wakatara/rofi-org-todo

# path to where you want your TODOs to be inserted to
inbox_file = "/home/levic/Dropbox/org/inbox.org"
r = Rofi()

def inspect_to_inbox():
    inspect = r.text_entry("INSPECT", message="""Usage:
    Type full text of org INSPECT and any tags
    eg. Lucas & Moll (2014) :<tag>:
    """)
    if inspect is not None:
        f = open(inbox_file, "a")
        f.write("\n** INSPECT ")
        f.write(inspect + "\n")
        f.write(":PROPERTIES:\n")
        f.write(":CREATED: " +
                "[" + date.today().strftime("%Y-%m-%d %a") + "]\n")
        f.write(":END:\n\n")
        f.close()

inspect_to_inbox()
