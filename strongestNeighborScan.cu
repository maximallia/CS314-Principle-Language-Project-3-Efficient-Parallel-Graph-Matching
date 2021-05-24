/*
 **********************************************
 *  CS314 Principles of Programming Languages *
 *  Spring 2020                               *
 **********************************************
 */
#include <stdio.h>
#include <stdlib.h>

__global__ void strongestNeighborScan_gpu(int * src, int * oldDst, int * newDst, int * oldWeight, int * newWeight, int * madeChanges, int distance, int numEdges){
    int tid = blockDim.x * blockIdx.x + threadIdx.x;
    int total_thread = blockDim.x * gridDim.x;

    int i;
    for(i = tid; i < numEdges; i += total_thread){
        if( i < distance){
            newDst[i] = oldDst[i];
            newWeight[i] = oldWeight[i];
        }
        else{
            if(src[i] != src[i - distance]){
                newDst[i] = oldDst[i];
                newWeight[i] = oldWeight[i];
            }
            else{
                if(oldWeight[i] < oldWeight[i - distance]){
                    newDst[i] = oldDst[i- distance];
                    newWeight[i] = oldWeight[i - distance];
                }
                else if (oldWeight[i] == oldWeight[i - distance]){
                    if(oldDst[i] > oldDst[i - distance]){
                        newDst[i] = oldDst[i-distance];
                        newWeight[i] = oldWeight[i-distance];
                    }
                    else{
                        newDst[i] = oldDst[i];
                        newWeight[i] = oldWeight[i];
                    }
                }
                else{
                    newDst[i] = oldDst[i];
                    newWeight[i] = oldWeight[i];
                }
            if(oldDst[i] != newDst[i] || oldWeight[i] != newWeight[i])
             *madeChanges = 1;
	   }
        }
    }
}
