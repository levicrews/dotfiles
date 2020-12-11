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

def todo_to_inbox():
    todo = r.text_entry("TODO", message="""Usage:
    Type full text of org TODO and any tags
    eg. A task to be done :<tag>:
    """)
    if todo is not None:
        f = open(inbox_file, "a")
        f.write("\n** TODO ")
        f.write(todo + "\n")
        f.write(":PROPERTIES:\n")
        f.write(":CREATED: " +
                "[" + date.today().strftime("%Y-%m-%d %a") + "]\n")
        f.write(":END:\n\n")
        f.close()

todo_to_inbox()
