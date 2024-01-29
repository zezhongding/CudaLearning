#define N 10000000

__global__ void vector_add(float *out, float *a, float *b, int n) {
    int index = 0;
    int stride = 1;
    for(int i = index; i < n; i+=stride){
        out[i] = a[i] + b[i];
    }
}

int main(){
    float *a, *b, *out; 
    float *d_a;

    // Allocate memory
    a   = (float*)malloc(sizeof(float) * N);
    cudaMalloc((void**)&d_a,sizeof(float)*N);
    
    cudaMemcpy(d_a, a, sizeof(float) * N, cudaMemcpyHostToDevice);
    b   = (float*)malloc(sizeof(float) * N);
    out = (float*)malloc(sizeof(float) * N);

    // Initialize array
    for(int i = 0; i < N; i++){
        a[i] = 1.0f; b[i] = 2.0f;
    }

    // Main function
    vector_add<<<1,256>>>(out, a, b, N);
    cudaFree(d_a);
    free(a);
}
