/*
 **********************************************
 *  CS314 Principles of Programming Languages *
 *  Spring 2020                               *
 **********************************************
 */
#include <stdio.h>
#include <stdlib.h>

__global__ void collateSegments_gpu(int * src, int * scanResult, int * output, int numEdges) {
	int tid = blockDim.x * blockIdx.x + threadIdx.x;
	int total_thread = blockDim.x * gridDim.x;
	int i ;
	for(i = tid; i < numEdges; i += total_thread)
		if(i == numEdges - 1 || src[i] != src[i + 1])
		output[src[i]] = scanResult[i];
}
