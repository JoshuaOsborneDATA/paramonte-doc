!**********************************************************************************************************************************
!**********************************************************************************************************************************
!
!  ParaMonte: plain powerful parallel Monte Carlo library.
!
!  Copyright (C) 2012-present, The Computational Data Science Lab
!
!  This file is part of ParaMonte library. 
!
!  ParaMonte is free software: you can redistribute it and/or modify
!  it under the terms of the GNU Lesser General Public License as published by
!  the Free Software Foundation, version 3 of the License.
!
!  ParaMonte is distributed in the hope that it will be useful,
!  but WITHOUT ANY WARRANTY; without even the implied warranty of
!  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
!  GNU Lesser General Public License for more details.
!
!  You should have received a copy of the GNU Lesser General Public License
!  along with ParaMonte.  If not, see <https://www.gnu.org/licenses/>.
!
!**********************************************************************************************************************************
!**********************************************************************************************************************************

module SpecMCMC_RandomStartPointDomainUpperLimitVec_mod

    use Constants_mod, only: RK
    implicit none

    character(*), parameter         :: MODULE_NAME = "@SpecMCMC_RandomStartPointDomainUpperLimit_mod"

    real(RK), allocatable           :: randomStartPointDomainUpperLimitVec(:) ! namelist input

    type                            :: RandomStartPointDomainUpperLimitVec_type
        real(RK), allocatable       :: Val(:)
        real(RK)                    :: null
        character(:), allocatable   :: desc
    contains
        procedure, pass             :: set => setRandomStartPointDomainUpperLimitVec, checkForSanity, nullifyNameListVar
    end type RandomStartPointDomainUpperLimitVec_type

    interface RandomStartPointDomainUpperLimitVec_type
        module procedure            :: constructRandomStartPointDomainUpperLimitVec
    end interface RandomStartPointDomainUpperLimitVec_type

    private :: constructRandomStartPointDomainUpperLimitVec, setRandomStartPointDomainUpperLimitVec, checkForSanity, nullifyNameListVar

!***********************************************************************************************************************************
!***********************************************************************************************************************************

contains

!***********************************************************************************************************************************
!***********************************************************************************************************************************

    function constructRandomStartPointDomainUpperLimitVec(methodName) result(RandomStartPointDomainUpperLimitVecObj)
#if defined DLL_ENABLED && !defined CFI_ENABLED
        !DEC$ ATTRIBUTES DLLEXPORT :: constructRandomStartPointDomainUpperLimitVec
