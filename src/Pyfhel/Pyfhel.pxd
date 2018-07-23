# distutils: language = c++

# -------------------------------- CIMPORTS -----------------------------------
# import both numpy and the Cython declarations for numpy
cimport numpy as np

# Import from Cython libs required C/C++ types for the Afhel API
from libcpp.vector cimport vector
from libcpp.string cimport string
from libcpp cimport bool
from libc.stdint cimport int64_t
from libc.stdint cimport uint64_t

# Import our own wrapper for iostream classes, used for I/O ops
from iostream cimport istream, ostream, ifstream, ofstream   

from Afhel cimport Plaintext
from Afhel cimport Ciphertext
from Afhel cimport Afseal

# Import the Cython Plaintext and Cyphertext classes
from PyPtxt cimport PyPtxt
from PyCtxt cimport PyCtxt

# ---------------------------- CYTHON DECLARATION ------------------------------
cdef class Pyfhel:
    cdef Afseal* afseal           # The C++ methods are accessed via a pointer
    
    # =========================== CRYPTOGRAPHY =================================
    cpdef ContextGen(self, long p, long m=*, bool flagBatching=*, long base=*,
                     long sec=*, int intDigits=*, int fracDigits=*) except +
    cpdef void KeyGen(self) except +
    cpdef PyCtxt encryptInt(self, int64_t value, PyCtxt ctxt=*) except +
    cpdef PyCtxt encryptFrac(self, double value, PyCtxt ctxt=*) except +
    cpdef PyCtxt encryptBatch(self, vector[int64_t] vec, PyCtxt ctxt=*) except +
    cpdef PyCtxt encryptPtxt(self, PyPtxt ptxt, PyCtxt ctxt=*) except +
    
    cpdef int64_t decryptInt(self, PyCtxt ctxt, int64_t output_value=*) except +
    cpdef double decryptFrac(self, PyCtxt ctxt, double output_value=*) except +
    cpdef vector[int64_t] decryptBatch(self, PyCtxt ctxt, vector[int64_t] output_vector=*) except +
    cpdef PyPtxt decryptPtxt(self, PyCtxt ctxt, PyPtxt ptxt=*) except +
    
    cpdef int noiseLevel(self, PyCtxt ctxt) except +
    cpdef void rotateKeyGen(self, int bitCount) except +
    cpdef void relinKeyGen(self, int bitCount) except +
    cpdef void relinearize(self, PyCtxt ctxt) except +
    
    # ============================= ENCODING ===================================
    cpdef PyPtxt encodeInt(self, int64_t value, PyPtxt ptxt=*) except +
    cpdef PyPtxt encodeFrac(self, double value, PyPtxt ptxt=*) except +
    cpdef PyPtxt encodeBatch(self, vector[int64_t] vec, PyPtxt ptxt=*) except +
    
    cpdef int64_t decodeInt(self, PyPtxt ptxt, int64_t output_value=*) except +
    cpdef double decodeFrac(self, PyPtxt ptxt, double output_value=*) except +
    cpdef vector[int64_t] decodeBatch(self, PyPtxt ptxt, vector[int64_t] output_vector=*) except +
    
    # ============================ OPERATIONS ==================================
    cpdef void square(self, PyCtxt ctxt) except +
    cpdef void negate(self, PyCtxt ctxt) except +
    cpdef void add_encr(self, PyCtxt ctxt, PyCtxt ctxt_other) except +
    cpdef void add_plain(self, PyCtxt ctxt, PyPtxt ptxt) except +
    cpdef void sub_encr(self, PyCtxt ctxt, PyCtxt ctxt_other) except +
    cpdef void sub_plain(self, PyCtxt ctxt, PyPtxt ptxt) except +
    cpdef void multiply_encr(self, PyCtxt ctxt, PyCtxt ctxt_other) except +
    cpdef void multiply_plain(self, PyCtxt ctxt, PyPtxt ptxt) except +
    cpdef void rotate(self, PyCtxt ctxt, int k) except +
    cpdef void exponentiate(self, PyCtxt ctxt, uint64_t expon) except +
    cpdef void polyEval(self, PyCtxt ctxt, vector[int64_t] coeffPoly) except +
    cpdef void polyEval_double (self, PyCtxt ctxt, vector[double] coeffPoly) except +

    
    # ================================ I/O =====================================
    cpdef bool saveContext(self, string fileName) except +
    cpdef bool restoreContext(self, string fileName) except +

    cpdef bool savepublicKey(self, string fileName) except +
    cpdef bool restorepublicKey(self, string fileName) except +

    cpdef bool savesecretKey(self, string fileName) except +
    cpdef bool restoresecretKey(self, string fileName) except +

    cpdef bool saverelinKey(self, string fileName) except +
    cpdef bool restorerelinKey(self, string fileName) except +

    cpdef bool saverotateKey(self, string fileName) except +
    cpdef bool restorerotateKey(self, string fileName) except +

    
    # ============================== AUXILIARY =================================
    cpdef bool batchEnabled(self) except +
    cpdef long relinBitCount(self) except +

    # GETTERS
    cpdef int getnSlots(self) except +
    cpdef int getp(self) except +
    cpdef int getm(self) except +
    cpdef int getbase(self) except +
    cpdef int getsec(self) except + 
    cpdef int getintDigits(self) except +
    cpdef int getfracDigits(self) except +
    cpdef bool getflagBatching(self) except +
    