#!/bin/bash
set -ax

#-----------------------------------------------------
#-use standard modules.
#-----------------------------------------------------

module purge
module use -a ../../modulefiles
module load build.hera.intel

mkdir -p ../../exec

export FCMP=${FCMP:-ifort}
export FCMP95=$FCMP

export FFLAGSM="-i4 -O2 -r8  -convert big_endian -fp-model precise -g -traceback"
export RECURS=
export LDFLAGSM="-qopenmp -auto"
export OMPFLAGM="-qopenmp -auto"

export NETCDF_INCLUDE=$(nc-config --fflags)
export NETCDF_LDFLAGS_F=$(nc-config --flibs)

export INCS="-I${SIGIO_INC4} -I${SFCIO_INC} -I${LANDSFCUTIL_INCd} \
             -I${NEMSIO_INC} -I${NEMSIOGFS_INC} -I${GFSIO_INC4} -I${IP_INCd} ${NETCDF_INCLUDE}"

export LIBSM="${GFSIO_LIB4} \
              ${NEMSIOGFS_LIB} \
              ${NEMSIO_LIB} \
              ${SIGIO_LIB4} \
              ${SFCIO_LIB} \
              ${LANDSFCUTIL_LIBd} \
              ${IP_LIBd} \
              ${SP_LIBd} \
              ${W3EMC_LIBd} \
              ${W3NCO_LIBd} \
              ${BACIO_LIB4} \
              ${NETCDF_LDFLAGS_F}"


make -f Makefile
make -f Makefile install
make -f Makefile clean
