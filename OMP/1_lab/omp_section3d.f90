PROGRAM OPENMP_3D_ARRAY
    INCLUDE 'omp_lib.h'
    INTEGER I, J, K, L, NI, NJ, NK, INFILE, OUTFILE
    DOUBLE PRECISION T1, T2
    DOUBLE PRECISION, ALLOCATABLE :: X(:,:,:), Y(:,:,:), Z(:,:,:)

    OPEN(INFILE, FILE="CUBE.MSH")
    READ(INFILE,*) NI, NJ, NK 
    ALLOCATE (X(2*NI,2*NJ,2*NK), Y(2*NI,2*NJ,2*NK), Z(2*NI,2*NJ,2*NK))
    DO K=(NK/2 + 1), NK 
      DO J=(NJ/2 + 1), NJ
       DO I=(NI/2 + 1), NI 
        READ(INFILE,*) X(I,J,K), Y(I,J,K), Z(I,J,K) 
       END DO 
      END DO
    END DO
    CLOSE(INFILE)

    T1 = OMP_GET_WTIME()
!$OMP PARALLEL PRIVATE(I,J,K)
    DO L=1,300
!$OMP SECTIONS
!$OMP SECTION
    DO K=1, (NK/2)
     DO J=1, (NJ/2)
      DO I=1, (NI/2)
           X(I,J,K) = X((N/2 +I),(N/2 +J),(N/2 +K))
      END DO
     END DO
    END DO
!$OMP SECTION
     DO K=1, (NK/2)
     DO J=1, (NJ/2)
      DO I=1, (NI/2)
          Y(I,J,K) = -Y((N/2 +I),(N/2 +J),(N/2 +K))
      END DO
     END DO
    END DO
!$OMP SECTION
     DO K=1, (NK/2)
     DO J=1, (NJ/2)
      DO I=1, (NI/2)
          Z(I,J,K) = -Z((N/2 +I),(N/2 +J),(N/2 +K))
      END DO
     END DO
    END DO
!$OMP END SECTIONS
    END DO
!$OMP END PARALLEL
    T2 = OMP_GET_WTIME()
    PRINT *, 'computational time: ', T2-T1, 's'

    OPEN(OUTFILE, FILE="CUBE_NEW.MSH")
    WRITE(OUTFILE,*) NI, NJ, NK 
    DO K=1, 2*NK 
      DO J=1, 2*NJ 
       DO I=1, 2*NI 
        WRITE(OUTFILE,*) X(I,J,K), Y(I,J,K), Z(I,J,K) 
       END DO 
      END DO
    END DO
    CLOSE(OUTFILE)
    DEALLOCATE(X,Y,Z)

END
