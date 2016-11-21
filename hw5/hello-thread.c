// #12.16

#include <pthread.h>
#include <stdlib.h>
#include <stdio.h>

void *thread(void *vargp);

int main(int argc, char *argv[])
{
  if (argc != 2)
    {
      printf("Wrong number of argument.\n");
      EXIT_FAILURE;
    }

  int nthreads;
  nthreads = atoi(argv[1]);
  pthread_t *tids = malloc(nthreads * sizeof(pthread_t));

  if (tids == NULL)
    {
      printf("Memory Allocating error.\n");
      EXIT_FAILURE;
    }
  
  int new;
  for (int i=0; i < nthreads; i++)
    new = pthread_create(tids + i, NULL, thread, NULL);
  for (int j=0; j < nthreads; j++)
    pthread_join(tids[j], 0);
  
  EXIT_SUCCESS;
}

void *thread(void *vargp)
{
  printf("Hello, world!\n");
  return NULL;
}
