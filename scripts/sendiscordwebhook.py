#!/usr/bin/env python3

# Reasons of this wrapper:
# 1) Byond in a bad relationship with unicode (513?)
# 2) Byond export proc does not support https (someday?)

import argparse
import os
import requests
import sys


def read_arguments():
    parser = argparse.ArgumentParser(
        description="get wrapper"
    )

    parser.add_argument(
        "ckey",
    )

    return parser.parse_args()



def main(options):
    try:

        hook = os.getenv('DISCORD_WEB')
        if (hook == None):
            sys.exit(1)


        data = {
            "content" : "<@&1184798124221415444> Зашёл игрок " + options.ckey
                }

        r = requests.post(hook,json = data)
        #r.raise_for_status()

    except requests.exceptions.RequestException as e:
        print(e, file=sys.stderr)
        sys.exit(1)


def byond_outer_text(text):
    return text.decode("utf-8")


def byond_inner_text(text):
    return text.encode("utf-8")


if __name__ == "__main__":
    options = read_arguments()
    sys.exit(main(options))
