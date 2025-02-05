﻿# `odd-even-merge-sort` Sample

The `odd-even-merge-sort` sample demonstrates how to use the **odd-even mergesort** algorithm (also known as "Batcher's odd–even mergesort"), which belongs to the class of sorting networks. Generally, this algorithm is not efficient for large sequences compared to algorithms with better asymptotic algorithmic complexity (merge sort or radix sort); however, this sort method might be the preferred algorithm for sorting batches of short-sized to mid-sized (key, value) array pairs.

> **Note**: This sample is migrated from NVIDIA CUDA sample. See the [sortingNetworks](https://github.com/NVIDIA/cuda-samples/tree/master/Samples/2_Concepts_and_Techniques/sortingNetworks) sample in the NVIDIA/cuda-samples GitHub.

| Property            | Description
|:---                 |:---
| What you will learn | How to begin migrating CUDA to SYCL*
| Time to complete    | 15 minutes

## Purpose

The **odd-even mergesort** algorithm was developed by Kenneth Edward Batcher.

The algorithm is based on a merge algorithm that merges two sorted halves of a sequence into a sorted sequence. In contrast to a standard merge sort, this algorithm is not data-dependent. All comparisons are performed regardless of the actual data, so you can implement this algorithm as a sorting network.

This sample contains three versions of the program.

|Folder                | Descriptions
|:---                  |:---
| `sycl_dpct_migrated` | This version contains migrated code, using the Intel® DPC++ Compatibility Tool, from CUDA code with some manual changes made so the program builds and works.
| `sycl_migrated`      | This version contains manually migrated SYCL-compliant code from CUDA code.
| `sycl_dpct_output`   | This version contains migrated code from the Intel® DPC++ Compatibility Tool (with some APIs unmigrated) from CUDA code without manual changes, so it does not work and will not build.

*[Migrating the Odd-Even Merge Sort from CUDA* to SYCL*](https://www.intel.com/content/www/us/en/developer/articles/technical/odd-even-merge-sort-from-cuda-to-sycl.html)* contains a detailed discussion of the code and concepts in this sample.

## Prerequisites

| Optimized for        | Description
|:---                  |:---
| OS                   | Ubuntu* 20.04
| Hardware             | Skylake with GEN9 or newer
| Software             | Intel® oneAPI DPC++/C++ Compiler

## Key Implementation Details

In this implementation, a random sequence of power of 2 elements is given as input, and the algorithm sorts the sequence in parallel. The algorithm sorts the first half of the list and second half of the list separately. The algorithm then sorts the odd-indexed entries and the even-indexed entries separately. You need make only one more comparison-switch per pair of keys to sort the list completely.

In this sample, the array length=**1048576** is the input size for the algorithm. The code checks for all the input sizes in the intervals of 2th power from array lengths from  **64** to **1048576** calculated for one iteration. The comparator swaps the value if top value is greater or equal to the bottom value.

The `odd-even mergesort` sample is implemented using SYCL*-compliant standards for Intel® CPUs and GPUs. Key SYCL concepts explained in the code include Cooperative Groups, Shared Memory and, Data-Parallelism.

## Build the `odd-even merge-sort` Sample for CPU and GPU

When working with the command-line interface (CLI), you should configure the oneAPI toolkits using environment variables. Set up your CLI environment by sourcing the `setvars` script every time you open a new terminal window. This practice ensures that your compiler, libraries, and tools are ready for development.

> **Note**: If you have not already done so, set up your CLI
> environment by sourcing  the `setvars` script in the root of your oneAPI installation.
>
> Linux*:
> - For system wide installations: `source . /opt/intel/oneapi/setvars.sh`
> - For private installations: `source . ~/intel/oneapi/setvars.sh`
> - For non-POSIX shells, like csh, use the following command: `bash -c 'source <install-dir>/setvars.sh ; exec csh'`
>
> For more information on configuring environment variables, see [Use the setvars Script with Linux* or macOS*](https://www.intel.com/content/www/us/en/develop/documentation/oneapi-programming-guide/top/oneapi-development-environment-setup/use-the-setvars-script-with-linux-or-macos.html).

### On Linux*

1. Change to the `odd-even-merge-sort` directory.
2. Build the program. 
	```
	$ mkdir build
	$ cd build
	$ cmake ..
	$ make
	```
    By default, these commands build the `sycl_dpct_migrated` and `sycl_migrated` versions of the program.

If an error occurs, you can get more details by running make with the `VERBOSE=1` argument:
```
make VERBOSE=1
```
#### Troubleshooting

If you receive an error message, troubleshoot the problem using the **Diagnostics Utility for Intel® oneAPI Toolkits**. The diagnostic utility provides configuration and system checks to help find missing dependencies, permissions errors, and other issues. See the [Diagnostics Utility for Intel® oneAPI Toolkits User Guide](https://www.intel.com/content/www/us/en/develop/documentation/diagnostic-utility-user-guide/top.html) for more information on using the utility.

## Run the `odd-even merge-sort` Sample

You can run the programs for CPU or GPU or both. The run commands indicate the device target.

1. Run `sycl_dpct_migrated` for CPU and GPU.
   ```
   make run_sdm_cpu
   make run_sdm_gpu
   ```
2. Run sycl_migrated using following commands,
   ```
   make run_cpu
   make run_gpu
   ```
3. Optionally, clean the project.
   ```
   make clean
   ```
### Run `odd-even-merge-sort` Sample in Intel® DevCloud (Optional)

When running a sample in the Intel® DevCloud, you must specify the compute node (CPU, GPU, FPGA) and whether to run in batch or interactive mode. For more information, see the Intel® oneAPI Base Toolkit [Get Started Guide](https://devcloud.intel.com/oneapi/get_started/).

#### Build and Run Samples in Batch Mode (Optional)

You can submit build and run jobs through a Portable Bash Script (PBS). A job is a script that submitted to PBS through the `qsub` utility. By default, the `qsub` utility does not inherit the current environment variables or your current working directory, so you might need to submit jobs to configure the environment variables. To indicate the correct working directory, you can use either absolute paths or pass the `-d \<dir\>` option to `qsub`.

1. Open a terminal on a Linux* system.

2. Log in to the Intel® DevCloud.
   ```
   ssh devcloud
   ```
3. Download the samples from GitHub.
   ```
   git clone https://github.com/oneapi-src/oneAPI-samples.git
   ```
4. Change to the sample directory.

5. Configure the sample for a GPU node. (This is a single line script.)
	```
	qsub  -I  -l nodes=1:gpu:ppn=2 -d .
	```
   - `-I` (upper case I) requests an interactive session.
   - `-l nodes=1:gpu:ppn=2` (lower case L) assigns one full GPU node. 
   - `-d .` makes the current folder as the working directory for the task.

6. Perform build steps you would on Linux. (Including optionally cleaning the project.)
7. Run the sample.
8. Disconnect from the Intel® DevCloud.
	```
	exit
	```
## Example Output

The following example is for `sycl_migrated for GPU` using an input array length of **1048576**, which is set in `main.cpp`.
```
	Running on Intel(R) UHD Graphics P630 [0x3e96]

	Running GPU odd_even_merge sort (1 identical iterations)...

	Testing array length 64 (16384 arrays per batch)...
	Average time: 146.904007 ms


	Validating the results...
	...reading back GPU results
	...inspecting keys array: OK
	...inspecting keys and values array: OK
	...stability property: NOT stable

	Testing array length 128 (8192 arrays per batch)...
	Average time: 5.515000 ms


	Validating the results...
	...reading back GPU results
	...inspecting keys array: OK
	...inspecting keys and values array: OK
	...stability property: NOT stable

	Testing array length 256 (4096 arrays per batch)...
	Average time: 6.579000 ms


	Validating the results...
	...reading back GPU results
	...inspecting keys array: OK
	...inspecting keys and values array: OK
	...stability property: NOT stable

	Testing array length 512 (2048 arrays per batch)...
	Average time: 7.458000 ms


	Validating the results...
	...reading back GPU results
	...inspecting keys array: OK
	...inspecting keys and values array: OK
	...stability property: NOT stable

	Testing array length 1024 (1024 arrays per batch)...
	Average time: 9.548000 ms


	Validating the results...
	...reading back GPU results
	...inspecting keys array: ***Set 0 result key array is not ordered properly***
	...inspecting keys and values array: OK
	...stability property: NOT stable

	Testing array length 2048 (512 arrays per batch)...
	Average time: 9.632000 ms


	Validating the results...
	...reading back GPU results
	...inspecting keys array: ***Set 0 result key array is not ordered properly***
	...inspecting keys and values array: OK
	...stability property: NOT stable

	Testing array length 4096 (256 arrays per batch)...
	Average time: 9.815000 ms


	Validating the results...
	...reading back GPU results
	...inspecting keys array: ***Set 0 result key array is not ordered properly***
	...inspecting keys and values array: OK
	...stability property: NOT stable

	Testing array length 8192 (128 arrays per batch)...
	Average time: 10.106000 ms


	Validating the results...
	...reading back GPU results
	...inspecting keys array: ***Set 0 result key array is not ordered properly***
	...inspecting keys and values array: OK
	...stability property: NOT stable

	Testing array length 16384 (64 arrays per batch)...
	Average time: 10.378000 ms


	Validating the results...
	...reading back GPU results
	...inspecting keys array: ***Set 0 result key array is not ordered properly***
	...inspecting keys and values array: OK
	...stability property: NOT stable

	Testing array length 32768 (32 arrays per batch)...
	Average time: 10.603000 ms


	Validating the results...
	...reading back GPU results
	...inspecting keys array: ***Set 0 result key array is not ordered properly***
	...inspecting keys and values array: OK
	...stability property: NOT stable

	Testing array length 65536 (16 arrays per batch)...
	Average time: 11.103000 ms


	Validating the results...
	...reading back GPU results
	...inspecting keys array: ***Set 0 result key array is not ordered properly***
	...inspecting keys and values array: OK
	...stability property: NOT stable

	Testing array length 131072 (8 arrays per batch)...
	Average time: 11.221000 ms


	Validating the results...
	...reading back GPU results
	...inspecting keys array: ***Set 0 result key array is not ordered properly***
	...inspecting keys and values array: OK
	...stability property: NOT stable

	Testing array length 262144 (4 arrays per batch)...
	Average time: 11.764000 ms


	Validating the results...
	...reading back GPU results
	...inspecting keys array: ***Set 0 result key array is not ordered properly***
	...inspecting keys and values array: OK
	...stability property: NOT stable

	Testing array length 524288 (2 arrays per batch)...
	Average time: 11.892000 ms


	Validating the results...
	...reading back GPU results
	...inspecting keys array: ***Set 0 result key array is not ordered properly***
	...inspecting keys and values array: OK
	...stability property: NOT stable

	Testing array length 1048576 (1 arrays per batch)...
	Average time: 12.206000 ms

	sorting_networks-odd_even_merge sort, Throughput = 85.9066 MElements/s, Time = 0.01221 s, Size = 1048576 elements, Num_Devs_Used = 1, Workgroup = 256

	Validating the results...
	...reading back GPU results
	...inspecting keys array: ***Set 0 result key array is not ordered properly***
	...inspecting keys and values array: OK
	...stability property: NOT stable

	Shutting down...
```

## License

Code samples are licensed under the MIT license. See
[License.txt](https://github.com/oneapi-src/oneAPI-samples/blob/master/License.txt) for details.

Third party program Licenses can be found here: [third-party-programs.txt](https://github.com/oneapi-src/oneAPI-samples/blob/master/third-party-programs.txt).