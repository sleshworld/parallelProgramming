from mpi4py import MPI

comm = MPI.COMM_WORLD
rank = comm.Get_rank()
size = comm.Get_size()
#name = MPI.Get_processor_name()
#print(mpi4py.get_config())

def hello_world_one_process(target_rank):
    if rank == target_rank:
        print(f"Hello, World! from process {rank}")

def hello_world():
    print(f"Hello, World! from process {rank} out of {size}")

if __name__ == "__main__":
    hello_world()
    if rank == 0:
        hello_world_one_process(0)
