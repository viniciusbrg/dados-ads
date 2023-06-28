# monolith-vs-microservices

This repository contains scripts and data collected from running performance tests 
comparing an application written using monolithic architecture and microservices architecture.

## Analysis

Analysis (graphics and statistical tests) of the collected data is performed in a [Collab Notebook](https://colab.research.google.com/drive/18kfSOK8xU85goUMFr1yIOujsiB5GihwX?usp=sharing).

## Data details

Raw data is in the format of text files, collected from running [WRK](https://github.com/wg/wrk) to load test the applications.

Data is processed using the `results_parser.py` script, which outputs data from WRK tests in JSON format.

The saved JSON files contain a list of JSON records, where each record represents the result of an individual WRK run.

Each JSON record contains the following fields:

```
  avg: Average latency for the test
  50%: 50th percentile latency (in ms)
  75%: 75th percentile latency (in ms)
  90%: 90th percentile latency (in ms)
  99%: 99th percentile latency (in ms)
  throughput: Requests/second for the test
```

Data is organized in two folders: monolith and microservices. Each folder contains data for the respective system. 

The file names correspond to the test scenario executed for the system.

```
Test 1: Get pet owner details (1 instance of services)
Test 2: List Veterinarians (1 instance of services)
Test 3: Get pet owner details (3 instances of services)
Test 4: List Veterinarians (3 instances of services)
```
