#!/usr/bin/env python3

# Reasons of this wrapper:
# 1) Byond in a bad relationship with unicode (513?)
# 2) Byond export proc does not support https (someday?)

import argparse
import json
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

        r = requests.get("https://stats.dushess.net/api/player/characters?ckey=" + options.ckey)
        r.raise_for_status()
        data = json.loads(r.text)

    except requests.exceptions.RequestException as e:
        print(e, file=sys.stderr)
        sys.exit(1)

    sys.stdout.buffer.write(byond_inner_text(data[0]["MindName"]))


def byond_outer_text(text):
    return text.decode("utf-8")


def byond_inner_text(text):
    return text.encode("utf-8")


if __name__ == "__main__":
    options = read_arguments()
    sys.exit(main(options))
