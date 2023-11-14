from mpi4py import MPI

comm = MPI.COMM_WORLD
rank = comm.Get_rank()
size = comm.Get_size()

# наименьшие измеримые интервалы времени
resolution = MPI.Wtick()

if rank == 0:
    print(f"Resolution of the system timer is {resolution} seconds")

comm.Barrier() # дожидается всех процессов и только потом пускает дальше

if __name__ == "__main__":

    start = MPI.Wtime()

    sum = 0
    for i in range(1, 100000001):
        sum += i * i
    
    comm.Barrier()
    end = MPI.Wtime()

    if rank == 0:
        print(f"Time spent on the loop is {end - start} seconds")













