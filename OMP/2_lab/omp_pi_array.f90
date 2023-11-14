PROGRAM OPENMP_PI_ARRAY
    INCLUDE 'omp_lib.h'
    INTEGER N, I, TID
    DOUBLE PRECISION X, STEP, PI /0.0/, SUM(16)
    PARAMETER (N=100000000)
    STEP = 1.57079632675/N
!$OMP PARALLEL PRIVATE(X, TID)
    TID = OMP_GET_THREAD_NUM() + 1
!$OMP DO
    DO I=1, N
      X = (I-0.5)*STEP
      SUM(TID) = SUM(TID) + sin(X)*log(sin(X))
    END DO
!$OMP END DO
!$OMP END PARALLEL
    DO I=1, 16
      PI = PI + SUM(I)*STEP
    END DO
    print*, PI
END