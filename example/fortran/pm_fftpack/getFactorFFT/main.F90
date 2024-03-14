program example

    use pm_kind, only: SK, IK, LK
    use pm_io, only: display_type
    use pm_fftpack, only: getfactorFFT
    use pm_arrayFill, only: getFilled
    use pm_err, only: setAsserted

    implicit none

    integer(IK), allocatable :: factor(:)

    type(display_type) :: disp
    disp = display_type(file = "main.out.F90")

    block
        use pm_kind, only: TKC => CK32
        complex(TKC), allocatable :: coef(:)
        call disp%skip()
        call disp%show("allocate(coef(13))")
                        allocate(coef(13))
        call disp%show("factor = getfactorFFT(getFilled((0._TKC, 0._TKC), size(coef, 1, IK)), coef)")
                        factor = getfactorFFT(getFilled((0._TKC, 0._TKC), size(coef, 1, IK)), coef)
        call disp%show("factor")
        call disp%show( factor )
        call disp%show("coef")
        call disp%show( coef )
        call disp%show("call setAsserted(product([factor]) == size(coef, 1, IK))")
                        call setAsserted(product([factor]) == size(coef, 1, IK))
        call disp%skip()
    end block

    block
        use pm_kind, only: TKC => RK32
        real(TKC), allocatable :: coef(:)
        call disp%skip()
        call disp%show("allocate(coef(13))")
                        allocate(coef(13))
        call disp%show("factor = getfactorFFT(getFilled(0._TKC, size(coef, 1, IK)), coef)")
                        factor = getfactorFFT(getFilled(0._TKC, size(coef, 1, IK)), coef)
        call disp%show("factor")
        call disp%show( factor )
        call disp%show("coef")
        call disp%show( coef )
        call disp%show("call setAsserted(product([factor]) == size(coef, 1, IK))")
                        call setAsserted(product([factor]) == size(coef, 1, IK))
        call disp%skip()
    end block

    block
        use pm_kind, only: TKC => RK32
        real(TKC), allocatable :: coef(:)
        call disp%skip()
        call disp%show("allocate(coef(273))")
                        allocate(coef(273))
        call disp%show("factor = getfactorFFT(getFilled(0._TKC, size(coef, 1, IK)), coef)")
                        factor = getfactorFFT(getFilled(0._TKC, size(coef, 1, IK)), coef)
        call disp%show("factor")
        call disp%show( factor )
        call disp%show("coef")
        call disp%show( coef )
        call disp%show("call setAsserted(product([factor]) == size(coef, 1, IK))")
                        call setAsserted(product([factor]) == size(coef, 1, IK))
        call disp%skip()
    end block

end program example