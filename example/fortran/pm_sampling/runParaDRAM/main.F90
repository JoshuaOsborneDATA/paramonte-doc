module logfunc
    use iso_c_binding, only: SK => c_char, IK => c_int32_t, RKC => c_double ! All real kinds are supported.
    implicit none
    integer(IK) , parameter :: NDIM = 4_IK
    real(RKC)   , parameter :: MEAN(NDIM) = [-6, -2, 2, 6] ! The mean vector of the MVN
    real(RKC)   , parameter :: LOG_INVERSE_SQRT_TWO_PI = log(1./sqrt(2.*acos(-1.))) ! MVN distribution coefficient: log(1/sqrt(2*Pi)^ndim).
    real(RKC)   , parameter :: COVMAT(NDIM, NDIM) = reshape([ +1.0, +0.5, +0.5, +0.5 &
                                                            , +0.5, +1.0, +0.5, +0.5 &
                                                            , +0.5, +0.5, +1.0, +0.5 &
                                                            , +0.5, +0.5, +0.5, +1.0 ], shape(COVMAT)) ! The covariance matrix of the MVN
    real(RKC)   , parameter :: INVCOV(NDIM, NDIM) = reshape([ +1.6, -0.4, -0.4, -0.4 &
                                                            , -0.4, +1.6, -0.4, -0.4 &
                                                            , -0.4, -0.4, +1.6, -0.4 &
                                                            , -0.4, -0.4, -0.4, +1.6 ], shape(INVCOV)) ! The inverse covariance matrix of the MVN
    real(RKC)   , parameter :: MVN_COEF = NDIM * LOG_INVERSE_SQRT_TWO_PI + 0.581575404902840 ! log(sqrt(det(INVCOV)))
contains
    function getLogFunc(state, ndim) result(logFunc) bind(C)
        ! Return the negative natural logarithm of MVN distribution
        ! evaluated at the input vector `state` of length `ndim`.
        integer(IK), value :: ndim
        real(RKC), intent(in) :: state(ndim)
        real(RKC) :: stateNormed(size(state))
        real(RKC) :: logFunc
        stateNormed = state - MEAN
        logFunc = MVN_COEF - 0.5_RKC * (dot_product(stateNormed, matmul(INVCOV, stateNormed)))
    end function
end module logfunc

program example
    use logfunc, only: SK, IK, RKC, NDIM, getLogFunc
    use iso_c_binding, only: c_funloc, c_null_char
    use pm_sampling, only: runParaDRAMD
    integer(IK) :: stat
    stat = runParaDRAMD(c_funloc(getLogFunc), NDIM, SK_"&paradram outputFileName = './out/runParaDRAM', outputStatus = 'retry', outputChainSize = 30000 /"//c_null_char)
    if (stat /= 0) error stop "sampler failed."
end