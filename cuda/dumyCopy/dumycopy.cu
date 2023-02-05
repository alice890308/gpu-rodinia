#include <stdlib.h>
#include <stdio.h>

#define size 1024*1024*1024
#define cudaCheckError() {                                          \
    cudaError_t e=cudaGetLastError();                                 \
    if(e!=cudaSuccess) {                                              \
        printf("Cuda failure %s:%d: '%s'\n",__FILE__,__LINE__,cudaGetErrorString(e));           \
        exit(0); \
    }                                                                 \
}

int main() {
    float *deviceArr;
    float *hostArr = (float *) malloc(size * sizeof(float));

    cudaMalloc((void**) &deviceArr, sizeof(float) * size);

    printf("start copy\n");

    for(int i = 0; i < 1000; i++) {
        cudaMemcpy(deviceArr, hostArr, size * sizeof(float), cudaMemcpyHostToDevice);
        cudaCheckError();
    }
}