import matplotlib.pyplot as plt
s_p = [1, 2.381668947, 4.836111111, 7.737777778, 10.24117647]
processes = [1, 2, 4, 8, 16]
plt.bar(processes, s_p)
plt.xlabel('Число процессов')
plt.ylabel(r'Ускорение $S_p$')
plt.savefig("s_p_process.png")
plt.show()