from mpi4py import MPI

comm = MPI.COMM_WORLD
rank = comm.Get_rank()
size = comm.Get_size()

start = MPI.Wtime()
NBIN = 100_000_000
step = 1/NBIN

local_sum = 0
# 0 процесс начинает с нуля и идет с шагом size (например 2): 0-2-4-6
# 1 процесс начинает с нуля и идет с шагом size (например 2): 1-3-5-7
for i in range(rank, NBIN, size): 
    x = (i + 0.5) * step
    local_sum += 4.0/(1.0 + x**2)

global_sum = comm.reduce(local_sum, op=MPI.SUM, root=0) # суммирую и присваиваю переменную одному процессу

if rank == 0:
    pi = global_sum * step
    end = MPI.Wtime()
    print(f"Pi: {pi}")
    print(f"Time: {end - start}")