#endif
        use Constants_mod, only: NULL_RK
        use String_mod, only: num2str
        implicit none
        character(*), intent(in)                    :: methodName
        type(RandomStartPointDomainUpperLimitVec_type) :: RandomStartPointDomainUpperLimitVecObj
        RandomStartPointDomainUpperLimitVecObj%null = NULL_RK
        RandomStartPointDomainUpperLimitVecObj%desc = &
        "randomStartPointDomainUpperLimitVec represents the upper boundaries of the cubical domain from which the starting point(s) of &
        &the MCMC chain(s) will be initialized randomly (only if requested via the input variable randomStartPointRequested. &
        &This happens only when some or all of the elements of the input variable StartPoint are missing. &
        &In such cases, every missing value of input StartPoint will be set to the center point between randomStartPointDomainUpperLimitVec &
        &and randomStartPointDomainLowerLimitVec in the corresponding dimension. &
        &If RandomStartPointRequested=TRUE (or True, true, t, all case-insensitive), then the missing &
        &elements of StartPoint will be initialized to values drawn randomly from within the corresponding ranges specified by &
        &the input variable randomStartPointDomainUpperLimitVec. &
        &As an input variable, randomStartPointDomainUpperLimitVec is an ndim-dimensional vector of 64-bit real numbers, &
        &where ndim is the number of variables of the objective function. It is also possible to assign only select values of &
        &randomStartPointDomainUpperLimitVec and leave the rest of the components to be assigned the default value. &
        &This is POSSIBLE ONLY when randomStartPointDomainUpperLimitVec is defined inside the input file to "//methodName//". &
        &For example, having the following inside the input file, \n\n&
        &    randomStartPointDomainUpperLimitVec(3:5) = -100\n\n&
        &            will only set the upper limits of the third, fourth, and the fifth dimensions to -100, or,\n\n&
        &    randomStartPointDomainUpperLimitVec(1) = -100, randomStartPointDomainUpperLimitVec(2) = -1.e6 \n\n&
        &            will set the upper limit on the first dimension to -100, and 1.e6 on the second dimension, or,\n\n&
        &    randomStartPointDomainUpperLimitVec = 3*-2.5e100\n\n&
        &            will only set the upper limits on the first, second, and the third dimensions to -2.5*10^100, while the rest of &
                    &the upper limits for the missing dimensions will be automatically set to the default value.\n\n&
        &The default values for all elements of randomStartPointDomainUpperLimitVec are taken from the corresponding values in the input &
        &variable domainUpperLimitVec."
    end function constructRandomStartPointDomainUpperLimitVec

!***********************************************************************************************************************************
!***********************************************************************************************************************************

    subroutine nullifyNameListVar(RandomStartPointDomainUpperLimitVecObj,nd)
#if defined DLL_ENABLED && !defined CFI_ENABLED
        !DEC$ ATTRIBUTES DLLEXPORT :: nullifyNameListVar
#endif
        use Constants_mod, only: IK
        implicit none
        class(RandomStartPointDomainUpperLimitVec_type), intent(in)    :: RandomStartPointDomainUpperLimitVecObj
        integer(IK), intent(in)                                     :: nd
        if (allocated(randomStartPointDomainUpperLimitVec)) deallocate(randomStartPointDomainUpperLimitVec)
        allocate(randomStartPointDomainUpperLimitVec(nd))
        randomStartPointDomainUpperLimitVec = RandomStartPointDomainUpperLimitVecObj%null
    end subroutine nullifyNameListVar

!***********************************************************************************************************************************
!***********************************************************************************************************************************

    subroutine setRandomStartPointDomainUpperLimitVec(RandomStartPointDomainUpperLimitVecObj,randomStartPointDomainUpperLimitVec,domainUpperLimitVec)
#if defined DLL_ENABLED && !defined CFI_ENABLED
        !DEC$ ATTRIBUTES DLLEXPORT :: setRandomStartPointDomainUpperLimitVec
#endif
        use Constants_mod, only: IK, RK
        implicit none
        class(RandomStartPointDomainUpperLimitVec_type), intent(inout) :: RandomStartPointDomainUpperLimitVecObj
        real(RK), intent(in)                                        :: randomStartPointDomainUpperLimitVec(:)
        real(RK), intent(in)                                        :: domainUpperLimitVec(:)
        RandomStartPointDomainUpperLimitVecObj%Val = randomStartPointDomainUpperLimitVec
        where (RandomStartPointDomainUpperLimitVecObj%Val==RandomStartPointDomainUpperLimitVecObj%null)
            RandomStartPointDomainUpperLimitVecObj%Val = domainUpperLimitVec
        end where
    end subroutine setRandomStartPointDomainUpperLimitVec

!***********************************************************************************************************************************
!***********************************************************************************************************************************

    subroutine checkForSanity(RandomStartPointDomainUpperLimitVecObj,Err,methodName,randomStartPointDomainLowerLimitVec,domainUpperLimitVec)
#if defined DLL_ENABLED && !defined CFI_ENABLED
        !DEC$ ATTRIBUTES DLLEXPORT :: checkForSanity
#endif
        use Constants_mod, only: RK
        use Err_mod, only: Err_type
        use String_mod, only: num2str
        implicit none
        class(RandomStartPointDomainUpperLimitVec_type), intent(in)    :: RandomStartPointDomainUpperLimitVecObj
        real(RK), intent(in)                                        :: randomStartPointDomainLowerLimitVec(:), domainUpperLimitVec(:)
        character(*), intent(in)                                    :: methodName
        type(Err_type), intent(inout)                               :: Err
        character(*), parameter                                     :: PROCEDURE_NAME = "@checkForSanity()"
        integer                                                     :: i
        do i = 1,size(RandomStartPointDomainUpperLimitVecObj%Val(:))
            if ( RandomStartPointDomainUpperLimitVecObj%Val(i)>domainUpperLimitVec(i) ) then
                Err%occurred = .true.
                Err%msg =   Err%msg // &
                            MODULE_NAME // PROCEDURE_NAME // ": Error occurred. &
                            &The component " // num2str(i) // " of the variable randomStartPointDomainUpperLimitVec (" // &
                            num2str(RandomStartPointDomainUpperLimitVecObj%Val(i)) // &
                            ") cannot be larger than the corresponding component of the variable &
                            &domainUpperLimitVec (" // num2str(domainUpperLimitVec(i)) // "). If you don't know &
                            &an appropriate value to set for randomStartPointDomainUpperLimitVec, drop it from the input list. " // &
                            methodName // " will automatically assign an appropriate value to it.\n\n"
            end if
            if ( RandomStartPointDomainUpperLimitVecObj%Val(i)<=randomStartPointDomainLowerLimitVec(i) ) then
                Err%occurred = .true.
                Err%msg =   Err%msg // &
                            PROCEDURE_NAME // ": Error occurred. The input upper limit value in the component " // num2str(i) // &
                            " of the variable randomStartPointDomainUpperLimitVec cannot be smaller than or equal to the corresponding input &
                            &lower limit value in randomStartPointDomainLowerLimitVec:\n" // &
                            "    randomStartPointDomainLowerLimitVec(" // num2str(i) // ") = " // num2str(randomStartPointDomainLowerLimitVec(i)) // "\n" // &
                            "    randomStartPointDomainUpperLimitVec(" // num2str(i) // ") = " // num2str(RandomStartPointDomainUpperLimitVecObj%Val(i)) // "\n\n"
            end if
        end do
    end subroutine checkForSanity

!***********************************************************************************************************************************
!***********************************************************************************************************************************

end module SpecMCMC_RandomStartPointDomainUpperLimitVec_mod