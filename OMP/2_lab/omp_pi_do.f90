PROGRAM OPENMP_PI_DO
    INTEGER N, I
    DOUBLE PRECISION X, STEP, PI /0.0/, SUM /0.0/
    PARAMETER (N=100000000)
    STEP = 1.57079632675/N
!$OMP PARALLEL PRIVATE(X)
!$OMP DO REDUCTION(+:SUM)
    DO I=1, N
      X = (I-0.5)*STEP
      SUM = SUM + sin(x)*log(sin(X))
    END DO
!$OMP END PARALLEL
    PI = STEP * SUM
    print*, PI
END
