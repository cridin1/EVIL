# coding=utf-8

from __future__ import print_function
import json, sys
from util import encoded_code_tokens_to_code
from OurCanonical import Canonical


if __name__ == '__main__':
    seq2seq_output = sys.argv[1]
    dataset_path = sys.argv[2]
    code_output = sys.argv[3]
    dataset = sys.argv[4]
    code_list = []
    if dataset == 'encoder':
        res_words = 'python'
    elif dataset =='decoder':
        res_words = 'assembly'
    elif dataset == "powershell":
        res_words = ""
    dataset = json.load(open(dataset_path))

    cannon = Canonical(reserved_words = res_words)

    for line, example in zip(open(seq2seq_output), dataset):
        encoded_tokens = line.strip().split(' ')
        code = encoded_code_tokens_to_code(encoded_tokens)
        if 'slot_map' in example:
            code = cannon.decanonicalize_code(code, example['slot_map'])
        code_list.append(code)

    json.dump(code_list, open(code_output, 'w'), indent=2)
