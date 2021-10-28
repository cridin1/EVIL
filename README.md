# EVIL: Exploiting Software via Natural Language

This repository contains the dataset and the code related to the paper **EVIL: Exploiting Software via Natural Language** accepted for publication at the 32nd International Symposium on Software Reliability Engineering (ISSRE 2021) conference. 

The preprint of the paper is publicly available on [Arxiv](http://arxiv.org/abs/2109.00279). 
The slide presentation is available on [slideshare](https://www.slideshare.net/PietroLiguori4/evil-exploiting-software-via-natural-language-250549168), while you can find the video presentation of the paper on [Youtube](https://www.youtube.com/watch?v=vq3n8znFn-k&list=PLhBMpvlFe-cHGnN9-9R5h2FWqjbBdyjA0&index=3&t=4s)

*EVIL* is an approach to automatically generate software exploits in assembly/Python language from descriptions in natural language. 
The approach leverages Neural Machine Translation (NMT) techniques and a dataset that we developed for this work. 

![alt text](https://github.com/dessertlab/EVIL/blob/main/EVIL.png)

This repository contains:
1. A substantive **dataset** containing exploits collected from shellcode databases, and their descriptions in the English language. The dataset includes both assembly code (i.e, shellcodes and decoders) and Python code (i.e., encoders). Such data is valuable to support research in machine translation for security-oriented applications since the techniques are data-driven. 
2. The code to reproduce the **experiments** described in the paper.
3. The **appendix** of the paper containing additional information on the test set.


## Dataset
To automatically generate Python and assembly programs used for security exploits, we curated a large dataset for feeding NMT techniques. A sample in the dataset consists of a snippet of code from these exploits and their corresponding description in the English language.
We collected exploits from publicly available databases ([*exploitdb*](https://www.exploit-db.com/), [*shellstorm*](http://shell-storm.org/shellcode/)), public repositories (e.g., GitHub), and programming guidelines. In particular, we focused on exploits targeting Linux, the most common OS for security-critical network services, running on IA-32 (i.e., the 32-bit version of the x86 Intel Architecture). The dataset is stored in the folder *EVIL/datasets* and consists of two parts: 
1. **Encoders**: a Python dataset, which contains Python code used by exploits to encode the shellcode;
2. **Decoders**: an assembly dataset, which includes shellcode and decoders to revert the encoding. This dataset extends the [Shellcode_IA32 dataset](https://github.com/dessertlab/Shellcode_IA32).

Both datasets are already slipt in train, dev, and test set. ``encoder-*.in`` represents the natural language intents and ``encoder-*.out`` represents the corresponding code snippets. 
Please, find the detailed information of the dataset on the paper. 


## Experiments
We provide the code to replicate the experiments of the paper. In particular, the repository contains the code to generate assembly/Python exploits with CodeBERT and Seq2Seq models. We also added the code to run the pre-processing and post-processing phases. 
The detailed steps to replicate the experiments are described in the [INSTALL.md](https://github.com/dessertlab/EVIL/blob/main/INSTALL.md) file.

## Appendix
The folder *EVIL/Appendix* contains detailed information on the 20 encoders and decoders used in the test set.
It includes the source URL, the number of total lines (n_t) of the programs, and the number of syntactically correct (n_syn) and semantically correct (n_sem) lines generated by our approach, for both the encoders in Python and decoders in Assembly. 
In total, the test set for the Python programs contains 375 unique pairs of Python code snippets (not including prints) along with their natural description. The test set for assembly contains 305 unique pairs of code snippets (95 are multi-line snippets) and natural language intents.

## Contacts
For further information, contact us via email: *pietro.liguori@unina.it* (Pietro) and *ealhossa@uncc.edu* (Erfan).
